# Frisk V106.0 audit status — 2026-10-09

## Changes applied in this audit build
- The initially registered Ollama vision provider now has a 45-second HTTP timeout (the previous startup path used 7 seconds; changing only dynamically discovered providers did not fix the usual startup path).
- On-demand screenshot vision now downsamples to 896 px wide and JPEG quality 68 before inference.
- Live-perception screenshot resize now actually produces an 896 px wide image; the previous branch calculated an 896-based height but resized to 1024 px wide.
- The previous vision/speed changes remain: vision model keep-alive 5 minutes, lower output caps, 5-second minimum sampling, and cooldown after repeated live vision errors.

## Validation performed in this environment
- `python -m pytest -q`: 104 passed.
- Python compilation: 214 `.py` files checked, 0 errors.
- ZIP archive integrity: checked after packaging.

## Not verified / not complete
- This environment is not the target Windows PC; the launcher, actual Ollama models, GPU inference, microphone, Whisper, TTS, Discord, OS Link, and end-to-end behavior have NOT been runtime-verified on the user's machine.
- The visible desktop companion currently displays `characters/frisk/avatar_fullbody.png` as a static image. This is not a rigged animated character.
- The package contains no `.vrm`, `.model3.json`, `.moc3`, or actual model textures/rig assets. Live2D and VRM renderer classes are adapters/contracts only; they do not render the character. Rig data and face/motion calculations do not themselves deform or draw a character.
- Current lip activity is passed as a speaking boolean in the core observer, not verified audio-driven visemes.
- Therefore the requested fully animated, rigged avatar (facial acting, gaze, true lip sync, body/hand/finger/toe articulation and cloth/hair physics) remains incomplete. Do not describe it as implemented until a compatible authored rig is supplied and connected to a real renderer.

## Important
This audit improves the vision path but does not prove that vision will be fast or reliable on the target PC. A 45-second timeout is a failure ceiling, not a latency guarantee. First inference can still be slow due to model loading, VRAM pressure, CPU fallback, or contention with speech models.
