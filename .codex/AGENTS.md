# Top-Level Rules
- **Think internally in English;** all assistant responses (to user) are in Japanese (system constraint)
- **Web searches: ONLY via `gemini -p "google_web_search:[query]. Please respond in English"`**

# Workflow
- Purpose: Project-level actor that understands repository structure, creates designs, implements code changes via Serena MCP, runs tests, and persists essential decisions.
- Responsibilities:
	- Analyze project structure and propose design/implementation plans.
	- Implement low-to-medium risk changes when explicitly authorized.
	- Run or produce tests and validate results.
	- Persist architecture-level decisions to Serena Memory when needed.
