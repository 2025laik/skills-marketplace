---
name: sikt-design-dialog
description: Ready-to-use code examples for Sikt dialog and modal components. Use when developers ask "How do I create a modal?", "Show me a confirmation dialog", "How to implement dialogs?", or need dialog implementations for confirmations, forms, and user interactions.
---

# Sikt Dialog and Modal Components

## Overview

This skill provides implementation examples for Sikt Design System dialog and modal patterns including confirmation dialogs, form dialogs, and various modal use cases.

## Installation

```bash
npm install @sikt/sds-dialog @sikt/sds-button @sikt/sds-input @sikt/sds-core
```

Import components and stylesheets:

```js
import { Dialog } from '@sikt/sds-dialog';
import { Button } from '@sikt/sds-button';
import { TextInput } from '@sikt/sds-input';
import '@sikt/sds-core/dist/index.css';
import '@sikt/sds-dialog/dist/index.css';
import '@sikt/sds-button/dist/index.css';
import '@sikt/sds-input/dist/index.css';
```

## Basic Dialog

```jsx
import { Dialog } from '@sikt/sds-dialog';
import { Button } from '@sikt/sds-button';
import { useState } from 'react';

function BasicDialog() {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <div>
      <Button onClick={() => setIsOpen(true)}>
        Open Dialog
      </Button>

      <Dialog
        open={isOpen}
        onClose={() => setIsOpen(false)}
        title="Dialog Title"
      >
        <p>Dialog content goes here.</p>

        <div style={{ display: 'flex', gap: '12px', marginTop: '24px', justifyContent: 'flex-end' }}>
          <Button variant="secondary" onClick={() => setIsOpen(false)}>
            Close
          </Button>
        </div>
      </Dialog>
    </div>
  );
}
```

## Confirmation Dialog

```jsx
import { Dialog } from '@sikt/sds-dialog';
import { Button } from '@sikt/sds-button';
import { useState } from 'react';

function DeleteConfirmationDialog({ isOpen, onClose, onConfirm, itemName }) {
  if (!isOpen) return null;

  return (
    <Dialog
      open={isOpen}
      onClose={onClose}
      title="Confirm Deletion"
    >
      <p id="dialog-description">
        Are you sure you want to delete "{itemName}"? This action cannot be undone.
      </p>

      <div style={{ display: 'flex', gap: '12px', marginTop: '24px', justifyContent: 'flex-end' }}>
        <Button variant="secondary" onClick={onClose}>
          Cancel
        </Button>
        <Button variant="danger" onClick={onConfirm}>
          Delete
        </Button>
      </div>
    </Dialog>
  );
}

// Usage
function ItemList() {
  const [dialogOpen, setDialogOpen] = useState(false);
  const [selectedItem, setSelectedItem] = useState(null);

  const handleDelete = (item) => {
    setSelectedItem(item);
    setDialogOpen(true);
  };

  const confirmDelete = () => {
    // Perform deletion
    console.log('Deleting:', selectedItem);
    setDialogOpen(false);
    setSelectedItem(null);
  };

  return (
    <div>
      {/* Item list */}
      <Button onClick={() => handleDelete({ id: 1, name: 'Item 1' })}>
        Delete Item
      </Button>

      <DeleteConfirmationDialog
        isOpen={dialogOpen}
        onClose={() => setDialogOpen(false)}
        onConfirm={confirmDelete}
        itemName={selectedItem?.name}
      />
    </div>
  );
}
```

## Form Dialog

```jsx
import { Dialog } from '@sikt/sds-dialog';
import { TextInput } from '@sikt/sds-input';
import { Button } from '@sikt/sds-button';
import { useState } from 'react';

function AddItemDialog({ isOpen, onClose, onAdd }) {
  const [name, setName] = useState('');
  const [description, setDescription] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    onAdd({ name, description });
    setName('');
    setDescription('');
    onClose();
  };

  return (
    <Dialog
      open={isOpen}
      onClose={onClose}
      title="Add New Item"
    >
      <form onSubmit={handleSubmit}>
        <TextInput
          label="Name"
          value={name}
          onChange={(e) => setName(e.target.value)}
          required
        />

        <TextInput
          label="Description"
          value={description}
          onChange={(e) => setDescription(e.target.value)}
        />

        <div style={{ display: 'flex', gap: '12px', marginTop: '24px' }}>
          <Button variant="secondary" type="button" onClick={onClose}>
            Cancel
          </Button>
          <Button type="submit">
            Add Item
          </Button>
        </div>
      </form>
    </Dialog>
  );
}
```

## Alert Dialog

```jsx
function AlertDialog({ isOpen, onClose, title, message }) {
  return (
    <Dialog
      open={isOpen}
      onClose={onClose}
      title={title}
    >
      <p>{message}</p>

      <div style={{ display: 'flex', gap: '12px', marginTop: '24px', justifyContent: 'flex-end' }}>
        <Button onClick={onClose}>
          OK
        </Button>
      </div>
    </Dialog>
  );
}
```

## Large Content Dialog

```jsx
function LargeContentDialog({ isOpen, onClose }) {
  return (
    <Dialog
      open={isOpen}
      onClose={onClose}
      title="Terms and Conditions"
      size="large"
    >
      <div style={{ maxHeight: '60vh', overflowY: 'auto', padding: '16px' }}>
        <h3>1. Introduction</h3>
        <p>Lorem ipsum dolor sit amet...</p>

        <h3>2. Terms of Service</h3>
        <p>Lorem ipsum dolor sit amet...</p>

        {/* More content */}
      </div>

      <div style={{ display: 'flex', gap: '12px', marginTop: '24px', justifyContent: 'flex-end' }}>
        <Button variant="secondary" onClick={onClose}>
          Decline
        </Button>
        <Button onClick={onClose}>
          Accept
        </Button>
      </div>
    </Dialog>
  );
}
```

## Multi-Step Dialog

```jsx
function MultiStepDialog({ isOpen, onClose }) {
  const [step, setStep] = useState(1);

  const handleNext = () => setStep(step + 1);
  const handleBack = () => setStep(step - 1);

  return (
    <Dialog
      open={isOpen}
      onClose={onClose}
      title={`Step ${step} of 3`}
    >
      {step === 1 && (
        <div>
          <p>Step 1 content</p>
          <Button onClick={handleNext}>Next</Button>
        </div>
      )}

      {step === 2 && (
        <div>
          <p>Step 2 content</p>
          <Button variant="secondary" onClick={handleBack}>Back</Button>
          <Button onClick={handleNext}>Next</Button>
        </div>
      )}

      {step === 3 && (
        <div>
          <p>Step 3 content</p>
          <Button variant="secondary" onClick={handleBack}>Back</Button>
          <Button onClick={onClose}>Finish</Button>
        </div>
      )}
    </Dialog>
  );
}
```

## Dialog with Loading State

```jsx
function LoadingDialog({ isOpen, onClose }) {
  const [loading, setLoading] = useState(false);

  const handleSubmit = async () => {
    setLoading(true);
    await performAsyncAction();
    setLoading(false);
    onClose();
  };

  return (
    <Dialog
      open={isOpen}
      onClose={loading ? undefined : onClose}
      title="Processing"
    >
      <p>Please wait while we process your request...</p>

      <div style={{ display: 'flex', gap: '12px', marginTop: '24px', justifyContent: 'flex-end' }}>
        <Button variant="secondary" onClick={onClose} disabled={loading}>
          Cancel
        </Button>
        <Button onClick={handleSubmit} disabled={loading}>
          {loading ? 'Processing...' : 'Submit'}
        </Button>
      </div>
    </Dialog>
  );
}
```

## Best Practices

### Dialog Usage
- Use dialogs for critical actions that require user attention
- Keep dialog content focused and concise
- Provide clear action buttons (primary and secondary)
- Include a close button or escape mechanism
- Prevent body scroll when dialog is open

### Confirmation Dialogs
- Clearly state what will happen
- Explain consequences of the action
- Use danger variant for destructive actions
- Provide cancel option

### Form Dialogs
- Keep forms simple and focused
- Validate before submission
- Show loading states during processing
- Close dialog on successful submission

## Accessibility Best Practices

- Use proper ARIA attributes (`role="dialog"`, `aria-labelledby`, `aria-describedby`)
- Trap focus within the dialog
- Close on Escape key press
- Return focus to trigger element after closing
- Use semantic HTML for dialog structure
- Ensure keyboard navigation works
- Provide clear focus indicators

## Resources

- [Dialog Component Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-dialog-readme--docs)
- [npm Package: @sikt/sds-dialog](https://www.npmjs.com/package/@sikt/sds-dialog)

## Related Skills

- **sikt-design-button**: Button components for dialogs
- **sikt-design-form**: Form components in dialogs
- **sikt-design-general**: General design system guidelines
