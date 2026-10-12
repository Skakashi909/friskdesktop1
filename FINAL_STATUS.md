# FRISK V106.0 FINAL STATUS

V106.0 is the current integrated release. It is rebuilt from the current Frisk architecture, with an informative local console and quiet web transport.

## Release contract
- one ZIP
- one top-level release folder
- no legacy launchers
- Python remains user-owned
- web/MJPEG/Cloudflare transport does not flood CMD
- useful bootstrap/runtime events remain visible
- OS Link provides live remote computer control


## V106.0 startup correction

PowerShell native stderr is handled separately from process exit status so benign Python warnings cannot terminate dependency verification. The startup transcript is persisted under E:\Frisk\runtime\logs, and memory/database paths are explicitly rooted under E:\Frisk\runtime\memory.
