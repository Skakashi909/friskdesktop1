# Frisk development rules

Frisk is a Windows desktop companion. Preserve working behavior and make small, verified changes.

- Read [the project specification](docs/PROJECT_SPEC.md) before changing architecture.
- Keep user memory, logs, and configuration private; never overwrite memory without a validated backup.
- Keep voice, personality, routing, tools, and persistence separable.
- Dangerous desktop actions require confirmation and honest status reporting.
- Run focused tests and syntax checks for every changed subsystem, then update project state and changelog.

Detailed architecture, testing, security, and priorities live in `docs/`.
