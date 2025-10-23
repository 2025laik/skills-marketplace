---
name: sikt-design-form
description: Ready-to-use code examples for Sikt form components. Use when developers ask "How do I build a form?", "Show me form validation", "How to use input fields?", or need complete form implementations with validation, accessibility, and best practices.
---

# Sikt Form Components

## Overview

This skill provides implementation examples for Sikt Design System form components including TextInput, CheckboxInput, Select, and complete form patterns with validation.

## Installation

```bash
npm install @sikt/sds-input @sikt/sds-checkbox @sikt/sds-select @sikt/sds-button @sikt/sds-section @sikt/sds-core
```

Import components:

```js
import { TextInput } from '@sikt/sds-input';
import { CheckboxInput } from '@sikt/sds-checkbox';
import { Select } from '@sikt/sds-select';
import { Button } from '@sikt/sds-button';
import { Section } from '@sikt/sds-section';
```

**IMPORTANT**: Do NOT import component-specific CSS files when using these components. The components handle their own styling. Only import `@sikt/sds-core/dist/index.css` if you need core styles for your application layout.

## Basic Text Input

```jsx
import { TextInput } from '@sikt/sds-input';
import { useState } from 'react';

function BasicInput() {
  const [value, setValue] = useState('');

  return (
    <TextInput
      label="Name"
      id="name"
      value={value}
      onChange={(e) => setValue(e.target.value)}
      placeholder="Enter your name"
      required
    />
  );
}
```

## Input Variants

### Email Input

```jsx
<TextInput
  label="Email Address"
  type="email"
  id="email"
  value={email}
  onChange={(e) => setEmail(e.target.value)}
  required
/>
```

### Password Input

```jsx
<TextInput
  label="Password"
  type="password"
  id="password"
  value={password}
  onChange={(e) => setPassword(e.target.value)}
  required
/>
```

### Textarea

```jsx
<label htmlFor="message">Message</label>
<textarea
  id="message"
  value={message}
  onChange={(e) => setMessage(e.target.value)}
  rows={5}
  required
  style={{ width: '100%', padding: '8px', border: '2px solid #ccc', borderRadius: '4px' }}
/>
```

## Checkbox Component

```jsx
import { CheckboxInput } from '@sikt/sds-checkbox';

function CheckboxExample() {
  const [checked, setChecked] = useState(false);

  return (
    <CheckboxInput
      label="I accept the terms and conditions"
      id="terms"
      isChecked={checked}
      onChange={(e) => setChecked(e.target.checked)}
    />
  );
}
```

## Radio Buttons

Note: There is no dedicated Radio component in the design system. Use native HTML radio inputs:

```jsx
function RadioExample() {
  const [selected, setSelected] = useState('');

  return (
    <fieldset>
      <legend>Select an option</legend>
      <div>
        <input
          type="radio"
          id="option1"
          name="preference"
          value="option1"
          checked={selected === 'option1'}
          onChange={(e) => setSelected(e.target.value)}
        />
        <label htmlFor="option1">Option 1</label>
      </div>
      <div>
        <input
          type="radio"
          id="option2"
          name="preference"
          value="option2"
          checked={selected === 'option2'}
          onChange={(e) => setSelected(e.target.value)}
        />
        <label htmlFor="option2">Option 2</label>
      </div>
      <div>
        <input
          type="radio"
          id="option3"
          name="preference"
          value="option3"
          checked={selected === 'option3'}
          onChange={(e) => setSelected(e.target.value)}
        />
        <label htmlFor="option3">Option 3</label>
      </div>
    </fieldset>
  );
}
```

## Select Dropdown

```jsx
import { Select } from '@sikt/sds-select';

function SelectExample() {
  const [value, setValue] = useState('');

  return (
    <Select
      label="Country"
      value={value}
      onChange={(e) => setValue(e.target.value)}
      options={[
        { value: '', label: 'Select a country' },
        { value: 'no', label: 'Norway' },
        { value: 'se', label: 'Sweden' },
        { value: 'dk', label: 'Denmark' }
      ]}
    />
  );
}
```

## Form with Validation

```jsx
import { TextInput } from '@sikt/sds-input';
import { CheckboxInput } from '@sikt/sds-checkbox';
import { Button } from '@sikt/sds-button';
import { useState } from 'react';

function ContactForm() {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    message: '',
    consent: false
  });
  const [errors, setErrors] = useState({});

  const validate = () => {
    const newErrors = {};

    if (!formData.name.trim()) {
      newErrors.name = 'Name is required';
    }

    if (!formData.email.trim()) {
      newErrors.email = 'Email is required';
    } else if (!/\S+@\S+\.\S+/.test(formData.email)) {
      newErrors.email = 'Email is invalid';
    }

    if (!formData.message.trim()) {
      newErrors.message = 'Message is required';
    }

    if (!formData.consent) {
      newErrors.consent = 'You must accept the terms';
    }

    return newErrors;
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    const validationErrors = validate();

    if (Object.keys(validationErrors).length > 0) {
      setErrors(validationErrors);
      return;
    }

    // Submit form
    console.log('Form submitted:', formData);
  };

  return (
    <form onSubmit={handleSubmit} noValidate>
      {Object.keys(errors).length > 0 && (
        <div style={{ marginBottom: '24px', padding: '16px', backgroundColor: '#fde8e8', border: '2px solid #e84c3d', borderRadius: '4px' }}>
          <h2 style={{ margin: '0 0 12px 0', fontSize: '16px', fontWeight: 'bold' }}>Please correct the following errors:</h2>
          <ul style={{ margin: 0, paddingLeft: '24px' }}>
            {Object.entries(errors).map(([key, message]) => (
              <li key={key}>{message}</li>
            ))}
          </ul>
        </div>
      )}

      <div style={{ marginBottom: '16px' }}>
        <TextInput
          label="Name"
          id="name"
          value={formData.name}
          onChange={(e) => setFormData({ ...formData, name: e.target.value })}
          aria-invalid={!!errors.name}
          required
        />
        {errors.name && <span style={{ color: '#e84c3d', fontSize: '14px' }}>{errors.name}</span>}
      </div>

      <div style={{ marginBottom: '16px' }}>
        <TextInput
          label="Email"
          type="email"
          id="email"
          value={formData.email}
          onChange={(e) => setFormData({ ...formData, email: e.target.value })}
          aria-invalid={!!errors.email}
          required
        />
        {errors.email && <span style={{ color: '#e84c3d', fontSize: '14px' }}>{errors.email}</span>}
      </div>

      <div style={{ marginBottom: '16px' }}>
        <label htmlFor="message">Message</label>
        <textarea
          id="message"
          value={formData.message}
          onChange={(e) => setFormData({ ...formData, message: e.target.value })}
          rows={5}
          required
          style={{ width: '100%', padding: '8px', border: '2px solid #ccc', borderRadius: '4px' }}
        />
        {errors.message && <span style={{ color: '#e84c3d', fontSize: '14px' }}>{errors.message}</span>}
      </div>

      <div style={{ marginBottom: '16px' }}>
        <CheckboxInput
          label="I accept the terms and conditions"
          id="consent"
          isChecked={formData.consent}
          onChange={(e) => setFormData({ ...formData, consent: e.target.checked })}
          aria-invalid={!!errors.consent}
        />
        {errors.consent && <span style={{ color: '#e84c3d', fontSize: '14px' }}>{errors.consent}</span>}
      </div>

      <Button type="submit">Send Message</Button>
    </form>
  );
}
```

## Multi-Step Form

```jsx
import { TextInput } from '@sikt/sds-input';
import { Button } from '@sikt/sds-button';
import { ProgressIndicator } from '@sikt/sds-progress-indicator';
import { useState } from 'react';

function MultiStepForm() {
  const [step, setStep] = useState(1);
  const [formData, setFormData] = useState({
    personalInfo: {},
    preferences: {},
    confirmation: {}
  });

  const totalSteps = 3;

  return (
    <div>
      <ProgressIndicator
        current={step}
        total={totalSteps}
        label={`Step ${step} of ${totalSteps}`}
      />

      {step === 1 && (
        <div>
          <h2>Personal Information</h2>
          <TextInput
            label="Full Name"
            value={formData.personalInfo.name || ''}
            onChange={(e) => setFormData({
              ...formData,
              personalInfo: { ...formData.personalInfo, name: e.target.value }
            })}
          />
          <Button onClick={() => setStep(2)}>Next</Button>
        </div>
      )}

      {step === 2 && (
        <div>
          <h2>Preferences</h2>
          <fieldset>
            <legend>Select your preference</legend>
            <div>
              <input
                type="radio"
                id="option1"
                name="preference"
                value="option1"
                checked={formData.preferences.choice === 'option1'}
                onChange={(e) => setFormData({
                  ...formData,
                  preferences: { ...formData.preferences, choice: e.target.value }
                })}
              />
              <label htmlFor="option1">Option 1</label>
            </div>
            <div>
              <input
                type="radio"
                id="option2"
                name="preference"
                value="option2"
                checked={formData.preferences.choice === 'option2'}
                onChange={(e) => setFormData({
                  ...formData,
                  preferences: { ...formData.preferences, choice: e.target.value }
                })}
              />
              <label htmlFor="option2">Option 2</label>
            </div>
          </fieldset>
          <Button variant="secondary" onClick={() => setStep(1)}>Back</Button>
          <Button onClick={() => setStep(3)}>Next</Button>
        </div>
      )}

      {step === 3 && (
        <div>
          <h2>Confirmation</h2>
          <p>Review your information...</p>
          <Button variant="secondary" onClick={() => setStep(2)}>Back</Button>
          <Button type="submit">Submit</Button>
        </div>
      )}
    </div>
  );
}
```

## Form with Section Grouping

```jsx
import { TextInput } from '@sikt/sds-input';
import { CheckboxInput } from '@sikt/sds-checkbox';
import { Button } from '@sikt/sds-button';
import { Section } from '@sikt/sds-section';
import { useState } from 'react';

function SectionedForm() {
  const [formData, setFormData] = useState({
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
    newsletter: false
  });

  return (
    <form>
      <Section title="Personal Information">
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '16px' }}>
          <TextInput
            label="First Name"
            value={formData.firstName}
            onChange={(e) => setFormData({ ...formData, firstName: e.target.value })}
            required
          />
          <TextInput
            label="Last Name"
            value={formData.lastName}
            onChange={(e) => setFormData({ ...formData, lastName: e.target.value })}
            required
          />
        </div>
      </Section>

      <Section title="Contact Details">
        <TextInput
          label="Email"
          type="email"
          value={formData.email}
          onChange={(e) => setFormData({ ...formData, email: e.target.value })}
          required
        />
        <TextInput
          label="Phone"
          type="tel"
          value={formData.phone}
          onChange={(e) => setFormData({ ...formData, phone: e.target.value })}
        />
      </Section>

      <Section title="Preferences">
        <CheckboxInput
          label="Subscribe to newsletter"
          isChecked={formData.newsletter}
          onChange={(e) => setFormData({ ...formData, newsletter: e.target.checked })}
        />
      </Section>

      <Button type="submit">Submit</Button>
    </form>
  );
}
```

## Form Validation Best Practices

- Validate on submit, not on every keystroke
- Show clear, specific error messages
- Use error summary for multiple errors
- Focus the first error field after validation
- Provide inline error messages
- Do not rely solely on color for errors

## Accessibility Best Practices

- Always include proper labels for form inputs
- Use `required` attribute for required fields
- Include `aria-invalid` for fields with errors
- Provide clear error messages
- Ensure keyboard navigation works
- Use semantic HTML elements

## Resources

- [Input Component Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-input-readme--docs)
- [npm Package: @sikt/sds-input](https://www.npmjs.com/package/@sikt/sds-input)
- [npm Package: @sikt/sds-checkbox](https://www.npmjs.com/package/@sikt/sds-checkbox)

## Related Skills

- **sikt-design-button**: Button components for forms
- **sikt-design-general**: General design system guidelines
- **sikt-design-dialog**: Form dialogs
