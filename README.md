# FRISK V106.0 — Nova-inspired VMC avatar bridge patch

Current integrated Windows local-AI companion release.

## Start

Run `START_HERE.bat`. Frisk uses the user's existing Python command; it does not discover or install Python.

## What is included

- model-first natural conversation and relational memory
- continuous embodied agent runtime and background tasks
- Windows computer-use perception, UI Automation, mouse, keyboard and clipboard
- native Windows runtime and DPI-aware pointer fabric
- authenticated Frisk-Link / OS Link remote desktop control
- live screen feed with grounded mouse movement, click, drag, scroll and keyboard
- fullscreen/reconnect/clipboard/emergency-stop remote controls
- local voice, wake/follow-up attention and avatar embodiment
- optional VMC/OSC bridge for real rigged VTuber avatars; disabled unless explicitly enabled
- Discord, Minecraft, Roblox, browser, OBS/Wallpaper Engine foundations
- Google OAuth data fabric and official account-access architecture
- local Ollama/model management and optional grounded web research
- verification-first actions, failure learning, security and owner authorization

## OS Link

Open the authenticated Frisk-Link web surface to control the PC remotely. It is designed as a computer-control surface rather than a dashboard: live desktop, pointer, keyboard, clipboard, natural-language Frisk control, status and emergency stop. Browser HTTP/MJPEG polling is intentionally suppressed from the CMD so the local console remains readable.

## Console

Startup is intentionally visible. Frisk reports the major bootstrap phases without dumping raw pip/Rust/browser/web transport output. Normal useful runtime events remain visible. High-frequency HTTP/MJPEG/Cloudflare trace traffic is hidden. Errors remain visible and are persisted.

## Architecture

See `docs/FRISK_V100_MASTER_ARCHITECTURE.md` for the current unified architecture contract.

## Release

V106.0 is the current release with this VMC avatar bridge patch. Use this ZIP only; do not combine it with older Frisk folders. Memory, logs, and crash reports live under E:\Frisk\runtime. Python remains user-owned. See `docs/PROJECT_NOVA_VMC_AVATAR_INTEGRATION.md` for setup.

## V100 avatar note

V100 includes the full humanoid rig interface (hands/fingers/feet/toes/facial controls/IK/gaze/physics contracts). The included PNG is still a flat reference sheet; a true per-finger/per-toe visual avatar requires a separately authored Live2D or VRM model asset. V100 does not fake that limitation.

## Avatar reality check

The VMC bridge sends live expression and speech-envelope OSC messages to a separate VMC receiver. A compatible rigged VRM model and receiver must be installed and configured by the user. The flat reference sheet is not a 3D rig. Frisk no longer reports a Live2D/VRM file as rendered merely because the file exists.
