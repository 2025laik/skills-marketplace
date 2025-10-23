---
name: sikt-design-alert
description: Ready-to-use code examples for Sikt alert and feedback components. Use when developers ask "How do I show notifications?", "Give me toast examples", "How to handle loading states?", or need alert implementations with success, error, warning, and info variants.
---

# Sikt Alert and Feedback Components

## Overview

This skill provides implementation examples for Sikt Design System alert and feedback patterns including toast notifications, status messages, and application state handling.

## Installation

```bash
npm install @sikt/sds-button @sikt/sds-core
```

Import the core CSS file (REQUIRED) and components:

```js
// REQUIRED: Import core styles for design tokens, base styles, and component styling
import '@sikt/sds-core/dist/index.css';

// Import components
import { Button } from '@sikt/sds-button';
```

**CRITICAL**:
- You MUST import `@sikt/sds-core/dist/index.css` for components to display correctly with borders, outlines, and proper styling
- Do NOT import component-specific CSS files (e.g., `@sikt/sds-button/dist/index.css`) - these are not needed
- Components will not have proper styling without the core CSS import

## Toast Notification System

```jsx
import { Button } from '@sikt/sds-button';
import { useState, useEffect } from 'react';

function ToastNotification({ message, variant, duration = 5000, onClose }) {
  useEffect(() => {
    const timer = setTimeout(() => {
      onClose();
    }, duration);

    return () => clearTimeout(timer);
  }, [duration, onClose]);

  return (
    <div className={`toast toast-${variant}`}>
      <div className="toast-content">
        <p>{message}</p>
        <button onClick={onClose} className="toast-close" aria-label="Close notification">×</button>
      </div>
    </div>
  );
}

// Usage in app
function App() {
  const [toasts, setToasts] = useState([]);

  const addToast = (message, variant = 'info') => {
    const id = Date.now();
    setToasts([...toasts, { id, message, variant }]);
  };

  const removeToast = (id) => {
    setToasts(toasts.filter(toast => toast.id !== id));
  };

  return (
    <div>
      {toasts.map(toast => (
        <ToastNotification
          key={toast.id}
          message={toast.message}
          variant={toast.variant}
          onClose={() => removeToast(toast.id)}
        />
      ))}

      <Button onClick={() => addToast('Success!', 'success')}>
        Show Success
      </Button>
      <Button onClick={() => addToast('Error occurred', 'error')}>
        Show Error
      </Button>
    </div>
  );
}
```

**Required CSS for toasts (using Sikt design tokens - NO GRADIENTS, solid colors only):**

```css
/* Base toast styling */
.toast {
  position: fixed;
  top: var(--sds-space-padding-large);
  right: var(--sds-space-padding-large);
  z-index: 1000;
  max-width: 400px;
  padding: var(--sds-space-padding-medium);
  border: var(--sds-size-border-regular) solid;
  border-radius: var(--sds-size-border-radius-small);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.toast-content {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: var(--sds-space-padding-medium);
}

.toast-content p {
  margin: 0;
  flex: 1;
}

.toast-close {
  background: none;
  border: none;
  cursor: pointer;
  font-size: 20px;
  line-height: 1;
  padding: 0;
  opacity: 0.7;
}

.toast-close:hover {
  opacity: 1;
}

/* Success variant */
.toast-success {
  background-color: var(--sds-color-support-success-subtle);
  border-color: var(--sds-color-support-success-strong);
  color: var(--sds-color-text-success);
}

/* Error variant */
.toast-error {
  background-color: var(--sds-color-support-critical-subtle);
  border-color: var(--sds-color-support-critical-strong);
  color: var(--sds-color-text-critical);
}

/* Warning variant */
.toast-warning {
  background-color: var(--sds-color-support-warning-subtle);
  border-color: var(--sds-color-support-warning-strong);
  color: var(--sds-color-text-warning);
}

/* Info variant */
.toast-info {
  background-color: var(--sds-color-support-info-subtle);
  border-color: var(--sds-color-support-info-strong);
  color: var(--sds-color-text-info);
}
```

## Alert Variants

### Success Alert

```jsx
function SuccessAlert({ message, onClose }) {
  return (
    <div className="alert alert-success">
      <strong>Success:</strong> {message}
      {onClose && (
        <button onClick={onClose} className="alert-close" aria-label="Close alert">×</button>
      )}
    </div>
  );
}
```

### Error Alert

```jsx
function ErrorAlert({ message, onClose }) {
  return (
    <div className="alert alert-error">
      <strong>Error:</strong> {message}
      {onClose && (
        <button onClick={onClose} className="alert-close" aria-label="Close alert">×</button>
      )}
    </div>
  );
}
```

### Warning Alert

```jsx
function WarningAlert({ message, onClose }) {
  return (
    <div className="alert alert-warning">
      <strong>Warning:</strong> {message}
      {onClose && (
        <button onClick={onClose} className="alert-close" aria-label="Close alert">×</button>
      )}
    </div>
  );
}
```

### Info Alert

```jsx
function InfoAlert({ message, onClose }) {
  return (
    <div className="alert alert-info">
      <strong>Info:</strong> {message}
      {onClose && (
        <button onClick={onClose} className="alert-close" aria-label="Close alert">×</button>
      )}
    </div>
  );
}
```

**Required CSS for alerts (using Sikt design tokens - NO GRADIENTS, solid colors with borders):**

```css
/* Base alert styling */
.alert {
  padding: var(--sds-space-padding-medium);
  border: var(--sds-size-border-regular) solid;
  border-radius: var(--sds-size-border-radius-small);
  margin-bottom: var(--sds-space-padding-medium);
  position: relative;
}

.alert-close {
  position: absolute;
  top: var(--sds-space-padding-small);
  right: var(--sds-space-padding-small);
  background: none;
  border: none;
  cursor: pointer;
  font-size: 20px;
  line-height: 1;
  padding: 0;
  opacity: 0.7;
}

.alert-close:hover {
  opacity: 1;
}

/* Success alert */
.alert-success {
  background-color: var(--sds-color-support-success-subtle);
  border-color: var(--sds-color-support-success-strong);
  color: var(--sds-color-text-success);
}

/* Error/Critical alert */
.alert-error {
  background-color: var(--sds-color-support-critical-subtle);
  border-color: var(--sds-color-support-critical-strong);
  color: var(--sds-color-text-critical);
}

/* Warning alert */
.alert-warning {
  background-color: var(--sds-color-support-warning-subtle);
  border-color: var(--sds-color-support-warning-strong);
  color: var(--sds-color-text-warning);
}

/* Info alert */
.alert-info {
  background-color: var(--sds-color-support-info-subtle);
  border-color: var(--sds-color-support-info-strong);
  color: var(--sds-color-text-info);
}
```

## Application Status Pattern

```jsx
import { Button } from '@sikt/sds-button';
import { useState, useEffect } from 'react';

function DataLoadingState() {
  const [status, setStatus] = useState('loading');
  const [data, setData] = useState(null);
  const [error, setError] = useState(null);

  const loadData = async () => {
    setStatus('loading');
    try {
      const response = await fetch('/api/data');
      const result = await response.json();
      setData(result);
      setStatus('success');
    } catch (err) {
      setError(err.message);
      setStatus('error');
    }
  };

  useEffect(() => {
    loadData();
  }, []);

  if (status === 'loading') {
    return (
      <div style={{ padding: '24px', textAlign: 'center' }}>
        <p>Loading data...</p>
        <p>Please wait while we fetch your information.</p>
      </div>
    );
  }

  if (status === 'error') {
    return (
      <div style={{ padding: '24px', textAlign: 'center', color: '#dc3545' }}>
        <h2>Failed to load data</h2>
        <p>{error}</p>
        <Button onClick={loadData}>Try Again</Button>
      </div>
    );
  }

  return <div>{/* Render data */}</div>;
}
```

## Form Error Summary

```jsx
function ErrorSummary({ errors }) {
  if (Object.keys(errors).length === 0) return null;

  return (
    <div style={{
      marginBottom: '24px',
      padding: '16px',
      backgroundColor: '#fde8e8',
      border: '2px solid #e84c3d',
      borderRadius: '4px'
    }}>
      <h2 style={{ margin: '0 0 12px 0', fontSize: '16px', fontWeight: 'bold' }}>
        Please correct the following errors:
      </h2>
      <ul style={{ margin: 0, paddingLeft: '24px' }}>
        {Object.entries(errors).map(([key, message]) => (
          <li key={key}>{message}</li>
        ))}
      </ul>
    </div>
  );
}
```

## Inline Validation Message

```jsx
function InlineError({ error }) {
  if (!error) return null;

  return (
    <span style={{ color: '#e84c3d', fontSize: '14px', display: 'block', marginTop: '4px' }}>
      {error}
    </span>
  );
}
```

## Banner Alert

```jsx
function BannerAlert({ message, variant = 'info', dismissible = false, onDismiss }) {
  return (
    <div style={{
      padding: '16px 24px',
      backgroundColor: variant === 'warning' ? '#fff3cd' : '#d1ecf1',
      borderBottom: `2px solid ${variant === 'warning' ? '#ffc107' : '#17a2b8'}`,
      display: 'flex',
      justifyContent: 'space-between',
      alignItems: 'center'
    }}>
      <p style={{ margin: 0 }}>{message}</p>
      {dismissible && (
        <button onClick={onDismiss} style={{ background: 'none', border: 'none', cursor: 'pointer', fontSize: '20px' }}>×</button>
      )}
    </div>
  );
}
```

## Best Practices

- Use appropriate variant for the message type (success, error, warning, info)
- Provide clear, actionable messages
- Auto-dismiss success messages after 5 seconds
- Keep error messages visible until user dismisses
- Position toasts consistently (typically top-right)
- Limit number of concurrent toasts (max 3-5)
- Ensure sufficient color contrast for accessibility
- Include dismiss buttons for persistent alerts

## Accessibility Best Practices

- Use appropriate ARIA roles (`role="alert"` for important messages)
- Ensure color is not the only indicator
- Provide text alternatives for icons
- Make dismiss buttons keyboard accessible
- Announce important alerts to screen readers

## Resources

- [Alert Component Patterns](https://designsystem.sikt.no/storybook/)
- [npm Package: @sikt/sds-core](https://www.npmjs.com/package/@sikt/sds-core)

## Related Skills

- **sikt-design-button**: Button components for alerts
- **sikt-design-form**: Form validation with alerts
- **sikt-design-general**: General design system guidelines
