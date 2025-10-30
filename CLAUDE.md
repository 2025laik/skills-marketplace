# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Claude Skills marketplace repository for 2025LAIK. Skills extend Claude's capabilities with specialized knowledge, workflows, and tool integrations. Each skill is a self-contained package with a `SKILL.md` file and optional bundled resources (scripts, references, assets).

## Skill Architecture

### Skill Structure
Each skill directory contains:
- `SKILL.md` (required) - YAML frontmatter with metadata + markdown instructions
- `scripts/` (optional) - Executable code (Python/Bash) for deterministic operations
- `references/` (optional) - Documentation loaded into context as needed
- `assets/` (optional) - Files used in output (templates, images, fonts)

### Progressive Disclosure Design
Skills use a three-level loading system:
1. Metadata (name + description) - Always in context (~100 words)
2. SKILL.md body - When skill triggers (<5k words)
3. Bundled resources - As needed by Claude

## Common Commands

### Update Marketplace Configuration
After adding or modifying skills, update the marketplace registry:
```bash
./marketplace.update.sh
```
This script uses the Claude CLI to scan the repository and regenerate [.claude-plugin/marketplace.json](.claude-plugin/marketplace.json).

### Initialize New Skill
Create a new skill from template:
```bash
skill-creator/scripts/init_skill.py <skill-name> --path .
```
This creates a complete skill directory structure with template files.

### Validate Skill
Check if a skill meets all requirements:
```bash
skill-creator/scripts/quick_validate.py <path/to/skill-folder>
```

### Package Skill
Create a distributable zip file (includes validation):
```bash
skill-creator/scripts/package_skill.py <path/to/skill-folder> [output-dir]
```

## Key Implementation Details

### Skill Metadata Requirements
The YAML frontmatter in `SKILL.md` must contain:
- `name` - Hyphen-case identifier matching directory name (max 40 chars)
- `description` - Complete, informative explanation of when to use the skill (use third-person: "This skill should be used when...")

### Skill Writing Style
- Use imperative/infinitive form (verb-first instructions), not second person
- Use objective, instructional language: "To accomplish X, do Y"
- Avoid duplication between SKILL.md and reference files
- Keep SKILL.md lean (<5k words); move detailed content to references/

### Resource Directory Purposes
- `scripts/` - Code that may be executed without loading into context, but can still be read for patching
- `references/` - Documentation loaded only when Claude determines it's needed
- `assets/` - Files used in final output, not loaded into context

## Marketplace Configuration

The [.claude-plugin/marketplace.json](.claude-plugin/marketplace.json) file defines all plugins in the marketplace. Each plugin entry includes:
- `name` - Plugin identifier
- `description` - When to use the skill (copied from SKILL.md frontmatter)
- `source` - Path to repository root (`./`)
- `skills` - Array of paths to skill directories

## Publishing Skills

To publish a skill to the marketplace:

1. **Update marketplace.json** - Run `./marketplace.update.sh` to scan the repository and update [.claude-plugin/marketplace.json](.claude-plugin/marketplace.json)
2. **Commit changes** - Commit the skill directory and updated marketplace.json
3. **Push to repository** - Push to the GitHub repository

Once pushed, users can install skills from the marketplace.

## Installation for End Users

Users add this marketplace to Claude Code with:
```bash
/plugin marketplace add https://github.com/2025laik/skills-marketplace.git
```

Then install individual skills:
```bash
/plugin install <skill-name>@2025laik-skills-marketplace
```
