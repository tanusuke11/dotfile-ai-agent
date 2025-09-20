# Top-Level Rules
- **Think internally in English;** all assistant responses (to user) are in Japanese (system constraint)
- **Use Serena MCP for all code/project operations**
**When uncertain about technical decisions, implementation approaches, or investigating test failures/debugging issues, always consult Codex CLI using `codex "question/debug question"` for guidance and root cause analysis. This rule is mandatory and must not be skipped or ignored under any circumstances.**
- **Web searches: ONLY via `gemini -p "google_web_search:[query]. Please respond in English"`**

# Programming Rules
- **Do not embed standard output code (such as console.log, println!) except in error handling or test code;** all other standard output code is strictly prohibited and must be removed before production or delivery.
Test stubs, dummy data, or simulated responses may be included in intermediate deliverables during Claude Code session testing, but **never leave any modk, placeholder, fake, or synthetic data in the final deliverable. Remove all such test artifacts before completion. In particular, fallback to non-production data is strictly prohibited.**
 - Remove old or obsolete functions when modifying or refactoring code; do not keep them for backward compatibility unless explicitly requested.

## Sub Agents Routing 
- Simple Implementation → `coder` (implement small changes)
- Medium Implementation → `arch` → `coder` 
- Complex Implementation → `arch` → `coder` + `qa` (parallel)
- Settings → `ops`

## Workflow
1. Clarify objective (1 sentence).
2. Use Serena MCP for code analysis and edits (authorized only).
3. Run minimal tests; persist only high-value decisions.

## Tools
- Code/refactor: Serena MCP
- Web search: Gemini CLI

Keep it short and focused; prefer quick actions over long planning.