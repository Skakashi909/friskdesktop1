# V106.0 VMC avatar patch change log

- Added optional dependency-free OSC/VMC bridge for external VTuber avatar receivers.
- Wired live affect and TTS audio-frame state into VMC blendshape output.
- Added tests for OSC encoding, opt-in behavior, expression output, and bridge closure.
- Corrected Live2D/VRM adapter reporting: a model file's existence is not treated as proof that a renderer is implemented.
- Documented setup and limitations.
- Preserved user-owned Python and existing Frisk runtime/memory configuration.

This is not a claim that a rigged Frisk VRM model is included or that a Windows VSeeFace session was runtime-tested in this environment.
