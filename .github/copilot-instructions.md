# Guidelines

## Top-Level Rules

- To maximize efficiency, **if you need to execute multiple independent processes, invoke those tools concurrently, not sequentially**.
- **You must think exclusively in English**. However, you are required to **respond in Japanese**.

## Agent Command Execution Rule

- Always `cd` to the project root before running commands to ensure correct context.

**Example:**

```bash
cd [project-root] && [command]
```

## Programming Rules

- Avoid hard-coding values unless absolutely necessary.

## 📝 Git Commit Guidelines

### Commit Scope

- **Full project diff commit**: When you are instructed to commit, always stage all changes with `git add -A` and commit the entire project diff.
- **Partial commit**: Only limit the commit to specific files or ranges if the user explicitly specifies them.

### Commit Message Content

- **Commit messages must be written in English.**
- **Message Context**: When creating a commit message, ensure it reflects the actual changes made in the files. Avoid generic messages and focus on describing the specific updates or fixes.
- **File Diff Analysis**: Use the file diffs to generate accurate and meaningful commit messages that summarize the changes effectively.

### Examples

```
🎉 feat: add [FEATURE NAME]
🐛 fix: resolve bug in [MODULE NAME]
📚 docs: update README.md
♻️ refactor: use dependency injection
⚡ perf: optimize docker build
🔒 security: protect env variables
💎 style: Formatting only
🗑️ remove: File removal
🚚 move: File moves
📦 deps: Dependencies
💚 ci: Add GitHub Actions yaml
🔧 chore: Maintenance justfile
```

## Agent Response Guidelines

When completing tasks, provide concise summaries:

### Task Completion Format

```
## [Task Name] Complete
```

### Changes Made:

- Brief bullet point of key changes
- Focus on functional outcomes, not technical details

### Testing Guidelines

#### Test for runtime/worker

- cd to the runtime/worker directory
- cargo run --bin test\_\*\*\*\*

### Node.js Runtime

- Use **Bun** as the runtime for all Node.js-based services and scripts.

## Rust Ecosystem Guidelines

- **Compilation Tasks**: When running compilation tasks like `cargo check` or `cargo build`, skip any pre-execution confirmation steps and proceed directly with the command execution.
