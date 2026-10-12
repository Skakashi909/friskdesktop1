"""Portable Frisk health check used by install scripts and CI."""
import compileall,importlib,sys
mods=['frisk_pkg.context','frisk_pkg.tasks','frisk_pkg.database.store','frisk_pkg.ai.model_manager','frisk_pkg.ai.decision','frisk_pkg.ai.cognitive_core','frisk_pkg.voice.pipeline','frisk_pkg.vision.perception','frisk_pkg.files.manager','frisk_pkg.gaming.troubleshooting','frisk_pkg.automation','frisk_pkg.integrations.manager']
failed=[]
if not compileall.compile_dir('frisk_pkg',quiet=1):failed.append('compile')
for m in mods:
 try:importlib.import_module(m)
 except Exception as e:failed.append(f'{m}: {e}')
print('Frisk health check:', 'PASS' if not failed else 'FAIL')
if failed:
 for x in failed:print(' -',x)
 sys.exit(1)
