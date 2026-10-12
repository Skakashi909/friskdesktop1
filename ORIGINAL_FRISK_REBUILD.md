# FRISK V106.0 — ORIGINAL FRISK REBUILD

This release is rebuilt from the original Frisk V100 codebase.

FriskDesktop is explicitly excluded. Its launcher, UI shell, native bridge merge, and identity are not used as the application base.

Startup is intentionally split into two paths:

1. Fast launch: create/use the user-owned Python venv, repair only missing core dependencies, then launch Frisk immediately.
2. Background maintenance: Rust/native build, native doctor, PC inventory refresh, Ollama installation/model provisioning, and automated tests run after Frisk is already alive.

Python is never discovered, installed, upgraded, replaced, or searched for. The only Python command accepted is FRISK_PYTHON when explicitly supplied, otherwise python.exe already supplied by the user.

The only release entry point is START_HERE.bat.
