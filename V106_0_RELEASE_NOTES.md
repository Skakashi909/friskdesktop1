# Frisk V106.0 — Original Frisk only

## Startup repair

- Fixes Windows PowerShell 5.1 handling of native Python stderr. A warning emitted by pywinauto must not terminate the dependency check while `$ErrorActionPreference` is `Stop`.
- Native process exit codes are checked explicitly; stdout/stderr text is shown in CMD and does not by itself determine success.
- Sets the documented COM STA preference before dependency imports and suppresses only pywinauto's known `Revert to STA COM threading mode` warning during the dependency probe.
- Applies the safe native-command wrapper to venv creation, dependency probing, pip repair, verification, and the Frisk process.
- Keeps memory, brain JSON, database, logs, and crash reports under `E:\Frisk\runtime\`.
- Original Frisk only. No Python detection, installation, upgrade, or replacement.

## Validation boundary

Python compile and automated tests run in the build environment. This does not substitute for running the package on the user's Windows PC; native Windows runtime behavior must be confirmed there.
