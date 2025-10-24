---
name: sikt-design-storybook
description: Get Storybook documentation URLs for any Sikt component. Use when developers ask "Where's the docs for Button?", "Show me the Storybook link for Email Input", "I need the component documentation", or want to see live examples, props, and usage details.
---

# Sikt Storybook Documentation Links

## Overview

This skill provides direct links to Storybook documentation for all 43 Sikt components. Every component has interactive examples, prop documentation, and accessibility notes in Storybook.

**Common Developer Requests:**
- "Where can I find the Button documentation?"
- "Show me the Storybook link for Email Input"
- "I need to see examples of the Table component"
- "Where are the props for Dialog documented?"
- "Link me to the Card component docs"

## Installation Reference

After finding the component docs in Storybook, developers need to install packages. Always use the correct format:

```bash
# Core package (always required)
npm install @sikt/sds-core

# Add specific component packages
npm install @sikt/sds-<component-name>
```

**Example installations by component type:**

| Component | Install Command |
|-----------|-----------------|
| Button | `npm install @sikt/sds-core @sikt/sds-button` |
| Text Input | `npm install @sikt/sds-core @sikt/sds-form @sikt/sds-input` |
| Select | `npm install @sikt/sds-core @sikt/sds-form @sikt/sds-select` |
| Card | `npm install @sikt/sds-core @sikt/sds-card` |
| Dialog | `npm install @sikt/sds-core @sikt/sds-dialog` |
| Table | `npm install @sikt/sds-core @sikt/sds-table` |
| Header | `npm install @sikt/sds-core @sikt/sds-header` |

After installation, import the core CSS (REQUIRED):
```js
// REQUIRED: Import core styles ONCE in your app entry point
import '@sikt/sds-core/dist/index.css';

// Import components
import { Button } from '@sikt/sds-button';
```

**CRITICAL**:
- You MUST import `@sikt/sds-core/dist/index.css` ONCE in your application entry point
- Do NOT import component-specific CSS files (e.g., `@sikt/sds-button/dist/index.css`) - these are not needed
- All component styling is included in the core CSS file

## When to Use This Skill

**Use this skill when developers:**
- Ask for component documentation links
- Want to see live component examples
- Need to check component props and API
- Want interactive Storybook demos
- Ask "Where can I find..." or "Show me the docs for..."
- Need Storybook URLs to understand component installation

## How It Works

The skill generates Storybook URLs dynamically based on component names. Since Storybook URL patterns can vary, the Python script validates URLs to find the correct pattern for each component.

**Base URL:** `https://designsystem.sikt.no/storybook/?path=/docs/`

**Common patterns the script tries:**
- `components-{name}-readme--docs` (most common)
- `components-{name}--docs` (alternative)
- `components-input-{name}--docs` (for form inputs)

**Important:** Always use the Python script to generate URLs. Don't hardcode Storybook links as they may change.

## Python Script for URL Generation

### Command Line

```bash
python get_storybook_url.py <component_name>
```

Examples:
```bash
python get_storybook_url.py Button
python get_storybook_url.py "Email Input"
python get_storybook_url.py "Text Area"
python get_storybook_url.py Header
```

### As a Python Module

```python
from get_storybook_url import get_storybook_url

url = get_storybook_url("Button")
print(url)  # https://designsystem.sikt.no/storybook/?path=/docs/components-button-readme--docs

url = get_storybook_url("Email Input", validate=False)
print(url)  # Returns first pattern without validation
```

## How It Works

The tool:
1. Converts component names to kebab-case
2. Handles input components by adding the "input-" prefix when needed
3. Tries multiple URL suffix patterns in order:
   - `readme--docs` (most common)
   - `--docs` (alternative)
   - `--readme` (another variant)
4. Validates each URL by making an HTTP request
5. Returns the first working URL

## URL Pattern Rules

### Base URL
```
https://designsystem.sikt.no/storybook/?path=/docs/
```

### Standard Components
```
components-{kebab-case-name}-{suffix}
```

### Input Components
Input-related components automatically get the "input-" prefix:
```
components-input-{type}-{suffix}
```

Components detected as inputs:
- Contains "input" in name
- Matches: checkbox, radio, select, combobox, datepicker, file, email, text, password, number, tel, search, textarea

### Special Cases
- **Text Area**: Becomes `textarea` (no hyphen)
- Most components use `readme--docs` suffix
- Some use `--docs` or `--readme`

## Examples

### Button Component
```bash
$ python get_storybook_url.py Button
Searching for: Button
✓ Found: https://designsystem.sikt.no/storybook/?path=/docs/components-button-readme--docs
```

### Email Input Component
```bash
$ python get_storybook_url.py "Email Input"
Searching for: Email Input
✓ Found: https://designsystem.sikt.no/storybook/?path=/docs/components-email-input-readme--docs
```

### Text Area Component
```bash
$ python get_storybook_url.py "Text Area"
Searching for: Text Area
✓ Found: https://designsystem.sikt.no/storybook/?path=/docs/components-input-textarea-readme--docs
```

### Header Component
```bash
$ python get_storybook_url.py Header
Searching for: Header
✓ Found: https://designsystem.sikt.no/storybook/?path=/docs/components-header-readme--docs
```

## Common Components

Quick reference for frequently used components:

| Component | Command |
|-----------|---------|
| Button | `python get_storybook_url.py Button` |
| Text Input | `python get_storybook_url.py "Text Input"` |
| Email Input | `python get_storybook_url.py "Email Input"` |
| Checkbox | `python get_storybook_url.py Checkbox` |
| Radio | `python get_storybook_url.py Radio` |
| Select | `python get_storybook_url.py Select` |
| Text Area | `python get_storybook_url.py "Text Area"` |
| Card | `python get_storybook_url.py Card` |
| Header | `python get_storybook_url.py Header` |
| Footer | `python get_storybook_url.py Footer` |
| Alert | `python get_storybook_url.py Alert` |
| Dialog | `python get_storybook_url.py Dialog` |
| Table | `python get_storybook_url.py Table` |
| Tabs | `python get_storybook_url.py Tabs` |

## Troubleshooting

### Component Not Found

If the tool reports no documentation found:

```bash
$ python get_storybook_url.py "Unknown Component"
Searching for: Unknown Component
✗ No documentation found for 'Unknown Component'

Tried patterns:
  - https://designsystem.sikt.no/storybook/?path=/docs/components-unknown-component-readme--docs
  - https://designsystem.sikt.no/storybook/?path=/docs/components-unknown-component--docs
  - https://designsystem.sikt.no/storybook/?path=/docs/components-unknown-component--readme
```

Possible causes:
1. Component name spelling is incorrect
2. Component doesn't exist in the design system
3. Component uses a non-standard URL pattern
4. Network connectivity issues

### Validation Disabled

To skip validation and get the first URL pattern:

```python
from get_storybook_url import get_storybook_url

url = get_storybook_url("Button", validate=False)
```

This returns the URL without checking if it exists.

## Integration Examples

### In Python Scripts

```python
from get_storybook_url import get_storybook_url

def add_component_reference(component_name: str) -> str:
    url = get_storybook_url(component_name)
    if url:
        return f"See documentation: {url}"
    return f"No documentation found for {component_name}"
```

### In Documentation Generation

```python
from get_storybook_url import get_storybook_url

components = ["Button", "Text Input", "Card", "Alert"]

for comp in components:
    url = get_storybook_url(comp)
    if url:
        print(f"- [{comp}]({url})")
```

### In Code Comments

```python
from get_storybook_url import get_storybook_url

button_url = get_storybook_url("Button")
# Use button_url in JSDoc, docstrings, or inline comments
```

## Files

- `get_storybook_url.py`: Main script for URL generation and validation
- `SKILL.md`: This documentation

## Related Skills

- **sikt-design-system**: Main design system implementation guide
- **sikt-design-components**: Detailed component implementation guides
