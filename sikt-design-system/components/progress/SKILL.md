---
name: sikt-design-progress
description: Ready-to-use code examples for Sikt progress indicator components. Use when developers ask "How do I show progress?", "Show me loading spinners", "How to implement progress bars?", or need progress visualization for loading states, task completion, and multi-step workflows.
---

# Sikt Progress Indicator Components

## Overview

This skill provides implementation examples for Sikt Design System progress indicator components including progress bars, loading spinners, and step indicators.

## Installation

```bash
npm install @sikt/sds-progress-indicator @sikt/sds-core
```

Import components:

```js
import { ProgressIndicator, ProgressBar, Spinner } from '@sikt/sds-progress-indicator';
```

**IMPORTANT**: Do NOT import component-specific CSS files when using these components. The components handle their own styling. Only import `@sikt/sds-core/dist/index.css` if you need core styles for your application layout.

## Progress Bar

### Basic Progress Bar

```jsx
import { ProgressBar } from '@sikt/sds-progress-indicator';

function BasicProgressBar() {
  const progress = 65; // 0-100

  return (
    <ProgressBar
      value={progress}
      max={100}
      label={`${progress}% complete`}
    />
  );
}
```

### File Upload Progress

```jsx
import { ProgressBar } from '@sikt/sds-progress-indicator';
import { useState, useEffect } from 'react';

function FileUploadProgress() {
  const [progress, setProgress] = useState(0);

  const simulateUpload = () => {
    const interval = setInterval(() => {
      setProgress(prev => {
        if (prev >= 100) {
          clearInterval(interval);
          return 100;
        }
        return prev + 10;
      });
    }, 500);
  };

  return (
    <div>
      <h3>Uploading file...</h3>
      <ProgressBar
        value={progress}
        max={100}
        label={`${progress}% uploaded`}
      />
      <button onClick={simulateUpload}>Start Upload</button>
    </div>
  );
}
```

### Determinate Progress

```jsx
import { ProgressBar } from '@sikt/sds-progress-indicator';
import { useState, useEffect } from 'react';

function DeterminateProgress() {
  const [progress, setProgress] = useState(0);
  const totalSteps = 5;
  const [currentStep, setCurrentStep] = useState(1);

  useEffect(() => {
    setProgress((currentStep / totalSteps) * 100);
  }, [currentStep]);

  return (
    <div>
      <ProgressBar
        value={progress}
        max={100}
        label={`Step ${currentStep} of ${totalSteps}`}
      />
      <button onClick={() => setCurrentStep(prev => Math.min(prev + 1, totalSteps))}>
        Next Step
      </button>
    </div>
  );
}
```

## Loading Spinner

### Basic Spinner

```jsx
import { Spinner } from '@sikt/sds-progress-indicator';

function BasicSpinner() {
  return (
    <div style={{ display: 'flex', justifyContent: 'center', padding: '24px' }}>
      <Spinner label="Loading..." />
    </div>
  );
}
```

### Inline Spinner

```jsx
import { Spinner } from '@sikt/sds-progress-indicator';
import { Button } from '@sikt/sds-button';
import { useState } from 'react';

function InlineSpinner() {
  const [loading, setLoading] = useState(false);

  const handleClick = async () => {
    setLoading(true);
    await new Promise(resolve => setTimeout(resolve, 2000));
    setLoading(false);
  };

  return (
    <Button onClick={handleClick} disabled={loading}>
      {loading && <Spinner size="small" />}
      {loading ? 'Loading...' : 'Load Data'}
    </Button>
  );
}
```

### Page Loading

```jsx
import { Spinner } from '@sikt/sds-progress-indicator';

function PageLoading() {
  return (
    <div style={{
      position: 'fixed',
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center',
      backgroundColor: 'rgba(255, 255, 255, 0.9)'
    }}>
      <Spinner size="large" label="Loading page..." />
    </div>
  );
}
```

## Step Indicator

### Multi-Step Progress

```jsx
import { ProgressIndicator } from '@sikt/sds-progress-indicator';
import { useState } from 'react';

function MultiStepProgress() {
  const [currentStep, setCurrentStep] = useState(1);
  const totalSteps = 4;

  const steps = [
    { number: 1, label: 'Personal Info' },
    { number: 2, label: 'Address' },
    { number: 3, label: 'Payment' },
    { number: 4, label: 'Confirmation' }
  ];

  return (
    <div>
      <ProgressIndicator
        current={currentStep}
        total={totalSteps}
        steps={steps}
      />

      <div style={{ marginTop: '24px' }}>
        <Button
          variant="secondary"
          onClick={() => setCurrentStep(Math.max(1, currentStep - 1))}
          disabled={currentStep === 1}
        >
          Previous
        </Button>
        <Button
          onClick={() => setCurrentStep(Math.min(totalSteps, currentStep + 1))}
          disabled={currentStep === totalSteps}
        >
          Next
        </Button>
      </div>
    </div>
  );
}
```

### Wizard Steps

```jsx
import { ProgressIndicator } from '@sikt/sds-progress-indicator';
import { useState } from 'react';

function WizardSteps() {
  const [currentStep, setCurrentStep] = useState(1);

  const steps = [
    { number: 1, label: 'Account', status: 'completed' },
    { number: 2, label: 'Profile', status: 'current' },
    { number: 3, label: 'Preferences', status: 'upcoming' }
  ];

  return (
    <ProgressIndicator
      current={currentStep}
      total={3}
      steps={steps}
    />
  );
}
```

## Indeterminate Progress

```jsx
import { ProgressBar } from '@sikt/sds-progress-indicator';

function IndeterminateProgress() {
  return (
    <div>
      <h3>Processing...</h3>
      <ProgressBar indeterminate label="Please wait" />
    </div>
  );
}
```

## Combined Examples

### Form with Progress

```jsx
import { ProgressIndicator } from '@sikt/sds-progress-indicator';
import { TextInput } from '@sikt/sds-input';
import { Button } from '@sikt/sds-button';
import { useState } from 'react';

function FormWithProgress() {
  const [step, setStep] = useState(1);
  const totalSteps = 3;

  return (
    <div>
      <ProgressIndicator
        current={step}
        total={totalSteps}
        label={`Step ${step} of ${totalSteps}`}
      />

      <form style={{ marginTop: '24px' }}>
        {step === 1 && (
          <div>
            <h2>Personal Information</h2>
            <TextInput label="Name" />
            <Button onClick={() => setStep(2)}>Continue</Button>
          </div>
        )}

        {step === 2 && (
          <div>
            <h2>Contact Details</h2>
            <TextInput label="Email" type="email" />
            <Button variant="secondary" onClick={() => setStep(1)}>Back</Button>
            <Button onClick={() => setStep(3)}>Continue</Button>
          </div>
        )}

        {step === 3 && (
          <div>
            <h2>Confirmation</h2>
            <p>Review your information</p>
            <Button variant="secondary" onClick={() => setStep(2)}>Back</Button>
            <Button type="submit">Submit</Button>
          </div>
        )}
      </form>
    </div>
  );
}
```

## Best Practices

- Use determinate progress when duration is known
- Use indeterminate progress for unknown durations
- Provide clear labels and status messages
- Show percentage when meaningful
- Keep users informed of long operations

## Accessibility

- Use proper ARIA attributes (`role="progressbar"`)
- Provide text alternatives
- Announce progress changes to screen readers
- Ensure sufficient contrast

## Resources

- [ProgressIndicator Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-progress-indicator--docs)
- [npm Package: @sikt/sds-progress-indicator](https://www.npmjs.com/package/@sikt/sds-progress-indicator)

## Related Skills

- **sikt-design-form**: Multi-step forms
- **sikt-design-button**: Loading buttons
- **sikt-design-general**: General guidelines
