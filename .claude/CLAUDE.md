# Guidelines

## Top-Level Rules
- Run independent processes concurrently when possible
- **Think internally in English;** all assistant responses (to user) are in Japanese (system constraint)
- Minimize hard‑coded values
- **Web searches: ONLY via `gemini -p "google_web_search:[query]. Please respond in English"`**

## Programming Rules
- Favor idempotency, reusability, testability
- Inject configuration (env vars / config files / DI) – avoid scattering constants

## Build/Test Failure Escalation
**On 2nd consecutive failure**: `gemini -p "Build error: [ERROR]. Current project context: [CURRENT_CONTEXT]. Error details: [ERROR_DETAILS]. Suggest fix in English."`
**Targets**: Any build or test execution commands (e.g., `just`, `cargo`, `bun`, `docker-compose`, etc.)

## Integration Rules

### Tool Selection Matrix
| Objective | Tool |
|-----------|------|
| Code structure / refactor | Serena MCP |
| **Context persistence** | **Serena Memory** |
| **Web search** | **Gemini CLI** |
| Latest API patterns | Context7 |

### Serena MCP (Primary)
- Holistic project structure understanding & safe semantic refactors
- **Context Recording**: All decisions/changes → `.claude/logs/context.md` for session continuity
- **Auto Compact**: Leverage Serena memory context for session continuity during auto-compact operations
- Memory APIs: `write_memory(memory_name, content)`, `read_memory(memory_file_name)`, `list_memories()`

### Gemini CLI (Web Operations)
- **Web Search**: `gemini -p 'google_web_search:[query]. Please respond in English'`

### Context7 MCP
- Latest library/API usage patterns (avoid stale assumptions)


## Hooks
- SessionStart (Bash): Run startup script
- PostToolUse (Bash): Failed tests → Gemini quick-fix suggestions

## Operational Principles
- Maximize throughput via concurrency
- Summarize external info before applying
- Keep output concise & semantically meaningful

(Expand only when new recurring patterns emerge.)