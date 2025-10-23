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

Import components and stylesheets:

```js
import { Button } from '@sikt/sds-button';
import '@sikt/sds-core/dist/index.css';
import '@sikt/sds-button/dist/index.css';
```

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

  const variantStyles = {
    success: { backgroundColor: '#d4edda', borderColor: '#28a745', color: '#155724' },
    error: { backgroundColor: '#f8d7da', borderColor: '#dc3545', color: '#721c24' },
    warning: { backgroundColor: '#fff3cd', borderColor: '#ffc107', color: '#856404' },
    info: { backgroundColor: '#d1ecf1', borderColor: '#17a2b8', color: '#0c5460' }
  };

  return (
    <div style={{
      position: 'fixed',
      top: '20px',
      right: '20px',
      zIndex: 1000,
      maxWidth: '400px',
      padding: '16px',
      border: '2px solid',
      borderRadius: '4px',
      ...variantStyles[variant]
    }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'start' }}>
        <p style={{ margin: 0 }}>{message}</p>
        <button onClick={onClose} style={{ background: 'none', border: 'none', cursor: 'pointer', fontSize: '20px' }}>×</button>
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

## Alert Variants

### Success Alert

```jsx
function SuccessAlert({ message, onClose }) {
  return (
    <div style={{
      padding: '16px',
      backgroundColor: '#d4edda',
      border: '2px solid #28a745',
      borderRadius: '4px',
      color: '#155724',
      marginBottom: '16px'
    }}>
      <strong>Success:</strong> {message}
      {onClose && (
        <button onClick={onClose} style={{ float: 'right', background: 'none', border: 'none', cursor: 'pointer' }}>×</button>
      )}
    </div>
  );
}
```

### Error Alert

```jsx
function ErrorAlert({ message, onClose }) {
  return (
    <div style={{
      padding: '16px',
      backgroundColor: '#f8d7da',
      border: '2px solid #dc3545',
      borderRadius: '4px',
      color: '#721c24',
      marginBottom: '16px'
    }}>
      <strong>Error:</strong> {message}
      {onClose && (
        <button onClick={onClose} style={{ float: 'right', background: 'none', border: 'none', cursor: 'pointer' }}>×</button>
      )}
    </div>
  );
}
```

### Warning Alert

```jsx
function WarningAlert({ message, onClose }) {
  return (
    <div style={{
      padding: '16px',
      backgroundColor: '#fff3cd',
      border: '2px solid #ffc107',
      borderRadius: '4px',
      color: '#856404',
      marginBottom: '16px'
    }}>
      <strong>Warning:</strong> {message}
      {onClose && (
        <button onClick={onClose} style={{ float: 'right', background: 'none', border: 'none', cursor: 'pointer' }}>×</button>
      )}
    </div>
  );
}
```

### Info Alert

```jsx
function InfoAlert({ message, onClose }) {
  return (
    <div style={{
      padding: '16px',
      backgroundColor: '#d1ecf1',
      border: '2px solid #17a2b8',
      borderRadius: '4px',
      color: '#0c5460',
      marginBottom: '16px'
    }}>
      <strong>Info:</strong> {message}
      {onClose && (
        <button onClick={onClose} style={{ float: 'right', background: 'none', border: 'none', cursor: 'pointer' }}>×</button>
      )}
    </div>
  );
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
