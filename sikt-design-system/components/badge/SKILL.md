---
name: sikt-design-badge
description: Ready-to-use code examples for Sikt badge, message, and logo components. Use when developers ask "How do I use badges?", "Show me status indicators", "How to display logos?", or need badge, message, and branding component implementations.
---

# Sikt Badge, Message, and Logo Components

## Overview

This skill provides implementation examples for Sikt Design System badge components, message components, and logo components for status indicators, notifications, and branding.

## Installation

```bash
npm install @sikt/sds-badge @sikt/sds-message @sikt/sds-logo @sikt/sds-core
```

Import the core CSS file (REQUIRED) and components:

```js
// REQUIRED: Import core styles for design tokens, base styles, and component styling
import '@sikt/sds-core/dist/index.css';

// Import components
import { Badge } from '@sikt/sds-badge';
import { Message } from '@sikt/sds-message';
import { Logo } from '@sikt/sds-logo';
```

**CRITICAL**:
- You MUST import `@sikt/sds-core/dist/index.css` for components to display correctly with borders, outlines, and proper styling
- Do NOT import component-specific CSS files (e.g., `@sikt/sds-button/dist/index.css`) - these are not needed
- Components will not have proper styling without the core CSS import

## Badge Component

### Basic Badge

```jsx
import { Badge } from '@sikt/sds-badge';

function BasicBadge() {
  return (
    <div>
      <Badge>New</Badge>
      <Badge variant="success">Active</Badge>
      <Badge variant="warning">Pending</Badge>
      <Badge variant="error">Failed</Badge>
    </div>
  );
}
```

### Notification Badge

```jsx
import { Badge } from '@sikt/sds-badge';
import { Button } from '@sikt/sds-button';

function NotificationBadge() {
  const notificationCount = 5;

  return (
    <div style={{ position: 'relative', display: 'inline-block' }}>
      <Button>Notifications</Button>
      {notificationCount > 0 && (
        <Badge variant="error" style={{ position: 'absolute', top: '-8px', right: '-8px' }}>
          {notificationCount}
        </Badge>
      )}
    </div>
  );
}
```

### Status Badges

```jsx
import { Badge } from '@sikt/sds-badge';

function StatusBadges() {
  return (
    <div style={{ display: 'flex', gap: '8px', flexWrap: 'wrap' }}>
      <Badge variant="success">✓ Completed</Badge>
      <Badge variant="warning">⏳ In Progress</Badge>
      <Badge variant="error">✗ Failed</Badge>
      <Badge variant="info">ⓘ Draft</Badge>
    </div>
  );
}
```

### Count Badge

```jsx
import { Badge } from '@sikt/sds-badge';

function CountBadge() {
  const items = ['Item 1', 'Item 2', 'Item 3'];

  return (
    <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
      <h3>Items</h3>
      <Badge>{items.length}</Badge>
    </div>
  );
}
```

## Message Component

### Info Message

```jsx
import { Message } from '@sikt/sds-message';

function InfoMessage() {
  return (
    <Message variant="info">
      <strong>Info:</strong> This is an informational message.
    </Message>
  );
}
```

### Success Message

```jsx
import { Message } from '@sikt/sds-message';

function SuccessMessage() {
  return (
    <Message variant="success">
      <strong>Success!</strong> Your changes have been saved.
    </Message>
  );
}
```

### Warning Message

```jsx
import { Message } from '@sikt/sds-message';

function WarningMessage() {
  return (
    <Message variant="warning">
      <strong>Warning:</strong> This action cannot be undone.
    </Message>
  );
}
```

### Error Message

```jsx
import { Message } from '@sikt/sds-message';

function ErrorMessage() {
  return (
    <Message variant="error">
      <strong>Error:</strong> Failed to save your changes. Please try again.
    </Message>
  );
}
```

### Dismissible Message

```jsx
import { Message } from '@sikt/sds-message';
import { useState } from 'react';

function DismissibleMessage() {
  const [isVisible, setIsVisible] = useState(true);

  if (!isVisible) return null;

  return (
    <Message
      variant="info"
      onDismiss={() => setIsVisible(false)}
    >
      This message can be dismissed.
    </Message>
  );
}
```

## Logo Component

### Basic Logo

```jsx
import { Logo } from '@sikt/sds-logo';

function BasicLogo() {
  return <Logo alt="Sikt Logo" />;
}
```

### Logo Sizes

```jsx
import { Logo } from '@sikt/sds-logo';

function LogoSizes() {
  return (
    <div style={{ display: 'flex', gap: '24px', alignItems: 'center' }}>
      <Logo size="small" alt="Sikt Logo" />
      <Logo size="medium" alt="Sikt Logo" />
      <Logo size="large" alt="Sikt Logo" />
    </div>
  );
}
```

### Logo with Link

```jsx
import { Logo } from '@sikt/sds-logo';

function LogoWithLink() {
  return (
    <a href="/">
      <Logo alt="Sikt Logo - Go to homepage" />
    </a>
  );
}
```

### Logo Variants

```jsx
import { Logo } from '@sikt/sds-logo';

function LogoVariants() {
  return (
    <div>
      <Logo variant="default" alt="Sikt Logo" />
      <Logo variant="monochrome" alt="Sikt Logo Monochrome" />
    </div>
  );
}
```

## Combined Examples

### User Profile with Badge

```jsx
import { Badge } from '@sikt/sds-badge';

function UserProfile() {
  return (
    <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
      <img src="/avatar.jpg" alt="User avatar" style={{ width: '40px', height: '40px', borderRadius: '50%' }} />
      <div>
        <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
          <strong>John Doe</strong>
          <Badge variant="success" size="small">Pro</Badge>
        </div>
        <p style={{ margin: 0, fontSize: '14px', color: '#666' }}>john@example.com</p>
      </div>
    </div>
  );
}
```

### Header with Logo and Badges

```jsx
import { Logo } from '@sikt/sds-logo';
import { Badge } from '@sikt/sds-badge';
import { Button } from '@sikt/sds-button';

function HeaderWithBadges() {
  return (
    <header style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '16px', borderBottom: '1px solid #eee' }}>
      <Logo alt="Sikt Logo" />

      <nav style={{ display: 'flex', gap: '16px', alignItems: 'center' }}>
        <div style={{ position: 'relative' }}>
          <Button variant="text">Messages</Button>
          <Badge variant="error" style={{ position: 'absolute', top: '-4px', right: '-4px' }}>3</Badge>
        </div>

        <Button variant="text">Profile</Button>
      </nav>
    </header>
  );
}
```

## Best Practices

### Badges
- Use consistently for similar contexts
- Keep text short (1-2 words or numbers)
- Choose appropriate variants for meaning
- Ensure sufficient contrast

### Messages
- Use appropriate variant for message type
- Include clear, actionable text
- Provide dismiss option when appropriate
- Position prominently when critical

### Logos
- Use correct variant for background
- Maintain proper spacing around logo
- Link to homepage when in header
- Provide descriptive alt text

## Accessibility

- Ensure sufficient color contrast
- Provide meaningful text for screen readers
- Use semantic HTML
- Make interactive elements keyboard accessible

## Resources

- [Badge Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-badge--docs)
- [Message Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-message--docs)
- [Logo Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-logo--docs)

## Related Skills

- **sikt-design-alert**: Alert components
- **sikt-design-layout**: Layout patterns
- **sikt-design-general**: General guidelines
