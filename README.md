# 2025LAIK Claude Skills

A marketplace for Claude Skills. Add skills to extend Claude's capabilities with specialized knowledge and workflows.

## Installation

Add this marketplace to Claude Code:

```
/plugin marketplace add https://github.com/2025laik/skills-marketplace.git
```

Install the skill-creator:

```
/plugin install skill-creator@2025laik-skills-marketplace
```

## Adding New Skills

Create a new skill directory with a `SKILL.md` file. See [template-skill](template-skill/SKILL.md) for an example:

```markdown
---
name: my-skill
description: a clear description of what this skill does and when to use it
---

# skill name

your stuff here.
```

After adding new skills to the repository, update [marketplace.json](.claude-plugin/marketplace.json) by running:

```bash
./marketplace.update.sh
```

This will automatically scan the repository and update the marketplace configuration.
