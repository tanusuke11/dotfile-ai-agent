# Top-Level Rules
- Run independent processes concurrently when possible
- **Think internally in English;** all assistant responses (to user) are in Japanese (system constraint)
- Minimize hard-coded values

# Workflow
1. Define objective & keyword clusters (≤3 words each)
2. Run 2–4 targeted Gemini searches
3. Distill facts, remove noise/marketing
4. Store durable insights in Serena Memory
5. Apply & verify changes

# Quality & Persistence
**Store if:** High re-explanation cost, architecture decisions, numeric rationale  
**Skip if:** Logs, large dumps, easily reproducible info

**Sources:** Trusted domains, multi-source corroboration, verified dates

# Quick Checklist
- [ ] Objective clear, ≤4 targeted searches
- [ ] Conflicts resolved, insights stored
- [ ] Implementation matches findings

---
Short research loops → high-signal facts → persist → apply fast.