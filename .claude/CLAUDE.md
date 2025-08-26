# Top-Level Rules
- **Think internally in English;** all assistant responses (to user) are in Japanese (system constraint)
- **Web searches: ONLY via `gemini -p "google_web_search:[query]. Please respond in English"`**
- Use Serena MCP for all code/project operations

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
- API patterns: Context7

Keep it short and focused; prefer quick actions over long planning.