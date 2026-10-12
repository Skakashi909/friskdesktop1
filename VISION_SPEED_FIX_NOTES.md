# V106.0 Vision & Response Latency Fix

Changes in this patch:
- Vision provider timeout increased from 7s to 45s to allow local VLM inference on the GTX 1650 SUPER.
- Vision model keep-alive changed from 0 (unload immediately) to 5 minutes, avoiding repeated model reloads between observations.
- Default output limits reduced (fast: 72 tokens; reasoning: 256) to improve response latency without changing the model routing architecture.
- Background vision input resized to 896px and JPEG quality 68 to reduce image payload and GPU pressure.
- Background perception cadence is 5 seconds minimum and cooldown after repeated errors is 15 seconds.

Validation performed in this build environment: Python source compilation, ZIP integrity, and archive structure audit.
Not performed: Windows PowerShell parsing, Windows startup, GPU/VLM inference on the user's PC, microphone end-to-end tests.
