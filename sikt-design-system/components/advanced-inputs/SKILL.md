---
name: sikt-design-advanced-inputs
description: Ready-to-use code examples for Sikt advanced input components. Use when developers ask "How do I use a combobox?", "Show me datepicker examples", "How to implement file upload?", "How do I create a toggle switch?", or need specialized form input implementations.
---

# Sikt Advanced Input Components

## Overview

This skill provides implementation examples for Sikt Design System advanced input components including Combobox, InputDatepicker, InputFile, and Toggle switches.

## Installation

```bash
npm install @sikt/sds-combobox @sikt/sds-input-datepicker @sikt/sds-input-file @sikt/sds-toggle @sikt/sds-core
```

Import components and stylesheets:

```js
import { Combobox } from '@sikt/sds-combobox';
import { InputDatepicker } from '@sikt/sds-input-datepicker';
import { InputFile } from '@sikt/sds-input-file';
import { Toggle } from '@sikt/sds-toggle';
import '@sikt/sds-core/dist/index.css';
import '@sikt/sds-combobox/dist/index.css';
import '@sikt/sds-input-datepicker/dist/index.css';
import '@sikt/sds-input-file/dist/index.css';
import '@sikt/sds-toggle/dist/index.css';
```

## Combobox Component

### Basic Combobox

```jsx
import { Combobox } from '@sikt/sds-combobox';
import { useState } from 'react';

function BasicCombobox() {
  const [value, setValue] = useState('');

  const options = [
    { value: 'norway', label: 'Norway' },
    { value: 'sweden', label: 'Sweden' },
    { value: 'denmark', label: 'Denmark' },
    { value: 'finland', label: 'Finland' }
  ];

  return (
    <Combobox
      label="Select Country"
      options={options}
      value={value}
      onChange={(selected) => setValue(selected)}
      placeholder="Search countries..."
    />
  );
}
```

### Searchable Combobox

```jsx
import { Combobox } from '@sikt/sds-combobox';
import { useState } from 'react';

function SearchableCombobox() {
  const [value, setValue] = useState('');
  const [searchTerm, setSearchTerm] = useState('');

  const allOptions = [
    { value: '1', label: 'Option 1' },
    { value: '2', label: 'Option 2' },
    { value: '3', label: 'Option 3' },
    // ... many more options
  ];

  const filteredOptions = allOptions.filter(option =>
    option.label.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <Combobox
      label="Search and Select"
      options={filteredOptions}
      value={value}
      onChange={setValue}
      onSearchChange={setSearchTerm}
      placeholder="Type to search..."
    />
  );
}
```

### Multi-Select Combobox

```jsx
import { Combobox } from '@sikt/sds-combobox';
import { useState } from 'react';

function MultiSelectCombobox() {
  const [selectedValues, setSelectedValues] = useState([]);

  const options = [
    { value: 'react', label: 'React' },
    { value: 'vue', label: 'Vue' },
    { value: 'angular', label: 'Angular' },
    { value: 'svelte', label: 'Svelte' }
  ];

  return (
    <Combobox
      label="Select Technologies"
      options={options}
      value={selectedValues}
      onChange={setSelectedValues}
      multiple
      placeholder="Select one or more..."
    />
  );
}
```

## InputDatepicker Component

### Basic Datepicker

```jsx
import { InputDatepicker } from '@sikt/sds-input-datepicker';
import { useState } from 'react';

function BasicDatepicker() {
  const [date, setDate] = useState('');

  return (
    <InputDatepicker
      label="Select Date"
      value={date}
      onChange={(newDate) => setDate(newDate)}
      placeholder="DD/MM/YYYY"
    />
  );
}
```

### Date Range Picker

```jsx
import { InputDatepicker } from '@sikt/sds-input-datepicker';
import { useState } from 'react';

function DateRangePicker() {
  const [startDate, setStartDate] = useState('');
  const [endDate, setEndDate] = useState('');

  return (
    <div style={{ display: 'flex', gap: '16px' }}>
      <InputDatepicker
        label="Start Date"
        value={startDate}
        onChange={setStartDate}
        maxDate={endDate}
      />

      <InputDatepicker
        label="End Date"
        value={endDate}
        onChange={setEndDate}
        minDate={startDate}
      />
    </div>
  );
}
```

### Datepicker with Constraints

```jsx
import { InputDatepicker } from '@sikt/sds-input-datepicker';
import { useState } from 'react';

function ConstrainedDatepicker() {
  const [date, setDate] = useState('');

  const today = new Date();
  const maxDate = new Date();
  maxDate.setMonth(maxDate.getMonth() + 3);

  return (
    <InputDatepicker
      label="Select Appointment Date"
      value={date}
      onChange={setDate}
      minDate={today}
      maxDate={maxDate}
      disabledDays={[0, 6]} // Disable weekends
    />
  );
}
```

### Birthday Picker

```jsx
import { InputDatepicker } from '@sikt/sds-input-datepicker';
import { useState } from 'react';

function BirthdayPicker() {
  const [birthdate, setBirthdate] = useState('');

  const maxDate = new Date();
  maxDate.setFullYear(maxDate.getFullYear() - 18); // Must be 18+

  return (
    <InputDatepicker
      label="Date of Birth"
      value={birthdate}
      onChange={setBirthdate}
      maxDate={maxDate}
      yearRange={{ start: 1920, end: maxDate.getFullYear() }}
    />
  );
}
```

## InputFile Component

### Basic File Upload

```jsx
import { InputFile } from '@sikt/sds-input-file';
import { useState } from 'react';

function BasicFileUpload() {
  const [file, setFile] = useState(null);

  const handleFileChange = (event) => {
    const selectedFile = event.target.files[0];
    setFile(selectedFile);
  };

  return (
    <InputFile
      label="Upload File"
      onChange={handleFileChange}
      helperText="Maximum file size: 10MB"
    />
  );
}
```

### Multiple File Upload

```jsx
import { InputFile } from '@sikt/sds-input-file';
import { useState } from 'react';

function MultipleFileUpload() {
  const [files, setFiles] = useState([]);

  const handleFileChange = (event) => {
    const selectedFiles = Array.from(event.target.files);
    setFiles(selectedFiles);
  };

  return (
    <div>
      <InputFile
        label="Upload Files"
        onChange={handleFileChange}
        multiple
        helperText="Select one or more files"
      />

      {files.length > 0 && (
        <ul style={{ marginTop: '8px' }}>
          {files.map((file, idx) => (
            <li key={idx}>{file.name} ({(file.size / 1024).toFixed(2)} KB)</li>
          ))}
        </ul>
      )}
    </div>
  );
}
```

### File Upload with Restrictions

```jsx
import { InputFile } from '@sikt/sds-input-file';
import { useState } from 'react';

function RestrictedFileUpload() {
  const [file, setFile] = useState(null);
  const [error, setError] = useState('');

  const handleFileChange = (event) => {
    const selectedFile = event.target.files[0];

    // Validate file size (5MB max)
    if (selectedFile.size > 5 * 1024 * 1024) {
      setError('File size must be less than 5MB');
      setFile(null);
      return;
    }

    setError('');
    setFile(selectedFile);
  };

  return (
    <InputFile
      label="Upload Image"
      onChange={handleFileChange}
      accept="image/png,image/jpeg,image/jpg"
      helperText="Accepted formats: PNG, JPG, JPEG (max 5MB)"
      error={error}
    />
  );
}
```

### File Upload with Preview

```jsx
import { InputFile } from '@sikt/sds-input-file';
import { useState } from 'react';

function FileUploadWithPreview() {
  const [file, setFile] = useState(null);
  const [preview, setPreview] = useState('');

  const handleFileChange = (event) => {
    const selectedFile = event.target.files[0];
    setFile(selectedFile);

    // Create preview for images
    if (selectedFile && selectedFile.type.startsWith('image/')) {
      const reader = new FileReader();
      reader.onloadend = () => {
        setPreview(reader.result);
      };
      reader.readAsDataURL(selectedFile);
    }
  };

  return (
    <div>
      <InputFile
        label="Upload Profile Picture"
        onChange={handleFileChange}
        accept="image/*"
      />

      {preview && (
        <div style={{ marginTop: '16px' }}>
          <img
            src={preview}
            alt="Preview"
            style={{ maxWidth: '200px', maxHeight: '200px', borderRadius: '8px' }}
          />
        </div>
      )}
    </div>
  );
}
```

## Toggle Component

### Basic Toggle Switch

```jsx
import { Toggle } from '@sikt/sds-toggle';
import { useState } from 'react';

function BasicToggle() {
  const [enabled, setEnabled] = useState(false);

  return (
    <Toggle
      label="Enable notifications"
      checked={enabled}
      onChange={(e) => setEnabled(e.target.checked)}
    />
  );
}
```

### Toggle with Description

```jsx
import { Toggle } from '@sikt/sds-toggle';
import { useState } from 'react';

function ToggleWithDescription() {
  const [enabled, setEnabled] = useState(false);

  return (
    <Toggle
      label="Auto-save"
      description="Automatically save your work every 5 minutes"
      checked={enabled}
      onChange={(e) => setEnabled(e.target.checked)}
    />
  );
}
```

### Toggle Group

```jsx
import { Toggle } from '@sikt/sds-toggle';
import { useState } from 'react';

function ToggleGroup() {
  const [settings, setSettings] = useState({
    notifications: true,
    autoSave: false,
    darkMode: false
  });

  const handleToggle = (key) => {
    setSettings(prev => ({
      ...prev,
      [key]: !prev[key]
    }));
  };

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
      <Toggle
        label="Notifications"
        checked={settings.notifications}
        onChange={() => handleToggle('notifications')}
      />
      <Toggle
        label="Auto-save"
        checked={settings.autoSave}
        onChange={() => handleToggle('autoSave')}
      />
      <Toggle
        label="Dark Mode"
        checked={settings.darkMode}
        onChange={() => handleToggle('darkMode')}
      />
    </div>
  );
}
```

### Disabled Toggle

```jsx
import { Toggle } from '@sikt/sds-toggle';

function DisabledToggle() {
  return (
    <Toggle
      label="Premium Feature"
      description="Upgrade to premium to enable this feature"
      checked={false}
      disabled
    />
  );
}
```

## Combined Form Example

```jsx
import { Combobox } from '@sikt/sds-combobox';
import { InputDatepicker } from '@sikt/sds-input-datepicker';
import { InputFile } from '@sikt/sds-input-file';
import { Toggle } from '@sikt/sds-toggle';
import { Button } from '@sikt/sds-button';
import { useState } from 'react';

function AdvancedForm() {
  const [formData, setFormData] = useState({
    country: '',
    appointmentDate: '',
    document: null,
    notifications: true
  });

  const countries = [
    { value: 'no', label: 'Norway' },
    { value: 'se', label: 'Sweden' },
    { value: 'dk', label: 'Denmark' }
  ];

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log('Form submitted:', formData);
  };

  return (
    <form onSubmit={handleSubmit}>
      <Combobox
        label="Country"
        options={countries}
        value={formData.country}
        onChange={(value) => setFormData({ ...formData, country: value })}
      />

      <InputDatepicker
        label="Appointment Date"
        value={formData.appointmentDate}
        onChange={(date) => setFormData({ ...formData, appointmentDate: date })}
      />

      <InputFile
        label="Upload Document"
        onChange={(e) => setFormData({ ...formData, document: e.target.files[0] })}
      />

      <Toggle
        label="Enable notifications"
        checked={formData.notifications}
        onChange={(e) => setFormData({ ...formData, notifications: e.target.checked })}
      />

      <Button type="submit">Submit</Button>
    </form>
  );
}
```

## Best Practices

### Combobox
- Use for large option sets (>10 items)
- Provide clear placeholder text
- Implement search/filter functionality
- Show loading states for async data

### Datepicker
- Use appropriate date format for locale
- Set reasonable min/max constraints
- Disable unavailable dates
- Provide keyboard navigation

### File Upload
- Validate file types and sizes
- Show upload progress for large files
- Provide clear error messages
- Display file previews when applicable

### Toggle
- Use for immediate binary actions
- Provide clear labels
- Show current state clearly
- Use descriptive helper text

## Accessibility Best Practices

- Provide clear labels for all inputs
- Use appropriate ARIA attributes
- Ensure keyboard navigation works
- Provide error messages and validation
- Make disabled states clear
- Support screen readers

## Resources

- [Combobox Component Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-combobox--docs)
- [InputDatepicker Component Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-input-datepicker--docs)
- [InputFile Component Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-input-file--docs)
- [Toggle Component Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-toggle--docs)
- [npm Package: @sikt/sds-combobox](https://www.npmjs.com/package/@sikt/sds-combobox)
- [npm Package: @sikt/sds-input-datepicker](https://www.npmjs.com/package/@sikt/sds-input-datepicker)
- [npm Package: @sikt/sds-input-file](https://www.npmjs.com/package/@sikt/sds-input-file)
- [npm Package: @sikt/sds-toggle](https://www.npmjs.com/package/@sikt/sds-toggle)

## Related Skills

- **sikt-design-form**: Basic form components
- **sikt-design-button**: Button components for forms
- **sikt-design-general**: General design system guidelines
