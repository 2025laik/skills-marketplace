# Sikt Claude Skills

##  i `claude code`

```
claude
/plugin marketplace add https://gitlab.sikt.no/ki-team/initiatives/skills.git
```

legg til spesifikke skills:

```
claude
/plugin install platon-aws-skills@sikt-skills-marketplace
```

en oversikt over alle plugins finnes i [marketplace](.claude-plugin/marketplace.json).

# nye skills

trenger kun en mappe med en `SKILL.md`-fil med metadata-frontmatter og diverse instrukser.
se [template-skill](template-skill/SKILL.md), evt:

```markdown
---
name: my-skill
description: a clear description of what this skill does and when to use it
---

# skill name

your stuff here.
```
