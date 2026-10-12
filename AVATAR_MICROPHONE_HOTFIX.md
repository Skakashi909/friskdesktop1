# Frisk V106.0 — Avatar and microphone hotfix

## Confirmed code defect fixed
`frisk_pkg/dialogue.py` looked for `characters/frisk/avatar_fullbody.png` under `frisk_pkg/characters/`, but the asset is stored at the project root under `characters/frisk/`. That `FileNotFoundError` aborts the Tk dialogue UI startup, preventing the visible companion from appearing. The lookup now resolves from the project root.

## Microphone reliability changes
- Supports `FRISK_MIC_DEVICE_INDEX` to choose an explicit recording device when Windows' default input is wrong.
- Logs the enumerated recording-device names and indices to the voice log.
- Lowers the maximum energy threshold after calibration from 1200 to 850 and minimum to 180 so quiet speech is less likely to be gated out.
- Applies the same threshold bounds when recalibrating.

## Honest verification status
- Python source compilation: checked in this build environment.
- Avatar asset path: checked to resolve to the included root-level asset.
- Actual Tk display, microphone hardware capture, Whisper recognition, wake-word behavior, and Windows end-to-end run: **not testable in this environment**. This is a targeted hotfix, not a claim those runtime systems are now verified.
- The supplied avatar art is a PNG sprite, not a rigged Live2D/VRM model. This patch fixes visibility; it does not magically create skeletal animation.

If Windows still selects the wrong microphone, set `FRISK_MIC_DEVICE_INDEX` to the correct index shown in the voice log, then restart Frisk.
