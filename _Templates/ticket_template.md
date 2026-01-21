---
status: <% tp.system.suggester(["todo", "in-progress", "done", "wont-do"], ["todo", "in-progress", "done", "wont-do"], false, "Status") %>
type: <% tp.system.suggester(["feature", "bug", "idea", "refactor", "chore"], ["feature", "bug", "idea", "refactor", "chore"], false, "Type") %>
priority: <% tp.system.suggester(["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"], ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"], false, "Priority (1–10)") %>
keywords: <% tp.system.prompt("Keywords (comma-separated, optional)", "") %>
created: <% tp.date.now("YYYY-MM-DD") %>
---

# <% tp.file.title %>

## Description
<% tp.system.prompt("Quick description of the ticket:", "") %>

## Acceptance Criteria / Done When
- [ ] 

## Notes / Brain Dump

## Related Tickets (optional)
- 
