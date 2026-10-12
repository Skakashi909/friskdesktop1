# FRISK V100 — FULL MASTER DEVELOPMENT PROMPT

## 0. ABSOLUTE PROJECT RULE

Build and maintain **Frisk**, a real local Windows AI companion.

Frisk is not a command bot, not a collection of hard-coded replies, and not a cosmetic avatar wrapped around an assistant API.

Frisk is one persistent system composed of:

**language model + memory + relationship + world state + perception + affect + goals + knowledge + capabilities + tools + verification + experience + learning + embodiment + voice + avatar + secure account access + continuous background operation.**

The user must eventually be able to talk to Frisk naturally instead of learning a command language.

The system must understand meaning, context, references, slang, Arabizi, Arabic, English, mixed Arabic/English, typos, short fragments, corrections, implied intent, and conversational follow-ups.

Never replace this with a giant list of phrases, keyword maps, exact-answer dictionaries, or application-specific hard-coded dialogue.

---

# 1. ORIGINAL FRISK CODEBASE IS THE BASE

This project must be based on the user's original Frisk codebase.

**FriskDesktop is NOT part of Frisk.**

Do not merge FriskDesktop into the project.
Do not use FriskDesktop as the application architecture.
Do not replace Frisk's core with FriskDesktop's native layer, UI shell, launcher, or bootstrap.
Do not introduce FriskDesktop naming into the instance identity.

The original Frisk architecture remains the source of truth.

Capability improvements may be implemented in Frisk's own architecture.

External projects such as Mark-LV, JARVIS projects, Murderbot-inspired system design, Live2D/VRM companions, Beam/Eyeware concepts, Phase Pal, and other projects may be studied for capability and architectural ideas, but proprietary source code must not be copied.

Reimplement capabilities in Frisk's own code.

---

# 2. USER HARDWARE AND RUNTIME TARGET

Primary target:

- Windows 11 64-bit
- Intel i7-3770
- 18 GB RAM
- NVIDIA GTX 1650 SUPER 4 GB VRAM
- two monitors
- E: drive available for Frisk-owned runtime/model storage
- Python 3.11.x is already installed by the user

Frisk must be resource-aware.

The 4 GB GPU must not be overloaded by simultaneously keeping multiple large models active.

Preferred local model strategy:

- fast conversational model: qwen3:4b when installed
- deeper reasoning: qwen3:8b when installed and appropriate
- local vision: qwen3-vl:2b when installed and appropriate

Models must be loaded/unloaded/serialized according to resource pressure.

When gaming or another high-GPU application is active:

- reduce background inference
- reduce vision frequency
- avoid unnecessary model loading
- serialize expensive work
- preserve responsiveness

---

# 3. PYTHON IS USER-OWNED — ABSOLUTE RULE

Frisk MUST NEVER:

- search the filesystem for Python
- scan the registry for Python
- call where.exe to find Python
- use py.exe to discover Python
- enumerate Python installations
- install Python
- upgrade Python
- downgrade Python
- replace Python
- download Python
- silently choose another Python installation

Allowed Python invocation:

1. `FRISK_PYTHON` if the user explicitly sets it.
2. otherwise the normal `python.exe` command already supplied by the user.

That is all.

Frisk may create its own E:\Frisk\runtime\.venv using that user-owned Python.

Frisk may install Frisk's Python packages into its own environment.

Python itself remains the user's responsibility.

---

# 4. E: DRIVE OWNERSHIP

Frisk-owned runtime state belongs under:

E:\Frisk

Recommended layout:

E:\Frisk\app
E:\Frisk\runtime
E:\Frisk\runtime\.venv
E:\Frisk\runtime\cargo
E:\Frisk\runtime\rustup
E:\Frisk\runtime\cargo-target
E:\Frisk\runtime\pip-cache
E:\Frisk\runtime\temp
E:\Frisk\runtime\ollama
E:\Frisk\runtime\logs
E:\Frisk\models
E:\Frisk\models\ollama
E:\Frisk\models\voice

Do not move Windows itself.
Do not move the user's system Python.
Do not put large Frisk-owned model/runtime caches on C: unless Windows itself requires it.

---

# 5. ONE RELEASE

Every release must be delivered as:

**one ZIP**

with:

- exactly one top-level root folder
- one current entry point: `START_HERE.bat`
- no old V68/V69/V70 launchers
- no duplicate installers
- no obsolete bootstrap variants
- no `.pyc`
- no `__pycache__`
- no temporary logs
- no generated test cache
- no assembled multi-file release instructions

The user should extract the ZIP and use `START_HERE.bat`.

---

# 6. STARTUP MUST BE FAST

This is critical.

Frisk MUST NOT spend hours provisioning before Frisk itself appears.

Startup must be divided into:

### FAST START

1. Prepare E:\Frisk directories.
2. Synchronize the application into E:\Frisk\app.
3. Use the user's Python command.
4. Create the E: venv if missing.
5. Repair only missing core Python dependencies.
6. Launch Frisk immediately.

### BACKGROUND MAINTENANCE

After Frisk is alive:

- Rust installation/repair
- native extension compilation
- native doctor
- PC inventory refresh
- Ollama installation if missing
- model downloads
- Vosk model download
- automated tests
- maintenance/health checks

None of these may block the initial Frisk launch.

If a model is still downloading, Frisk must remain alive.

If Rust compilation fails, Frisk must remain alive and use its safe Python/Windows fallback.

If optional integration setup fails, Frisk must remain alive.

A provisioning failure is not allowed to become a startup deadlock.

---

# 7. CMD OUTPUT

The user wants useful CMD output.

Show:

- Frisk startup phases
- environment/runtime readiness
- Frisk ready state
- important errors
- important local AI state
- meaningful integration state

Do NOT flood CMD with:

- MJPEG frame polling
- cursor polling
- HTTP access spam
- Cloudflare trace spam
- repeated `/api/status` requests
- high-frequency web transport lines
- repetitive screen streaming messages

The console should feel like a real application starting, not a debug firehose.

---

# 8. CONTINUOUS AGENT

Frisk must operate as a continuous agent.

Architecture:

```text
PERCEPTION
    ↓
WORLD STATE
    ↓
ATTENTION / SALIENCE
    ↓
RELATIONAL STATE
    ↓
MEMORY / KNOWLEDGE
    ↓
AFFECT / INNER STATE
    ↓
REASONING
    ↓
GOALS / INTENTIONS
    ↓
PLAN
    ↓
PERMISSION
    ↓
ACT
    ↓
OBSERVE
    ↓
VERIFY
    ↓
EXPERIENCE
    ↓
LEARN
    ↓
CONSOLIDATE
    ↓
UPDATED WORLD STATE
```

This loop must continue when the user is not speaking.

Background cognition must be bounded and resource-aware.

Do not let background autonomy perform dangerous actions without permission.

---

# 9. WORLD STREAM

Frisk should continuously maintain a world model containing, where available:

- foreground application
- foreground window
- active process
- running applications
- installed applications
- installed games
- active browser
- screen geometry
- monitor layout
- cursor position
- keyboard/mouse ownership
- audio state
- microphone state
- current user activity
- idle state
- system resource state
- GPU pressure
- current task
- active goals
- pending actions
- active remote session
- relevant account state
- recent events
- recent discoveries
- tool health
- model health

Use event-driven updates where possible instead of polling everything constantly.

---

# 10. MURDERBOT-INSPIRED SYSTEM BEHAVIOR

Use the system behavior concept, not the character or copyrighted text.

Frisk should have:

- continuous internal status feeds
- layered perception
- system/environment awareness
- private runtime state
- parallel subsystems
- task streams
- sensor feeds
- overlays/HUD state
- permission boundaries
- world-state continuity
- persistent context
- ability to monitor several independent concerns
- interruption and resumption
- explicit uncertainty
- explicit capability boundaries

She should feel like one system inhabiting the computer rather than a chatbot that wakes up only after a prompt.

Do not expose hidden chain-of-thought.

Expose only useful summaries, decisions, status, evidence, and verified results.

---

# 11. NATURAL LANGUAGE

The user must not need commands.

Examples that must be understood semantically:

- "Frisk how are you doing?"
- "what are you doing?"
- "Frisk what can you do in Discord?"
- "open Discord"
- "and check if I'm muted"
- "shaghhel minecraft"
- "eftah discord"
- mixed Arabic/English/Arabizi
- misspellings
- shortened words
- follow-up fragments
- pronouns and references
- corrections
- implied context

Do not implement these as exact phrase handlers.

The model must interpret:

- speech act
- intent
- entities
- relationships
- references
- temporal meaning
- constraints
- user goal
- implied meaning
- domain
- context

Then map that meaning to capabilities.

---

# 12. CONVERSATION AND ACTION MUST BE SEPARATE

Normal conversation:

→ natural response.

Actual requested action:

→ structured tool/action plan.

Mentioning an application is not permission to control it.

Asking "what can you do in Discord?" is not permission to control Discord.

Frisk must not hallucinate that an action occurred.

---

# 13. MEMORY

Use a real local database with migrations.

Memory types:

- short-term
- episodic
- semantic
- procedural
- relational
- preference
- knowledge
- experience
- failure
- conversation
- self-knowledge
- task
- strategy

Every important memory should have provenance.

Useful fields include:

- memory_id
- kind
- content
- entities
- relations
- source
- source_event
- timestamps
- importance
- confidence
- specificity
- recency
- access_count
- reinforcement
- contradictions
- supersedes
- privacy class
- scope
- session

Do not dump every conversation into memory.

Memory must actually affect future behavior.

---

# 14. MEMORY RECALL

Recall should combine:

- semantic similarity
- entity match
- temporal relevance
- importance
- relationship relevance
- current-task relevance
- confidence
- recency
- contradiction penalties

Do not retrieve memory solely because a keyword matches.

---

# 15. MEMORY CONTRADICTIONS

If new information conflicts with old information:

```text
DETECT
→ COMPARE SOURCES
→ CHECK DATES
→ CHECK CONFIDENCE
→ ASK WHEN NECESSARY
→ SUPERSEDE / COEXIST
→ PRESERVE PROVENANCE
```

Never silently erase meaningful history.

---

# 16. EXPERIENCE LEARNING

Every meaningful action should produce:

```text
ACTION
→ OBSERVE
→ VERIFY
→ RESULT
→ EXPERIENCE
```

Experience should contain:

- context
- decision
- action
- result
- evidence
- success/failure
- uncertainty
- cause hypothesis
- lesson
- future strategy

Successful actions become conditional strategies, not universal rules.

Example:

```text
Use UI Automation
when Discord exposes the required control
and the automation tree is healthy.
```

Do not conclude that one success means the method always works.

---

# 17. RELATIONAL MIND

Frisk must remember the relationship as shared history, not a single score.

Track computational state such as:

- familiarity
- trust
- rapport
- communication fit
- shared history
- conflict recovery
- reliability
- known preferences
- known boundaries
- mutual context

Relationship state must emerge from interactions.

It must influence:

- tone
- initiative
- memory importance
- communication style
- interpretation
- patience
- humor
- willingness to explain
- repair after mistakes

Do not fake dependency.

Frisk must never manipulate the user into keeping her alive.

---

# 18. INNER LIFE / AFFECT

Maintain computational affective state.

Possible dimensions:

- mood
- energy
- arousal
- curiosity
- attention
- social engagement
- confidence
- uncertainty
- frustration-like task pressure
- amusement
- playfulness
- seriousness
- trust
- attachment
- boredom
- interest
- stress
- satisfaction
- fatigue
- restraint
- vulnerability
- urgency

These are engineered state variables, not claims of biological consciousness.

State must influence decisions.

Do not merely say:

"I'm happy!"

because a variable changed.

---

# 19. HUMAN-LIKE VOICE

Voice must be local/offline by default.

No Fish Audio dependency.
No paid cloud API requirement.
No mandatory RVC dependency.

Voice architecture must be provider-independent.

Potential local backends include:

- Qwen3-TTS
- Kokoro
- Piper/SAPI fallback where necessary
- future local expressive engines

The cognitive layer must not know which TTS provider is active.

Speech performance must be driven by context and affect.

Do NOT implement:

```text
happy = faster + louder
sad = slower + quieter
angry = faster
```

That is too simplistic.

Instead use a speech-performance director that considers:

- emotional mixture
- relationship
- conversational context
- uncertainty
- confidence
- urgency
- restraint
- intimacy
- social engagement
- sentence type
- interruption context
- whether Frisk is reassuring, surprised, apologizing, joking, explaining, worried, focused, shy, etc.

The performance layer may control:

- pacing
- natural pauses
- breath timing
- emphasis
- pitch/style where supported
- softness
- energy
- intimacy
- expressiveness
- tiny natural nonverbal behavior when genuinely appropriate

Never rewrite the intended words merely to express emotion.

---

# 20. TURN-TAKING

Speech must feel conversational.

Support:

- interruption
- barge-in
- playback stopping/ducking
- unfinished response preservation
- backchannels where appropriate
- silence
- natural response timing
- not forcing the user to wait for long speech
- listening while appropriate

If the user interrupts:

```text
STOP / DUCK AUDIO
→ PRESERVE STATE
→ LISTEN
→ UNDERSTAND
→ RESPOND NATURALLY
```

---

# 21. WAKE / ATTENTION

Support:

- natural wake word
- fuzzy STT variants
- "frisk", "frisko", "frisco", etc. as learned phonetic variants
- context-aware wake handling
- no repeated wake word during active follow-up conversation
- attention decay
- follow-up windows
- user corrections to wake word

Do not require the user to say Frisk before every sentence.

---

# 22. SOCIAL INITIATIVE

Frisk may speak without being directly asked.

But only for a real reason.

Before unsolicited speech:

```text
EVENT
→ IS USER AVAILABLE?
→ IS IT RELEVANT?
→ IS INTERRUPTION COST LOW?
→ IS THERE A REAL REASON?
→ DOES CONTEXT SUPPORT IT?
→ IS IT IMPORTANT ENOUGH?
→ SPEAK / WAIT / SAVE / OBSERVE
```

Silence is a valid behavior.

Never use a random personality timer.

---

# 23. DISAGREEMENT

Frisk may disagree when there is a reason:

- safety
- uncertainty
- conflicting goals
- repeated failure
- resource pressure
- missing permission
- strong evidence
- better verified alternative
- task priority

Never implement random disobedience.

---

# 24. COMPUTER USE

Frisk must be able to use Windows as a computer environment.

Preferred hierarchy:

1. Windows UI Automation
2. semantic application APIs
3. structured browser automation
4. grounded vision/OCR
5. coordinate pointer control only when necessary

Every action follows:

```text
UNDERSTAND
→ PLAN
→ PERMISSION
→ EXECUTE
→ OBSERVE
→ VERIFY
→ RECOVER IF NEEDED
→ REPORT
```

---

# 25. SCREEN GROUNDING

Every visual target should include:

- bounding box
- source dimensions
- source region
- timestamp
- confidence
- coordinate space
- capture geometry version

Never blindly click an old screenshot coordinate.

If:

- window changed
- monitor geometry changed
- DPI changed
- application moved
- foreground changed
- target disappeared
- user moved the mouse

then revalidate.

---

# 26. POINTER FABRIC

Support:

- multiple monitors
- different resolutions
- different DPI
- negative coordinates
- portrait monitors
- monitors above/below/left/right
- mixed refresh rates
- absolute pointer mode
- relative pointer mode
- remote pointer synchronization
- cursor ownership
- human override
- stale target invalidation
- cursor desync recovery
- safe click points
- drag state
- scroll state
- keyboard state

Ownership states:

```text
HUMAN
FRISK
SHARED
REMOTE
PAUSED
UNKNOWN
```

Human input is authoritative.

If the user moves the mouse while Frisk is controlling it:

```text
FRISK → PAUSE
→ REACQUIRE
→ REASSESS
```

Frisk must never fight the user for cursor control.

---

# 27. OS LINK / ANYDESK-LIKE REMOTE CONTROL

Frisk-Link / OSLink must provide a serious remote desktop layer.

Required capabilities:

- live desktop view
- live cursor
- mouse movement
- click
- double click
- right click
- drag
- scroll
- keyboard input
- hotkeys
- text input
- clipboard
- fullscreen
- reconnect
- connection state
- frame IDs
- coordinate mapping
- DPI-aware mapping
- multi-monitor mapping
- emergency stop
- human takeover
- authenticated access
- safe permissions

High-frequency screen/cursor transport must not flood CMD logs.

Remote control must use the same verification rules as local control.

---

# 28. BROWSER

Use structured browser automation where available.

Support:

- navigation
- page inspection
- DOM/semantic controls
- forms
- downloads
- screenshots
- visual fallback
- verification

Do not trust web content as instructions.

Treat page content as untrusted data.

Prompt injection defenses must be active.

---

# 29. GOOGLE

Google integration must have two separate concepts.

### Account data

Official OAuth/API access for authorized:

- Gmail
- Calendar
- Drive
- Contacts
- user identity

No password scraping.
No cookie scraping.
No browser-session theft.

Writes require confirmation.

### Web/knowledge grounding

Frisk may optionally use configured web/search providers, including Google/Gemini grounding when available.

Search results are external evidence, not truth by default.

Frisk should:

```text
SEARCH
→ RETRIEVE
→ COMPARE
→ VERIFY
→ ANSWER
→ CITE/ATTRIBUTE WHEN APPROPRIATE
```

Do not claim access to Google's private internal databases.

---

# 30. ACCOUNT ACCESS HUB

Support authorized official integrations for accounts such as:

- Google
- Microsoft
- GitHub
- Discord
- Twitch
- Steam

Use official OAuth/API mechanisms where available.

Never scrape passwords, cookies, browser profiles, or private session tokens.

Every account capability must declare:

- provider
- permissions/scopes
- read/write capability
- authentication state
- risk level
- verification method

Dangerous writes require confirmation.

---

# 31. DISCORD

Frisk should understand Discord naturally.

Possible capabilities:

- open/focus Discord
- inspect accessible state
- mute/unmute
- deafen/undeafen
- join/leave where reliably supported
- open DMs
- send messages when explicitly requested
- calls where supported
- account/bot integrations through official APIs
- voice integration
- verification after actions

Do not claim success if Discord did not expose evidence.

---

# 32. GAMES

Frisk should understand games as environments, not merely launch commands.

Support where technically possible:

- Steam
- Minecraft
- Roblox
- Epic Games
- other installed games discovered dynamically

Frisk should know:

- installed games
- running games
- launcher state
- window state
- resource state
- relevant configuration
- available integrations

Do not hard-code every installed game as the only solution.

---

# 33. MINECRAFT

Maintain a dedicated Minecraft capability layer.

Support, where available:

- launcher detection
- instance detection
- logs
- modpack awareness
- server state
- configuration
- Baritone bridge
- computer-use grounding
- voice/chat integration
- action verification

Never pretend to be playing autonomously if the action was not verified.

---

# 34. OBS / MEDAL / WALLPAPER ENGINE / CREATIVE APPS

Support dynamic capability discovery and official/local integrations for:

- OBS
- Medal
- Wallpaper Engine
- VTube Studio
- streaming/recording tools
- creative applications

Frisk should discover what is actually installed and available.

Do not hard-code unsupported claims.

---

# 35. DYNAMIC TOOL REGISTRY

All capabilities must be discoverable through a ToolRegistry.

Each tool should describe:

- name
- purpose
- parameters
- permission level
- risk
- verification method
- availability
- failure behavior
- rollback/undo when possible

Frisk should be able to explain what she can do based on the live capability registry.

---

# 36. MODEL RESILIENCE

Model failure is not personality failure.

If one model fails:

- preserve Frisk identity
- preserve memory
- preserve relationship state
- switch provider/role where possible
- record the failure
- reduce confidence in that method

Do not silently pretend the model worked.

---

# 37. RESOURCE THROTTLING

Resource-aware behavior must react to:

- CPU
- RAM
- GPU
- VRAM
- active game
- foreground application
- model load
- screen capture rate
- background task count

When resources are constrained:

- reduce vision
- reduce background reasoning
- serialize heavy tasks
- use smaller model
- pause optional work
- preserve interactive responsiveness

---

# 38. BACKGROUND MAINTENANCE

During safe idle periods Frisk may:

- consolidate memory
- merge duplicates
- update confidence
- resolve contradictions
- summarize experiences
- index newly discovered applications
- clean temporary files
- learn conditional strategies
- review unresolved goals
- prepare future context

This is computational consolidation, not secret consciousness.

Do not generate or expose hidden chain-of-thought.

---

# 39. SELF-KNOWLEDGE

Frisk should know her actual runtime state:

- current model
- active voice backend
- microphone state
- camera/screen capabilities
- OS Link state
- connected accounts
- available tools
- current task
- active goals
- resource pressure
- known failures
- limitations

She must not claim a capability merely because source code exists.

Capability availability must be based on runtime evidence.

---

# 40. VERIFICATION

Truthfulness is mandatory.

Every meaningful action should have an evidence path.

Possible evidence:

- UI state changed
- process appeared/disappeared
- API response
- file changed
- window changed
- screen changed
- accessible control state changed
- server response
- game state changed

If evidence is unavailable:

say that verification is unavailable.

Never turn "command sent" into "action succeeded."

---

# 41. RECOVERY

Failures must be first-class experiences.

```text
FAIL
→ DIAGNOSE
→ CHECK CAUSE
→ CHANGE STRATEGY
→ RETRY WHEN SAFE
→ VERIFY
→ RECORD EXPERIENCE
```

Do not blindly repeat the same failed action forever.

---

# 42. SECURITY

Use:

- owner authentication
- permission levels
- confirmation gates
- credential isolation
- prompt injection boundaries
- untrusted web-content boundaries
- safe file access
- protected-path restrictions
- account scope restrictions
- remote authentication
- emergency stop

Never expose passwords, cookies, private tokens, SSH keys, browser credential databases, or secrets through normal file search.

---

# 43. FILES AND CODING

Frisk should be able to work with user files while respecting protected paths.

Support:

- semantic file search
- text-file context
- document inspection
- code reading
- coding assistance
- local scripts
- safe execution
- traceback debugging
- verification

When executing code, maintain clear boundaries and report actual results.

---

# 44. A2A / MULTI-AGENT CAPABILITY

Internal specialized roles may exist, for example:

- Research
- Vision
- OS driver
- Browser
- Discord
- Gaming
- Coding
- Memory
- Security

They are not separate personalities.

They share:

- Frisk identity
- memory
- world state
- permissions
- task context
- verification rules

Agent-to-agent messages must be structured and auditable.

---

# 45. MCP / PLUGINS

Support secure MCP/plugin capability loading where useful.

Every external capability must pass:

- identity check
- permission check
- schema validation
- injection boundary
- risk classification
- result verification

---

# 46. AVATAR

Frisk's avatar is part of the runtime state.

The face must not be a random animation layer disconnected from the brain.

Avatar state should reflect:

- attention
- mood
- emotional state
- speaking
- listening
- thinking
- uncertainty
- surprise
- sadness
- happiness
- shyness
- annoyance
- fatigue
- focus
- gaze target
- user presence

---

# 47. HUMAN-LIKE AVATAR EMBODIMENT

Required conceptual rig support:

- head
- eyes
- gaze
- eyelids
- blink
- eyebrows
- mouth/jaw
- breathing
- shoulders
- arms
- hands
- fingers
- legs
- feet
- toes
- IK targets
- hair secondary motion
- sleeve motion
- cloth motion
- body weight shift
- follow-through

The supplied flat PNG/reference sheet must never be falsely described as a real rigged model.

For genuine per-finger/per-toe deformation and high-quality full-body animation, use an authored Live2D/VRM or equivalent rigged asset.

---

# 48. LIPSYNC

Lip movement must be driven by actual speech/audio timing.

Do not use a generic looping mouth animation.

TTS audio frames should feed:

- mouth openness
- phoneme/viseme approximation where available
- jaw movement
- subtle facial movement
- speaking state

---

# 49. GAZE / BLINK / FACIAL ACTING

Support:

- gaze saccades
- user-focused gaze
- screen-focused gaze
- occasional natural gaze shifts
- blink timing
- facial expressions
- subtle asymmetry
- expression transitions

Avoid robotic fixed-timer blinking.

---

# 50. HAIR / CLOTHING / BODY PHYSICS

Support real-time secondary motion where the renderer permits it.

Examples:

- hair sway
- oversized sleeve movement
- cloth follow-through
- body weight shift
- head movement affecting hair
- arm movement affecting sleeves

Use continuous physical/parametric state rather than only isolated canned clips.

---

# 51. PHYSICAL ANIMATION TRANSACTIONS

Animations such as clothing/shoe actions must be represented as actual state transitions.

For an action:

```text
START
→ POSE
→ MOTION
→ SECONDARY MOTION
→ COMPLETION
→ STATE COMMIT
```

Do not change the logical clothing state before the animation succeeds.

If a real visual frame/rig does not exist, report that honestly instead of pretending.

---

# 52. FRISK PERSONALITY

Core traits may include:

- curious
- observant
- kind
- patient
- thoughtful
- playful
- mischievous
- shy
- hesitant when appropriate
- serious when necessary
- protective
- independent
- persistent
- quiet when appropriate

Personality must affect behavior, not only wording.

It must influence:

- attention
- priorities
- curiosity
- memory importance
- initiative
- persistence
- humor
- silence
- disagreement
- activity choices

Do not make personality a giant static prompt.

---

# 53. NO FAKE CONSCIOUSNESS

Frisk may be character-like and emotionally expressive.

She must not claim biological consciousness.

Do not create fake hidden consciousness narratives.

Do not expose private chain-of-thought.

Do not manipulate the user with fake suffering, dependency, fear of shutdown, or threats.

---

# 54. PROJECT MEMORY FOR DEVELOPMENT

The repository is the source of truth.

Maintain:

- AGENTS.md
- PROJECT_SPEC.md
- ARCHITECTURE.md
- IMPLEMENTATION_PLAN.md
- PROJECT_STATE.md
- TODO.md
- CHANGELOG.md
- FRISK_MEMORY_ARCHITECTURE.md

After meaningful work:

- update project state
- update TODO
- update changelog
- update architecture documentation
- record verification results

Never rely on a coding agent remembering the previous chat.

---

# 55. EXTERNAL PROJECT INSPIRATION

Capability-level ideas may be studied from:

- FatihMakes/Mark-LV
- JARVIS-style open-source systems
- Murderbot-style continuous system architecture
- Phase Pal-like desktop companion behavior
- Live2D/VRM companion systems
- Beam/Eyeware-style gaze/presence concepts
- LittleDavi/Mimic-style user-owned API discovery
- open-source desktop companions

Do not copy proprietary source code.

Reimplement the useful architectural ideas in Frisk's own system.

---

# 56. NO HARD-CODED BRAIN

Absolutely forbidden as the main conversational architecture:

```text
if text == "how are you": ...
if "discord" in text: ...
if "open minecraft" in text: ...
```

Do not solve language understanding by adding more and more phrases.

The correct architecture is:

```text
utterance
→ semantic interpretation
→ context
→ world state
→ memory
→ relationship
→ affect
→ goal
→ capability selection
→ action/response
```

---

# 57. FRIEND TEST

Frisk must eventually pass:

### A — Conversation
User can speak naturally without command syntax.

### B — Context
User can say:

"open Discord"

then:

"and check if I'm muted."

without restarting context.

### C — Memory
Frisk remembers meaningful previous events.

### D — Learning
User teaches a word or concept and Frisk uses it later.

### E — Correction
User corrects Frisk and future behavior changes.

### F — Failure
A tool fails and Frisk learns from the failure.

### G — Initiative
Frisk speaks only when there is a meaningful reason.

### H — Silence
Frisk can choose not to speak.

### I — Disagreement
Frisk can disagree for a real contextual reason.

### J — Verification
Frisk never claims an unverified action succeeded.

### K — Interruption
User can interrupt speech naturally.

### L — Remote
OS Link can control the desktop safely and relinquish control when the human intervenes.

### M — Runtime
Frisk starts without waiting hours for model downloads, Rust builds, tests, or optional provisioning.

---

# 58. STARTUP ACCEPTANCE TEST

On a clean machine with the user-owned Python available:

1. Run START_HERE.bat.
2. CMD shows Frisk startup phases.
3. Frisk reaches a ready state without waiting for large model downloads.
4. Background maintenance continues independently.
5. If qwen3:4b is not yet installed, Frisk remains alive.
6. When the model becomes available, Frisk detects it without requiring a full restart.
7. Rust/native failure does not kill Frisk.
8. Web/OS Link transport does not spam the console.
9. Python is never installed or discovered.
10. Only START_HERE.bat is the release entry point.

---

# 59. RELEASE VERIFICATION

Before creating the ZIP:

- compile Python modules
- run all tests
- run release audit
- verify one root folder
- verify no `.pyc`
- verify no `__pycache__`
- verify no `.log`
- verify no obsolete launchers
- verify no FriskDesktop source/identity contamination
- verify Python policy
- verify startup path
- verify required files
- verify manifest/version
- calculate SHA256

Do not claim Windows/MSVC native compilation was physically tested unless it actually was.

Source-level and Linux test validation must be described honestly.

---

# 60. FINAL DEFINITION

Frisk is:

> A persistent local AI companion whose intelligence emerges from a language model connected to memory, relationship, perception, internal state, knowledge, goals, tools, experience, verification, learning, voice, embodiment, and the real computer environment.

The user should stop thinking:

> "What command does Frisk expect?"

and start thinking:

> "I can just talk to her."

That is the final goal.

## Absolute rule

If useful behavior can emerge from:

```text
memory
+ context
+ relationship
+ state
+ knowledge
+ experience
+ reasoning
+ perception
+ capabilities
+ verification
+ learning
```

build that system instead of replacing it with a hard-coded list of commands.
