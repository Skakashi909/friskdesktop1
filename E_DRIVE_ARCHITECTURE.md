# Frisk V68 E: Native Windows Apex Runtime

Frisk V68 keeps the AI mind in Python while adding a broader Rust/PyO3 Windows runtime.

## E: ownership

The installer owns the Frisk-specific runtime under `E:\Frisk`: Python venv, pip cache, Cargo/Rustup state, Rust build artifacts, temporary files, and Ollama model storage. Windows itself and the machine-wide Python installation are intentionally not moved.

## Native boundary

The native runtime provides DPI-aware virtual desktop geometry, monitor count, cursor movement, native mouse input, native keyboard input including Unicode, foreground-window metadata, window focus/rect queries, native process snapshots, and idle-time observation.

## Safety

The native layer does not become a second AI brain. Python remains responsible for model reasoning, memory, relationship state, tool policy and verification. Native failures fall back or report unavailable. Window focus remains confirmation-gated.
