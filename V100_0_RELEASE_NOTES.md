# FRISK V100.0 — Ultimate Rebuild

V100 is a structural rebuild of the current Frisk release rather than another cosmetic patch.

## Major changes

- Added a complete renderer-neutral humanoid rig with fingers, toes, hands, feet, jaw, eyes and facial controls.
- Added two-bone IK target solving.
- Added continuous gaze, blink, breathing and secondary-motion generation.
- Added Live2D and VRM renderer contracts with truthful capability boundaries.
- Added real-time TTS audio feature callbacks for continuous mouth movement.
- Added local conversational turn-taking state with barge-in/interruption handling.
- Removed the old emotion-to-rate/volume mapping from the main speech path; expressive TTS receives contextual performance direction while legacy voices use a stable identity baseline.
- Preserved the informative CMD startup phases while suppressing high-frequency web/HTTP/MJPEG/Cloudflare transport spam.
- Preserved strict user-owned Python policy: Frisk never searches for, installs, upgrades or replaces Python.
- Preserved Rust stable-toolchain repair and E: drive runtime ownership.
- Preserved the AnyDesk-style OS Link pointer/keyboard/screen architecture.
- Removed obsolete launcher files from the release.

## Validation

- 97 automated tests pass.
- Python compileall passes.
- Release audit passes after packaging cleanup.
- One ZIP, one top-level release folder.
