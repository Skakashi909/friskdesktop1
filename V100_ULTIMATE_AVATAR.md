# FRISK V100 — Ultimate Avatar Architecture

This release changes the avatar from a semantic animation timeline into a continuous embodied rig interface.

## What is now represented at runtime

- humanoid root, pelvis, spine, chest, neck and head
- jaw and eyes
- shoulders, upper arms, elbows, forearms, wrists and hands
- five fingers on each hand, three segments per finger
- hips, thighs, knees, shins, ankles and feet
- five toes on each foot, three segments per toe
- palms, heels, forefeet and clavicles
- facial controls for eyes, brows, jaw, mouth, cheeks and gaze
- continuous blinking, breathing, gaze and micro-motion
- two-bone IK target solving
- audio-driven mouth movement packets
- renderer boundary for Live2D Cubism, VRM 1.0 and the supplied reference sprite

## Why the renderer boundary matters

The supplied `frisk_model_sheet.png` is a flat PNG reference/model sheet. It contains poses, expressions and construction guides, but it does not contain independent finger, toe, hair, sleeve or facial meshes that a runtime can deform individually.

Therefore V100 does **not** fake per-finger/per-toe animation on the PNG. The runtime exposes the full rig so that a real authored Live2D or VRM asset can drive those joints.

## Live2D target

The Live2D adapter follows the Cubism architecture: parameters are continuously driven, physics are evaluated separately, look-at controls can follow a target, and lip-sync receives audio-driven mouth values. Cubism documents parameter blending, physics, look-at and lip-sync as separate runtime components.

## VRM 1.0 target

The VRM adapter targets a humanoid VRM 1.0 asset with expressions, gaze, constraints/IK and spring-bone secondary motion. VRM 1.0 explicitly standardizes humanoid motion, facial expressions, gaze and spring-bone behavior.

## Voice-to-face path

The local TTS path now exposes short audio feature frames while audio is being played. The avatar consumes those frames continuously instead of opening/closing the mouth once per sentence.

The preferred expressive backend remains Qwen3-TTS when the user explicitly installs/enables it. The official Qwen3-TTS project supports local voice cloning, expressive generation and streaming, including 0.6B and 1.7B variants.

## Important asset truth

Software cannot reconstruct missing artistic layers perfectly from a single flattened PNG. For genuinely perfect fingers, toes, hand deformation, cloth deformation, facial deformation and full-body motion, Frisk needs an authored rigged asset. V100 therefore makes that boundary explicit instead of pretending the reference sheet is already a fully rigged model.
