---
name: sikt-design-popover
description: Ready-to-use code examples for Sikt popover components. Use when developers ask "How do I create a popover?", "Show me tooltip examples", "How to implement contextual overlays?", or need popover implementations for help text, menus, or additional information.
---

# Sikt Popover Components

## Overview

This skill provides implementation examples for Sikt Design System popover components including tooltips, contextual overlays, and menu popovers.

## Installation

```bash
npm install @sikt/sds-popover @sikt/sds-button @sikt/sds-core
```

Import components:

```js
import { Popover } from '@sikt/sds-popover';
import { Button } from '@sikt/sds-button';
```

## Basic Popover

```jsx
import { Popover } from '@sikt/sds-popover';
import { Button } from '@sikt/sds-button';
import { useState } from 'react';

function BasicPopover() {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <Popover
      open={isOpen}
      onOpenChange={setIsOpen}
      trigger={<Button>Show Popover</Button>}
    >
      <div style={{ padding: '16px' }}>
        <p>Popover content goes here.</p>
      </div>
    </Popover>
  );
}
```

## Tooltip Popover

```jsx
import { Popover } from '@sikt/sds-popover';

function TooltipPopover() {
  return (
    <Popover
      trigger={<Button>Hover me</Button>}
      triggerOn="hover"
      placement="top"
    >
      <div style={{ padding: '8px', maxWidth: '200px' }}>
        This is a helpful tooltip message.
      </div>
    </Popover>
  );
}
```

## Menu Popover

```jsx
import { Popover } from '@sikt/sds-popover';
import { Button } from '@sikt/sds-button';

function MenuPopover() {
  const handleAction = (action) => {
    console.log('Action:', action);
  };

  return (
    <Popover
      trigger={<Button>Options</Button>}
      placement="bottom-start"
    >
      <div style={{ padding: '8px' }}>
        <button onClick={() => handleAction('edit')} style={{ display: 'block', width: '100%', padding: '8px', textAlign: 'left', border: 'none', background: 'none' }}>
          Edit
        </button>
        <button onClick={() => handleAction('duplicate')} style={{ display: 'block', width: '100%', padding: '8px', textAlign: 'left', border: 'none', background: 'none' }}>
          Duplicate
        </button>
        <button onClick={() => handleAction('delete')} style={{ display: 'block', width: '100%', padding: '8px', textAlign: 'left', border: 'none', background: 'none', color: 'red' }}>
          Delete
        </button>
      </div>
    </Popover>
  );
}
```

## Help Popover

```jsx
import { Popover } from '@sikt/sds-popover';

function HelpPopover() {
  return (
    <div style={{ display: 'inline-flex', alignItems: 'center', gap: '8px' }}>
      <label>Password</label>
      <Popover
        trigger={<button style={{ border: 'none', background: 'none', cursor: 'pointer' }}>ⓘ</button>}
        placement="right"
        triggerOn="hover"
      >
        <div style={{ padding: '12px', maxWidth: '250px' }}>
          <strong>Password Requirements:</strong>
          <ul style={{ margin: '8px 0 0', paddingLeft: '20px' }}>
            <li>At least 8 characters</li>
            <li>One uppercase letter</li>
            <li>One number</li>
          </ul>
        </div>
      </Popover>
    </div>
  );
}
```

## Placement Variants

```jsx
import { Popover } from '@sikt/sds-popover';
import { Button } from '@sikt/sds-button';

function PlacementExample() {
  return (
    <div style={{ display: 'flex', gap: '16px', flexWrap: 'wrap' }}>
      <Popover trigger={<Button>Top</Button>} placement="top">
        <div style={{ padding: '8px' }}>Top placement</div>
      </Popover>

      <Popover trigger={<Button>Right</Button>} placement="right">
        <div style={{ padding: '8px' }}>Right placement</div>
      </Popover>

      <Popover trigger={<Button>Bottom</Button>} placement="bottom">
        <div style={{ padding: '8px' }}>Bottom placement</div>
      </Popover>

      <Popover trigger={<Button>Left</Button>} placement="left">
        <div style={{ padding: '8px' }}>Left placement</div>
      </Popover>
    </div>
  );
}
```

## Form Field Help

```jsx
import { Popover } from '@sikt/sds-popover';
import { TextInput } from '@sikt/sds-input';

function FormWithHelp() {
  return (
    <div>
      <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '8px' }}>
        <label htmlFor="email">Email Address</label>
        <Popover
          trigger={<button type="button" style={{ border: 'none', background: 'none', cursor: 'help' }}>?</button>}
          placement="right"
        >
          <div style={{ padding: '12px', maxWidth: '200px' }}>
            Enter your institutional email address for verification.
          </div>
        </Popover>
      </div>
      <TextInput id="email" type="email" />
    </div>
  );
}
```

## Best Practices

- Keep popover content concise
- Position appropriately relative to trigger
- Use hover for tooltips, click for actions
- Ensure adequate contrast for readability
- Provide escape mechanisms (click outside, ESC key)

## Accessibility

- Use proper ARIA attributes
- Ensure keyboard accessibility
- Provide focus management
- Support screen readers

## Resources

- [Popover Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-popover--docs)
- [npm Package: @sikt/sds-popover](https://www.npmjs.com/package/@sikt/sds-popover)

## Related Skills

- **sikt-design-dialog**: Modal dialogs
- **sikt-design-button**: Trigger buttons
- **sikt-design-general**: General guidelines
