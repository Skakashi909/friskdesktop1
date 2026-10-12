from pathlib import Path
import json, sys
root=Path(__file__).resolve().parent
required=[
 'VERSION.txt','BUILD_MANIFEST.json','README.md','START_HERE.bat','BOOTSTRAP_FRISK_E.ps1',
 'frisk_pkg/core.py','frisk_pkg/ai/model_manager.py','frisk_pkg/ai/cognitive_core.py',
 'frisk_pkg/intelligence/fabric.py','frisk_pkg/native_runtime.py','frisk_pkg/native_doctor.py',
 'frisk_pkg/murderbot_hud.py','frisk_pkg/ollama_bootstrap.py','frisk_pkg/companion_perception.py',
 'frisk_pkg/computer/pointer.py','THIRD_PARTY_AGENT_PATTERNS.md','V106_0_RELEASE_NOTES.md'
]
missing=[x for x in required if not (root/x).is_file()]
manifest=json.loads((root/'BUILD_MANIFEST.json').read_text())
issues=[]
if manifest.get('version')!='106.0': issues.append('manifest version')
if (root/'VERSION.txt').read_text().strip()!='106.0': issues.append('version file')
for pat in ['*.pyc','*.log','frisk_log_*.txt']:
    found=list(root.rglob(pat))
    if found: issues.append(f'{pat}: {len(found)}')
print('REQUIRED_MISSING', missing)
print('ISSUES', issues)
print('PYTHON_FILES', len(list((root/'frisk_pkg').rglob('*.py'))))
print('TEST_FILES', len(list((root/'tests').glob('test_*.py'))))
if missing or issues: sys.exit(1)
print('RELEASE_AUDIT=PASS')
