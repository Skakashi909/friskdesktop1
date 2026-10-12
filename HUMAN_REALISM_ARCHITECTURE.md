# Frisk V100 — Human Realism Architecture

V100 is a human-performance rebuild, not an emotion preset.

## Core principle

Frisk must keep one stable speaker identity while allowing the *performance* of her words to change with:

- conversational meaning
- relationship context
- current affect
- uncertainty
- confidence
- urgency
- fatigue
- social engagement
- vulnerability/restraint
- the reason she is speaking
- the user's emotional state
- the current environment

The system must not reduce emotion to `happy -> speed`, `sad -> volume`, or any similar lookup table.

## Speech pipeline

```text
user audio/text
      ↓
semantic understanding
      ↓
user affect + relationship appraisal
      ↓
Frisk internal state
      ↓
response generation
      ↓
speech-performance direction
      ↓
expressive local TTS
      ↓
streamed audio + lip sync + facial acting + timing
```

The words are generated independently from the performance direction. The performance director cannot rewrite the dialogue.

## Expressive TTS

The preferred optional local backend is the official Qwen3-TTS family. Its Base models support short-reference voice cloning and its controllable models support natural-language voice/style control and streaming. Frisk keeps generated audio in memory and plays it directly; response WAV/MP3 files are not created by the runtime.

Configuration is deliberately opt-in because the model weights are large. If an expressive Qwen3-TTS model and a valid Frisk reference voice are present and enabled, it becomes the speech backend. Otherwise Frisk falls back to the existing local Kokoro path.

Reference voice configuration:

- `FRISK_QWEN3_ENABLED=1`
- `FRISK_QWEN3_MODEL_PATH=E:\Frisk\models\Qwen3-TTS-12Hz-0.6B-Base`
- `FRISK_QWEN3_REF_AUDIO=E:\Frisk\models\voice\frisk_reference.wav`
- `FRISK_QWEN3_REF_TEXT=` (optional when x-vector-only cloning is used)
- `FRISK_QWEN3_LANGUAGE=English`

## Conversation realism

Future layers should continue to improve:

- barge-in and interruption recovery
- turn-taking prediction
- backchannels
- speech overlap handling
- self-echo protection
- conversational repair
- session continuity
- memory retrieval on demand
- proactive behavior from context rather than timers alone
- facial gaze/blink/lip synchronization
- embodied idle behavior
- action acknowledgement before long tasks
- truthful verification after actions

These are separate systems from emotion classification. Human-like interaction emerges from their coordination.

## What V100 intentionally does not do

- no giant phrase dictionary
- no command-per-sentence conversational brain
- no fake consciousness claims
- no emotion keyword router
- no cloud TTS requirement
- no permanent response audio files
- no Python installation or Python discovery
- no replacement of the existing computer-use/security architecture

## Installing the expressive backend

The package is intentionally separated from Frisk's normal requirements because Qwen3-TTS has its own PyTorch/model compatibility and can consume substantial memory. The official project recommends installing `qwen-tts` in an isolated environment and provides 0.6B and 1.7B variants. Frisk never installs Python itself. citeturn5search0turn3search0

For this PC, the intended starting point is the 0.6B Base model for cloning. A 1.7B model can be selected later if the hardware budget permits it.

## V100 embodiment upgrade

V100 adds a renderer-neutral humanoid rig and turn-taking layer. The body is now represented as continuous joint/facial state rather than only named animation clips. The rig includes full hands, three-segment fingers, full feet, three-segment toes, jaw, eyes, gaze, blink, breathing, IK targets and secondary motion. TTS playback can emit audio-envelope frames to the avatar for continuous mouth movement.

The renderer boundary supports three truthful modes: the supplied flat reference sprite, a real Live2D Cubism model, or a real VRM 1.0 model. The reference sprite remains a fallback because a flattened image cannot contain independently deformable finger/toe/cloth meshes.
