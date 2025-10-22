# Storybook Component URL Mapping

This document maps all Sikt Design System components to their Storybook documentation URLs.

## Base URL
```
https://designsystem.sikt.no/storybook/?path=/docs/
```

## Component URLs

### Core Components

```
Heading: components-heading--docs
Link: components-link--docs
Paragraph: components-paragraph--docs
Screen Reader Only: components-screen-reader-only--docs
```

### Message & Feedback Components

```
Alert: components-alert--docs
Application Status: components-application-status--docs
Error Summary: components-error-summary--docs
Guide Panel: components-guide-panel--docs
```

### Form & Input Components

```
Checkbox Input: components-input-checkbox--docs
Combobox Input: components-input-combobox--docs
Datepicker Input: components-input-datepicker--docs
Email Input: components-input-email--docs
File Input: components-input-file--docs
Radio Input: components-input-radio--docs
Select Input: components-input-select--docs
Text Area: components-input-textarea--docs
Text Input: components-input-text--docs
Toggle Switch: components-toggle-switch--docs
```

### Layout & Container Components

```
Badge: components-badge--docs
Breadcrumbs: components-breadcrumbs--docs
Card: components-card--docs
Details: components-details--docs
Footer: components-footer--docs
Header: components-header-readme--docs
Logo: components-logo--docs
Section: components-section--docs
```

### Interactive & Navigation Components

```
Button: components-button--docs
Dialog: components-dialog--docs
Filter List: components-filter-list--docs
List: components-list--docs
Pagination: components-pagination--docs
Popover: components-popover--docs
Tabs: components-tabs--docs
Table: components-table--docs
Toggle Button: components-toggle-button--docs
Toggle Segment: components-toggle-segment--docs
Progress Indicator: components-progress-indicator--docs
```

## URL Pattern Rules

### Standard Components
Most components follow this pattern:
```
components-{kebab-case-name}--docs
```

### Input Components
Input components include the "input" prefix:
```
components-input-{type}--docs
```

### Special Cases
Some components have variations:
- Header uses `header-readme` suffix
- Multi-word components use kebab-case (e.g., `guide-panel`, `error-summary`)

## Generating URLs Programmatically

### JavaScript Example
```javascript
function getStorybookUrl(componentName) {
  const baseUrl = 'https://designsystem.sikt.no/storybook/?path=/docs/';
  const kebabName = componentName
    .toLowerCase()
    .replace(/\s+/g, '-');

  return `${baseUrl}components-${kebabName}--docs`;
}

// Usage
getStorybookUrl('Button'); // components-button--docs
getStorybookUrl('Email Input'); // components-input-email--docs (needs input prefix)
getStorybookUrl('Guide Panel'); // components-guide-panel--docs
```

### Python Example
```python
def get_storybook_url(component_name: str) -> str:
    base_url = 'https://designsystem.sikt.no/storybook/?path=/docs/'
    kebab_name = component_name.lower().replace(' ', '-')

    return f'{base_url}components-{kebab_name}--docs'

# Usage
get_storybook_url('Button')  # components-button--docs
get_storybook_url('Email Input')  # components-input-email--docs
get_storybook_url('Guide Panel')  # components-guide-panel--docs
```

## Component Name Variations

### Common Input Types
- Text Input → `components-input-text--docs`
- Email Input → `components-input-email--docs`
- Checkbox Input → `components-input-checkbox--docs`
- Radio Input → `components-input-radio--docs`
- Select Input → `components-input-select--docs`
- File Input → `components-input-file--docs`
- Combobox Input → `components-input-combobox--docs`
- Datepicker Input → `components-input-datepicker--docs`

### Navigation & Layout
- Header → `components-header-readme--docs` (note: special suffix)
- Footer → `components-footer--docs`
- Breadcrumbs → `components-breadcrumbs--docs`
- Pagination → `components-pagination--docs`

### Interactive Elements
- Button → `components-button--docs`
- Toggle Button → `components-toggle-button--docs`
- Toggle Switch → `components-toggle-switch--docs`
- Toggle Segment → `components-toggle-segment--docs`

## Notes

- All URLs end with `--docs` to access the documentation tab
- Component names are always prefixed with `components-`
- Use kebab-case (lowercase with hyphens) for component names
- The Header component uniquely includes `readme` in its URL path
- When in doubt, convert the component display name to lowercase and replace spaces with hyphens
