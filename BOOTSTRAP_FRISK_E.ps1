[CmdletBinding()]
param(
  [string]$Root = $(if ($env:FRISK_ROOT) { [Environment]::ExpandEnvironmentVariables($env:FRISK_ROOT) } else { 'E:\Frisk' }),
  [switch]$Launch,
  [switch]$Maintenance,
  [switch]$ForceRepair
)

# FRISK V106.0 — ORIGINAL FRISK ONLY
# FriskDesktop is NOT part of this release.
# Python is user-owned. Frisk never discovers, installs, upgrades, replaces,
# searches for, or inventories Python. It invokes only FRISK_PYTHON or python.exe.
$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

function Step([string]$Message) { Write-Host "[FRISK] $Message" -ForegroundColor Cyan }
function Fail([string]$Message) {
  Write-Host "[FRISK ERROR] $Message" -ForegroundColor Red
  try {
    if($Logs){ New-Item -ItemType Directory -Force -Path $Logs | Out-Null
      $stamp=[DateTime]::Now.ToString('yyyyMMdd_HHmmss')
      $report=Join-Path $Logs "bootstrap_error_$stamp.log"
      @(
        'FRISK BOOTSTRAP FAILURE'
        "time=$([DateTime]::Now.ToString('o'))"
        "stage=$Message"
        "source=$Source"
        "app=$App"
        "runtime=$Runtime"
        "python_command=$python"
        "python_executable=$venvPython"
        "last_powershell_error=$($Error[0])"
      ) | Set-Content -Encoding UTF8 -Path $report
      Write-Host "[FRISK ERROR] Bootstrap report: $report" -ForegroundColor Yellow
    }
  } catch { }
  try { Stop-Transcript | Out-Null } catch { }
  exit 1
}

if (-not (Test-Path 'E:\')) { Fail 'E: drive is required. Frisk keeps its private runtime on E:.' }
$Source = (Resolve-Path $PSScriptRoot).Path
$App = Join-Path $Root 'app'
$Runtime = Join-Path $Root 'runtime'
$Venv = Join-Path $Runtime '.venv'
$CargoHome = Join-Path $Runtime 'cargo'
$RustupHome = Join-Path $Runtime 'rustup'
$PipCache = Join-Path $Runtime 'pip-cache'
$Temp = Join-Path $Runtime 'temp'
$Target = Join-Path $Runtime 'cargo-target'
$Models = Join-Path $Root 'models\ollama'
$OllamaHome = Join-Path $Runtime 'ollama'
$Logs = Join-Path $Runtime 'logs'
$MaintenanceLog = Join-Path $Logs 'maintenance.log'

foreach ($p in @($Root,$Runtime,$App,$CargoHome,$RustupHome,$PipCache,$Temp,$Target,$Models,$OllamaHome,$Logs)) {
  New-Item -ItemType Directory -Force -Path $p | Out-Null
}
# Persist the visible CMD/PowerShell session to E: while keeping output live.
$BootstrapTranscript = if($env:FRISK_BOOT_LOG){$env:FRISK_BOOT_LOG}else{Join-Path $Logs 'bootstrap_console.log'}
try { Start-Transcript -Path $BootstrapTranscript -Append | Out-Null } catch { }
$MemoryDir = Join-Path $Runtime 'memory'
New-Item -ItemType Directory -Force -Path $MemoryDir | Out-Null
$env:FRISK_ROOT=$Root
$env:FRISK_RUNTIME=$Runtime
$env:FRISK_MEMORY_DIR=$MemoryDir
$env:FRISK_MEMORY_FILE=(Join-Path $MemoryDir 'frisk_memory.json')
$env:FRISK_BRAIN_FILE=(Join-Path $MemoryDir 'frisk_brain.json')
$env:FRISK_DATABASE_FILE=(Join-Path $MemoryDir 'frisk.db')

$env:CARGO_HOME=$CargoHome
$env:RUSTUP_HOME=$RustupHome
$env:PIP_CACHE_DIR=$PipCache
$env:TEMP=$Temp
$env:TMP=$Temp
$env:CARGO_TARGET_DIR=$Target
$env:OLLAMA_MODELS=$Models
$env:FRISK_ROOT=$Root
$env:FRISK_RUNTIME=$Runtime
$env:FRISK_OLLAMA_HOME=$OllamaHome
$env:PIP_NO_INPUT='1'
$env:PIP_DISABLE_PIP_VERSION_CHECK='1'
$env:PIP_PREFER_BINARY='1'

function Quote-Arg([string]$Value) {
  if ($null -eq $Value -or $Value.Length -eq 0) { return '""' }
  if ($Value -notmatch '[\s"]') { return $Value }
  return '"' + $Value.Replace('"','\"') + '"'
}

function Invoke-Captured([string]$Exe, [string[]]$Arguments, [string]$FailureLabel, [int]$TimeoutSeconds=900) {
  $stdout = Join-Path $Temp ("out_{0}.txt" -f ([guid]::NewGuid().ToString('N')))
  $stderr = Join-Path $Temp ("err_{0}.txt" -f ([guid]::NewGuid().ToString('N')))
  $argLine = (($Arguments | ForEach-Object { Quote-Arg ([string]$_) }) -join ' ')
  try {
    $proc = Start-Process -FilePath $Exe -ArgumentList $argLine -PassThru -WindowStyle Hidden -RedirectStandardOutput $stdout -RedirectStandardError $stderr -ErrorAction Stop
    if (-not $proc.WaitForExit($TimeoutSeconds * 1000)) {
      try { $proc.Kill() } catch {}
      Fail "$FailureLabel timed out after $TimeoutSeconds seconds."
    }
    if ($proc.ExitCode -ne 0) {
      $out = if(Test-Path $stdout){Get-Content $stdout -Raw -ErrorAction SilentlyContinue}else{''}
      $err = if(Test-Path $stderr){Get-Content $stderr -Raw -ErrorAction SilentlyContinue}else{''}
      $detail=(($out+"`n"+$err).Trim())
      if($detail.Length -gt 5000){$detail=$detail.Substring($detail.Length-5000)}
      Fail "$FailureLabel (exit code $($proc.ExitCode)).`n$detail"
    }
  } finally {
    Remove-Item $stdout,$stderr -Force -ErrorAction SilentlyContinue
  }
}

# Windows PowerShell 5.1 can turn native-program stderr (including Python
# warnings) into terminating NativeCommandError records when ErrorActionPreference
# is Stop. Native exit codes, not stderr text, determine success for Python/pip.
function Invoke-NativeVisible([string]$Exe, [string[]]$Arguments, [string]$Label) {
  $oldPreference = $ErrorActionPreference
  try {
    $ErrorActionPreference = 'Continue'
    & $Exe @Arguments 2>&1 | ForEach-Object { Write-Host ([string]$_) }
    $nativeExit = $LASTEXITCODE
    if ($null -eq $nativeExit) { $nativeExit = 1 }
    return [int]$nativeExit
  } catch {
    Write-Host "[FRISK ERROR] $Label could not run: $($_.Exception.Message)" -ForegroundColor Red
    return 9009
  } finally {
    $ErrorActionPreference = $oldPreference
  }
}

# -------------------- MAINTENANCE MODE --------------------
if ($Maintenance) {
  "[$([DateTime]::Now.ToString('s'))] Frisk background maintenance started" | Add-Content -LiteralPath $MaintenanceLog
  try {
    Set-Location $App
    $env:PATH="$CargoHome\bin;$Venv\Scripts;$env:PATH"
    $python = Join-Path $Venv 'Scripts\python.exe'
    if(-not (Test-Path $python)){ throw "Frisk venv is not ready yet." }

    function MRun([string[]]$CommandParts,[int]$Timeout=3600) {
      $line=("[{0}] python {1}" -f [DateTime]::Now.ToString('s'),($CommandParts -join ' '))
      Add-Content -LiteralPath $MaintenanceLog -Value $line
      $tag=[guid]::NewGuid().ToString('N')
      $out=Join-Path $Temp "maint_$tag.out.txt"
      $err=Join-Path $Temp "maint_$tag.err.txt"
      try {
        $p=Start-Process -FilePath $python -ArgumentList (($CommandParts|ForEach-Object{Quote-Arg $_}) -join ' ') -PassThru -Wait -WindowStyle Hidden -RedirectStandardOutput $out -RedirectStandardError $err -ErrorAction Stop
        if(Test-Path $out){Add-Content -LiteralPath $MaintenanceLog -Value (Get-Content $out -Raw -ErrorAction SilentlyContinue)}
        if(Test-Path $err){Add-Content -LiteralPath $MaintenanceLog -Value (Get-Content $err -Raw -ErrorAction SilentlyContinue)}
        if($p.ExitCode -ne 0){Add-Content -LiteralPath $MaintenanceLog -Value "EXIT=$($p.ExitCode)"}
      } catch { Add-Content -LiteralPath $MaintenanceLog -Value "ERROR: $($_.Exception.Message)" }
      finally { Remove-Item $out,$err -Force -ErrorAction SilentlyContinue }
    }

    # Native Rust is an enhancement, never a startup dependency.
    $rustc=Join-Path $CargoHome 'bin\rustc.exe'; $cargo=Join-Path $CargoHome 'bin\cargo.exe'; $rustup=Join-Path $CargoHome 'bin\rustup.exe'
    if(-not (Test-Path $rustc) -or -not (Test-Path $cargo) -or -not (Test-Path $rustup)){
      $installer=Join-Path $Temp 'rustup-init.exe'
      if(-not(Test-Path $installer)){
        try { Invoke-WebRequest -Uri 'https://static.rust-lang.org/rustup/dist/x86_64-pc-windows-msvc/rustup-init.exe' -OutFile $installer -TimeoutSec 120 } catch { Add-Content $MaintenanceLog "Rust download failed: $($_.Exception.Message)"; $installer=$null }
      }
      if($installer -and (Test-Path $installer)){
        try { Invoke-Captured $installer @('-y','--default-toolchain','stable','--profile','minimal','--no-modify-path') 'Rust installation failed' 900 } catch { Add-Content $MaintenanceLog "Rust install failed: $($_.Exception.Message)" }
      }
    }
    $rustup=Join-Path $CargoHome 'bin\rustup.exe'; $rustc=Join-Path $CargoHome 'bin\rustc.exe'
    if(Test-Path $rustup){ try { Invoke-Captured $rustup @('toolchain','install','stable','--profile','minimal') 'Rust toolchain repair failed' 900; Invoke-Captured $rustup @('default','stable') 'Rust default toolchain repair failed' 120; Invoke-Captured $rustup @('show','active-toolchain') 'Rust active toolchain verification failed' 60 } catch { Add-Content $MaintenanceLog "Rust repair skipped: $($_.Exception.Message)" } }
    if(Test-Path $rustc){ try { Invoke-Captured $rustc @('--version') 'rustc verification failed' 60 } catch {} }

    # Native extension is optional at runtime; build only in maintenance.
    $native=Join-Path $App 'native\frisk_native'
    if(Test-Path (Join-Path $native 'pyproject.toml')){
      try { & $python -m pip install 'maturin>=1.9.4,<2' --disable-pip-version-check --no-input *> (Join-Path $Temp 'maturin.log'); & $python -m maturin develop --release  *> (Join-Path $Temp 'native-build.log'); Add-Content $MaintenanceLog (Get-Content (Join-Path $Temp 'native-build.log') -Raw -ErrorAction SilentlyContinue) } catch { Add-Content $MaintenanceLog "Native build skipped/failed: $($_.Exception.Message)" }
    }

    MRun @('-m','frisk_pkg.native_doctor') 300
    MRun @('-m','frisk_pkg.system_inventory') 300
    # Ollama/model provisioning is deliberately last and never blocks Frisk.
    MRun @('-m','frisk_pkg.ollama_bootstrap') 7200
    MRun @('-m','pytest','-q',(Join-Path $App 'tests')) 1800
    Add-Content $MaintenanceLog "[$([DateTime]::Now.ToString('s'))] Background maintenance finished"
  } catch { Add-Content $MaintenanceLog "FATAL MAINTENANCE ERROR: $($_.Exception.Message)" }
  exit 0
}

# -------------------- FAST STARTUP --------------------
Step 'Starting Frisk bootstrap'
Step 'Preparing E:\Frisk runtime'
Write-Host "[FRISK] Bootstrap source: $Source"
Write-Host "[FRISK] Target app: $App"
Write-Host "[FRISK] User Python command: FRISK_PYTHON if set, otherwise python.exe"

if(-not ($Source.StartsWith($App,[System.StringComparison]::OrdinalIgnoreCase))){
  try {
    & robocopy $Source $App /MIR /R:1 /W:1 /XD .git .pytest_cache __pycache__ .venv runtime /NFL /NDL /NJH /NJS /NP | Out-Null
    if($LASTEXITCODE -gt 7){Fail "Frisk application sync failed (robocopy $LASTEXITCODE)."}
  } catch { Fail "Frisk application sync failed: $($_.Exception.Message)" }
}

Step 'Using the Python command supplied by the user'
$UserPython=if($env:FRISK_PYTHON){[Environment]::ExpandEnvironmentVariables($env:FRISK_PYTHON).Trim().Trim('"')}else{'python.exe'}
$venvPython=Join-Path $Venv 'Scripts\python.exe'
if(-not(Test-Path $venvPython)){
  Step 'Creating Frisk dependency environment on E:'
  $venvExit = Invoke-NativeVisible $UserPython @('-m','venv',$Venv) 'Python venv creation'
  if($venvExit -ne 0 -or -not(Test-Path $venvPython)){Fail "Could not create Frisk dependency environment using the user-owned Python (exit code $venvExit)."}
}

$env:PATH="$CargoHome\bin;$Venv\Scripts;$env:PATH"
Set-Location $App

# Install only core packages if they are genuinely missing. Never upgrade pip here.
$depsStamp=Join-Path $Runtime 'python-deps.ready'
$checker=Join-Path $Temp 'check_core_dependencies.py'
@'
import importlib
import sys
import warnings
# pywinauto documents STA mode when other imports initialized COM first.
sys.coinit_flags = 2
warnings.filterwarnings('ignore', message='Revert to STA COM threading mode', category=UserWarning)
mods = ["speech_recognition","pyautogui","psutil","win32api","pyaudio","pycaw","comtypes","pywinauto","sounddevice","discord","nacl","pyttsx3","vosk"]
missing = []
for name in mods:
    try:
        importlib.import_module(name)
    except BaseException as exc:
        missing.append("{}: {}: {}".format(name, type(exc).__name__, exc))
print("[FRISK] Missing/broken core modules:", flush=True)
if missing:
    for item in missing:
        print("[FRISK] " + item, flush=True)
    sys.exit(1)
print("[FRISK] NONE", flush=True)
'@ | Set-Content -Encoding UTF8 -Path $checker

Step 'Checking exactly which Python modules are missing'
# Never use python -c here. PowerShell quoting of embedded Python was the V102 failure.
$checkExit = Invoke-NativeVisible $venvPython @($checker) 'Core dependency checker'
if($checkExit -ne 0){
  Step 'Core Python packages are incomplete; repairing only the required Frisk environment'
  Step 'Installing/repairing requirements.txt with live output'
  $pipArgs = @('-m','pip','install','-r',(Join-Path $App 'requirements.txt'),'--disable-pip-version-check','--no-input')
  $pipExit = Invoke-NativeVisible $venvPython $pipArgs 'pip dependency repair'
  if($pipExit -ne 0){ Fail "Frisk core dependency repair failed (exit code $pipExit)." }
  Step 'Verifying repaired Python modules'
  $verifyExit = Invoke-NativeVisible $venvPython @($checker) 'Post-repair dependency checker'
  if($verifyExit -ne 0){ Fail "Python dependency verification failed (exit code $verifyExit)." }
  New-Item -ItemType File -Force -Path $depsStamp | Out-Null
} else {
  Write-Host '[FRISK] Core Python modules are already healthy.'
  New-Item -ItemType File -Force -Path $depsStamp | Out-Null
}

# Do not build Rust, run pytest, scan the PC, or pull models before Frisk exists.
# Those are maintenance tasks and run independently after the application launches.
Step 'Bootstrap complete — launching Frisk'
Step 'Launching Frisk now — maintenance continues in the background'
$maintArgs="-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" -Maintenance -Root `"$Root`""
try { Start-Process -FilePath 'powershell.exe' -ArgumentList $maintArgs -WindowStyle Hidden | Out-Null } catch { Add-Content $MaintenanceLog "Could not start background maintenance: $($_.Exception.Message)" }

if($Launch){
  Step 'Starting the actual Frisk process'
  $env:PYTHONUNBUFFERED='1'
  $friskExit = Invoke-NativeVisible $venvPython @('-u','-m','frisk_pkg.main') 'Frisk runtime'
  if($friskExit -ne 0){
    Write-Host "[FRISK ERROR] Frisk process exited with code $friskExit" -ForegroundColor Red
  }
  try { Stop-Transcript | Out-Null } catch { }
  exit $friskExit
}

try { Stop-Transcript | Out-Null } catch { }
exit 0
