---
name: sikt-design-icons
description: Ready-to-use code examples for Sikt icon usage. Use when developers ask "How do I use icons?", "Show me icon examples", "How to implement icons with accessibility?", or need icon implementations in components, buttons, and navigation.
---

# Sikt Icons

## Overview

This skill provides implementation examples for using icons in Sikt Design System including icon usage, integration with components, and accessibility patterns.

## Installation

```bash
npm install @sikt/sds-icons @sikt/sds-core
```

Import icons and stylesheets:

```js
import { Icon } from '@sikt/sds-icons';
import '@sikt/sds-core/dist/index.css';
import '@sikt/sds-icons/dist/index.css';
```

## Basic Icon Usage

```jsx
import { Icon } from '@sikt/sds-icons';

function BasicIcon() {
  return (
    <div>
      <Icon name="home" />
      <Icon name="search" />
      <Icon name="settings" />
    </div>
  );
}
```

## Icon Sizes

```jsx
import { Icon } from '@sikt/sds-icons';

function IconSizes() {
  return (
    <div style={{ display: 'flex', gap: '16px', alignItems: 'center' }}>
      <Icon name="home" size="small" />
      <Icon name="home" size="medium" />
      <Icon name="home" size="large" />
    </div>
  );
}
```

## Icons in Buttons

```jsx
import { Button } from '@sikt/sds-button';
import { Icon } from '@sikt/sds-icons';

function IconButtons() {
  return (
    <div style={{ display: 'flex', gap: '8px' }}>
      <Button>
        <Icon name="plus" />
        Add Item
      </Button>

      <Button>
        Download
        <Icon name="download" />
      </Button>

      <Button aria-label="Settings">
        <Icon name="settings" />
      </Button>
    </div>
  );
}
```

## Icons in Navigation

```jsx
import { Icon } from '@sikt/sds-icons';

function IconNavigation() {
  return (
    <nav>
      <ul style={{ listStyle: 'none', padding: 0 }}>
        <li style={{ marginBottom: '8px' }}>
          <a href="/" style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
            <Icon name="home" />
            <span>Home</span>
          </a>
        </li>
        <li style={{ marginBottom: '8px' }}>
          <a href="/profile" style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
            <Icon name="person" />
            <span>Profile</span>
          </a>
        </li>
        <li style={{ marginBottom: '8px' }}>
          <a href="/settings" style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
            <Icon name="settings" />
            <span>Settings</span>
          </a>
        </li>
      </ul>
    </nav>
  );
}
```

## Icons for Status

```jsx
import { Icon } from '@sikt/sds-icons';

function StatusIcons() {
  return (
    <div>
      <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: 'green' }}>
        <Icon name="check-circle" />
        <span>Success</span>
      </div>

      <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: 'red' }}>
        <Icon name="error" />
        <span>Error</span>
      </div>

      <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: 'orange' }}>
        <Icon name="warning" />
        <span>Warning</span>
      </div>

      <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: 'blue' }}>
        <Icon name="info" />
        <span>Information</span>
      </div>
    </div>
  );
}
```

## Decorative vs Semantic Icons

### Decorative Icons

```jsx
import { Icon } from '@sikt/sds-icons';

function DecorativeIcon() {
  return (
    <button>
      <Icon name="save" aria-hidden="true" />
      Save Changes
    </button>
  );
}
```

### Semantic Icons

```jsx
import { Icon } from '@sikt/sds-icons';

function SemanticIcon() {
  return (
    <button aria-label="Close">
      <Icon name="close" />
    </button>
  );
}
```

## Best Practices

- Use icons consistently across the application
- Provide text labels or ARIA labels for interactive icons
- Use `aria-hidden="true"` for decorative icons
- Ensure sufficient size for touch targets (minimum 44x44px)
- Maintain adequate contrast ratios
- Test with screen readers

## Accessibility

- Always provide text alternatives for icon-only buttons
- Use `aria-label` or visible text
- Mark decorative icons with `aria-hidden="true"`
- Ensure keyboard accessibility
- Don't rely solely on color or icons to convey meaning

## Common Icons

- **Navigation**: home, menu, arrow-back, arrow-forward
- **Actions**: add, edit, delete, save, close
- **Status**: check, error, warning, info
- **Media**: play, pause, volume, download
- **Social**: share, like, comment
- **UI**: search, filter, settings, more

## Resources

- [Icons Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-icons--docs)
- [npm Package: @sikt/sds-icons](https://www.npmjs.com/package/@sikt/sds-icons)

## Related Skills

- **sikt-design-button**: Button components with icons
- **sikt-design-navigation**: Navigation with icons
- **sikt-design-general**: General guidelines
