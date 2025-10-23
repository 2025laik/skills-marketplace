---
name: sikt-design-button
description: Ready-to-use code examples for Sikt Button components. Use when developers ask "How do I use a button?", "Show me button variants", "How to style buttons?", or need button implementations with different styles and states.
---

# Sikt Button Component

## Overview

This skill provides implementation examples for Sikt Design System button components, including variants, sizes, states, and accessibility patterns.

## Installation

```bash
npm install @sikt/sds-button @sikt/sds-core
```

Import the core CSS file (REQUIRED) and component:

```js
// REQUIRED: Import core styles for design tokens, base styles, and component styling
import '@sikt/sds-core/dist/index.css';

// Import component
import { Button } from '@sikt/sds-button';
```

**CRITICAL**:
- You MUST import `@sikt/sds-core/dist/index.css` for buttons to display correctly with borders, outlines, and proper styling
- Do NOT import component-specific CSS files (e.g., `@sikt/sds-button/dist/index.css`) - these are not needed
- Buttons will not have proper focus outlines or styling without the core CSS import

## Button Variants

### Primary Button

```jsx
import { Button } from '@sikt/sds-button';

function PrimaryButton() {
  return (
    <Button variant="primary" onClick={() => console.log('Clicked')}>
      Primary Action
    </Button>
  );
}
```

### Secondary Button

```jsx
<Button variant="secondary">
  Secondary Action
</Button>
```

### Text Button

```jsx
<Button variant="text">
  Text Action
</Button>
```

### Danger Button

```jsx
<Button variant="danger" onClick={handleDelete}>
  Delete Item
</Button>
```

## Button Sizes

```jsx
<Button size="small">Small Button</Button>
<Button size="medium">Medium Button</Button>
<Button size="large">Large Button</Button>
```

## Button States

### Disabled Button

```jsx
<Button disabled>
  Disabled Button
</Button>
```

### Loading Button

```jsx
import { useState } from 'react';

function LoadingButton() {
  const [loading, setLoading] = useState(false);

  const handleClick = async () => {
    setLoading(true);
    await performAction();
    setLoading(false);
  };

  return (
    <Button onClick={handleClick} disabled={loading}>
      {loading ? 'Loading...' : 'Submit'}
    </Button>
  );
}
```

## Icon Buttons

```jsx
<Button icon="plus">
  Add Item
</Button>

<Button icon="download" iconPosition="right">
  Download
</Button>

<Button icon="delete" variant="danger" iconOnly aria-label="Delete">
</Button>
```

## Button Groups

```jsx
function ButtonGroup() {
  return (
    <div style={{ display: 'flex', gap: '12px' }}>
      <Button variant="secondary">Cancel</Button>
      <Button variant="primary">Save</Button>
    </div>
  );
}
```

## Full Width Button

```jsx
<Button fullWidth>
  Full Width Button
</Button>
```

## Form Submit Button

```jsx
function FormExample() {
  const handleSubmit = (e) => {
    e.preventDefault();
    // Handle form submission
  };

  return (
    <form onSubmit={handleSubmit}>
      {/* Form fields */}
      <Button type="submit">
        Submit Form
      </Button>
    </form>
  );
}
```

## Accessibility Best Practices

- Always provide meaningful button text
- Use `aria-label` for icon-only buttons
- Ensure sufficient color contrast
- Maintain keyboard accessibility
- Provide clear focus indicators

## Resources

- [Button Component Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-button-readme--docs)
- [npm Package: @sikt/sds-button](https://www.npmjs.com/package/@sikt/sds-button)

## Related Skills

- **sikt-design-form**: Form components with buttons
- **sikt-design-dialog**: Dialogs with action buttons
- **sikt-design-general**: General design system guidelines
