# Sikt Claude Skills

## Get started with `claude code`

```
claude
/plugin marketplace add https://gitlab.sikt.no/ki-team/initiatives/skills.git
```

add specific skills

```
claude
/plugin install vault-gitlab@sikt-skills-marketplace
```

Run `./new-plugin.sh` to create a new skill from the template.

# creating a skill

Skills are simple to create - just a folder with a `SKILL.md` file containing YAML frontmatter and instructions. You can use the **template-skill** in this repository as a starting point:

```markdown
---
name: my-skill-name
description: A clear description of what this skill does and when to use it
---

# skill name

Your stuff here.
```
