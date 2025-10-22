---
name: sikt-design-components
description: Ready-to-use code examples for Sikt components. Use when developers ask "How do I build a form?", "Show me a table example", "How to implement a modal?", "Give me code for alerts", or need complete working implementations with validation, accessibility, and best practices.
---

# Sikt Component Implementation Examples

## Overview

This skill provides copy-paste ready code examples for common UI patterns using Sikt Design System. When developers ask for implementation help, use these proven patterns with correct npm imports.

**Common Developer Requests:**
- "Show me how to build a form with validation"
- "I need a table with sorting and pagination"
- "How do I implement a confirmation dialog?"
- "Give me an example of alert messages"
- "Show me a layout with header and footer"
- "How do I create tabs?"
- "I need a search and filter component"

## Installation First

Before implementing any patterns, install required packages:

```bash
# Core is always required
npm install @sikt/sds-core

# Add specific components you need
npm install @sikt/sds-button @sikt/sds-input @sikt/sds-form
```

Then import components and stylesheets in your application:

```js
// Import component CSS
import '@sikt/sds-core/dist/index.css';
import '@sikt/sds-button/dist/index.css';
import '@sikt/sds-input/dist/index.css';
```

## When to Use This Skill

**Use this skill when developers:**
- Ask for code examples ("Show me...", "How do I build...", "Give me an example...")
- Need complete implementations, not just concepts
- Want to see validation patterns
- Need accessibility best practices in code
- Ask about specific patterns (forms, tables, modals, navigation)
- Need correct npm package imports and CSS setup

## Component Implementation Patterns

### 1. Form Implementation

#### Basic Form with Validation

```jsx
import { TextInput } from '@sikt/sds-input';
import { Checkbox } from '@sikt/sds-checkbox';
import { Button } from '@sikt/sds-button';
import '@sikt/sds-core/dist/index.css';
import '@sikt/sds-input/dist/index.css';
import '@sikt/sds-checkbox/dist/index.css';
import '@sikt/sds-button/dist/index.css';
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
        <Checkbox
          label="I accept the terms and conditions"
          id="consent"
          checked={formData.consent}
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

#### Multi-Step Form

```jsx
import { TextInput } from '@sikt/sds-input';
import { Radio } from '@sikt/sds-radio';
import { Button } from '@sikt/sds-button';
import { ProgressIndicator } from '@sikt/sds-progress-indicator';
import '@sikt/sds-core/dist/index.css';
import '@sikt/sds-input/dist/index.css';
import '@sikt/sds-radio/dist/index.css';
import '@sikt/sds-button/dist/index.css';
import '@sikt/sds-progress-indicator/dist/index.css';
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
          <Radio
            name="preference"
            options={[
              { value: 'option1', label: 'Option 1' },
              { value: 'option2', label: 'Option 2' }
            ]}
            value={formData.preferences.choice}
            onChange={(e) => setFormData({
              ...formData,
              preferences: { ...formData.preferences, choice: e.target.value }
            })}
          />
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

### 2. Alert and Feedback Patterns

#### Toast Notification System

```jsx
import { Button } from '@sikt/sds-button';
import '@sikt/sds-core/dist/index.css';
import '@sikt/sds-button/dist/index.css';
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

#### Application Status Pattern

```jsx
import { Button } from '@sikt/sds-button';
import '@sikt/sds-core/dist/index.css';
import '@sikt/sds-button/dist/index.css';
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

### 3. Dialog and Modal Patterns

#### Confirmation Dialog

```jsx
import { Dialog } from '@sikt/sds-dialog';
import { Button } from '@sikt/sds-button';
import '@sikt/sds-core/dist/index.css';
import '@sikt/sds-dialog/dist/index.css';
import '@sikt/sds-button/dist/index.css';

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

#### Form Dialog

```jsx
import { Dialog } from '@sikt/sds-dialog';
import { TextInput } from '@sikt/sds-input';
import { Button } from '@sikt/sds-button';
import '@sikt/sds-core/dist/index.css';
import '@sikt/sds-dialog/dist/index.css';
import '@sikt/sds-input/dist/index.css';
import '@sikt/sds-button/dist/index.css';
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

### 4. Table Patterns

#### Sortable Data Table

```jsx
import { Table } from '@sikt/sds-table';
import { Button } from '@sikt/sds-button';
import '@sikt/sds-core/dist/index.css';
import '@sikt/sds-table/dist/index.css';
import '@sikt/sds-button/dist/index.css';
import { useState } from 'react';

function SortableTable({ data }) {
  const [sortConfig, setSortConfig] = useState({ key: null, direction: 'asc' });

  const sortedData = [...data].sort((a, b) => {
    if (!sortConfig.key) return 0;

    const aValue = a[sortConfig.key];
    const bValue = b[sortConfig.key];

    if (aValue < bValue) {
      return sortConfig.direction === 'asc' ? -1 : 1;
    }
    if (aValue > bValue) {
      return sortConfig.direction === 'asc' ? 1 : -1;
    }
    return 0;
  });

  const requestSort = (key) => {
    let direction = 'asc';
    if (sortConfig.key === key && sortConfig.direction === 'asc') {
      direction = 'desc';
    }
    setSortConfig({ key, direction });
  };

  return (
    <Table>
      <thead>
        <tr>
          <th>
            <Button
              variant="text"
              onClick={() => requestSort('name')}
            >
              Name {sortConfig.key === 'name' && (sortConfig.direction === 'asc' ? '↑' : '↓')}
            </Button>
          </th>
          <th>
            <Button
              variant="text"
              onClick={() => requestSort('email')}
            >
              Email {sortConfig.key === 'email' && (sortConfig.direction === 'asc' ? '↑' : '↓')}
            </Button>
          </th>
          <th>
            <Button
              variant="text"
              onClick={() => requestSort('date')}
            >
              Date {sortConfig.key === 'date' && (sortConfig.direction === 'asc' ? '↑' : '↓')}
            </Button>
          </th>
        </tr>
      </thead>
      <tbody>
        {sortedData.map((row, index) => (
          <tr key={index}>
            <td>{row.name}</td>
            <td>{row.email}</td>
            <td>{row.date}</td>
          </tr>
        ))}
      </tbody>
    </Table>
  );
}
```

#### Paginated Table

```jsx
import { Table } from '@sikt/sds-table';
import { Pagination } from '@sikt/sds-pagination';
import '@sikt/sds-core/dist/index.css';
import '@sikt/sds-table/dist/index.css';
import '@sikt/sds-pagination/dist/index.css';
import { useState } from 'react';

function PaginatedTable({ data, itemsPerPage = 10 }) {
  const [currentPage, setCurrentPage] = useState(1);

  const totalPages = Math.ceil(data.length / itemsPerPage);
  const startIndex = (currentPage - 1) * itemsPerPage;
  const endIndex = startIndex + itemsPerPage;
  const currentData = data.slice(startIndex, endIndex);

  return (
    <div>
      <Table>
        <thead>
          <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          {currentData.map((row, index) => (
            <tr key={index}>
              <td>{row.name}</td>
              <td>{row.email}</td>
              <td>{row.status}</td>
            </tr>
          ))}
        </tbody>
      </Table>

      <Pagination
        currentPage={currentPage}
        totalPages={totalPages}
        onPageChange={setCurrentPage}
      />
    </div>
  );
}
```

### 5. Layout Patterns

#### Page Layout with Header and Footer

```jsx
import { Header } from '@sikt/sds-header';
import { Footer } from '@sikt/sds-footer';
import '@sikt/sds-core/dist/index.css';
import '@sikt/sds-header/dist/index.css';
import '@sikt/sds-footer/dist/index.css';

function PageLayout({ children }) {
  return (
    <div style={{ minHeight: '100vh', display: 'flex', flexDirection: 'column' }}>
      <Header
        navigation={[
          { label: 'Home', href: '/' },
          { label: 'About', href: '/about' },
          { label: 'Contact', href: '/contact' }
        ]}
      />

      <main style={{ flex: 1, maxWidth: '1200px', margin: '0 auto', width: '100%', padding: '0 16px' }}>
        {children}
      </main>

      <Footer
        links={[
          { label: 'Privacy Policy', href: '/privacy' },
          { label: 'Terms of Service', href: '/terms' },
          { label: 'Accessibility', href: '/accessibility' }
        ]}
        copyright="© 2024 Sikt. All rights reserved."
      />
    </div>
  );
}
```

#### Card Grid Layout

```jsx
import { Card } from '@sikt/sds-card';
import { Button } from '@sikt/sds-button';
import '@sikt/sds-core/dist/index.css';
import '@sikt/sds-card/dist/index.css';
import '@sikt/sds-button/dist/index.css';

function CardGrid({ items }) {
  return (
    <div style={{
      display: 'grid',
      gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))',
      gap: '24px'
    }}>
      {items.map((item, index) => (
        <Card key={index}>
          {item.image && (
            <img
              src={item.image}
              alt={item.title}
              style={{ width: '100%', height: '200px', objectFit: 'cover', borderRadius: '4px 4px 0 0' }}
            />
          )}
          <div style={{ padding: '16px' }}>
            <h3 style={{ margin: '0 0 8px 0' }}>{item.title}</h3>
            <p style={{ margin: '0 0 16px 0', color: '#666' }}>{item.description}</p>
            <a href={item.link}><Button>Learn More</Button></a>
          </div>
        </Card>
      ))}
    </div>
  );
}
```

### 6. Navigation Patterns

#### Tabs with Content

```jsx
import { Tabs } from '@sikt/sds-tabs';
import '@sikt/sds-core/dist/index.css';
import '@sikt/sds-tabs/dist/index.css';
import { useState } from 'react';

function TabbedContent() {
  const [activeTab, setActiveTab] = useState('overview');

  const tabs = [
    { id: 'overview', label: 'Overview' },
    { id: 'details', label: 'Details' },
    { id: 'settings', label: 'Settings' }
  ];

  return (
    <div>
      <Tabs
        tabs={tabs}
        activeTab={activeTab}
        onChange={setActiveTab}
      />

      <section style={{ padding: '24px 0' }}>
        {activeTab === 'overview' && (
          <div>
            <h2>Overview</h2>
            <p>Overview content...</p>
          </div>
        )}

        {activeTab === 'details' && (
          <div>
            <h2>Details</h2>
            <p>Detailed information...</p>
          </div>
        )}

        {activeTab === 'settings' && (
          <div>
            <h2>Settings</h2>
            <p>Settings options...</p>
          </div>
        )}
      </section>
    </div>
  );
}
```

#### Breadcrumb Navigation

```jsx
import { Breadcrumbs } from '@sikt/sds-breadcrumbs';
import '@sikt/sds-core/dist/index.css';
import '@sikt/sds-breadcrumbs/dist/index.css';

function ProductPage({ category, subcategory, product }) {
  const breadcrumbItems = [
    { label: 'Home', href: '/' },
    { label: category, href: `/category/${category}` },
    { label: subcategory, href: `/category/${category}/${subcategory}` },
    { label: product, href: '#', current: true }
  ];

  return (
    <div>
      <Breadcrumbs items={breadcrumbItems} />
      {/* Page content */}
    </div>
  );
}
```

### 7. Search and Filter Patterns

```jsx
import { TextInput } from '@sikt/sds-input';
import { Select } from '@sikt/sds-select';
import { Button } from '@sikt/sds-button';
import '@sikt/sds-core/dist/index.css';
import '@sikt/sds-input/dist/index.css';
import '@sikt/sds-select/dist/index.css';
import '@sikt/sds-button/dist/index.css';
import { useState } from 'react';

function SearchAndFilter({ data }) {
  const [searchTerm, setSearchTerm] = useState('');
  const [categoryFilter, setCategoryFilter] = useState('all');
  const [statusFilter, setStatusFilter] = useState('all');

  const filteredData = data.filter(item => {
    const matchesSearch = item.name.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesCategory = categoryFilter === 'all' || item.category === categoryFilter;
    const matchesStatus = statusFilter === 'all' || item.status === statusFilter;

    return matchesSearch && matchesCategory && matchesStatus;
  });

  const clearFilters = () => {
    setSearchTerm('');
    setCategoryFilter('all');
    setStatusFilter('all');
  };

  return (
    <div>
      <div style={{ display: 'flex', gap: '12px', marginBottom: '24px' }}>
        <TextInput
          label="Search"
          placeholder="Search items..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
        />

        <Select
          label="Category"
          value={categoryFilter}
          onChange={(e) => setCategoryFilter(e.target.value)}
          options={[
            { value: 'all', label: 'All Categories' },
            { value: 'category1', label: 'Category 1' },
            { value: 'category2', label: 'Category 2' }
          ]}
        />

        <Select
          label="Status"
          value={statusFilter}
          onChange={(e) => setStatusFilter(e.target.value)}
          options={[
            { value: 'all', label: 'All Statuses' },
            { value: 'active', label: 'Active' },
            { value: 'inactive', label: 'Inactive' }
          ]}
        />

        <Button variant="secondary" onClick={clearFilters}>
          Clear Filters
        </Button>
      </div>

      <div style={{ marginTop: '24px' }}>
        {filteredData.length > 0 ? (
          <ul style={{ listStyle: 'none', padding: 0 }}>
            {filteredData.map((item, idx) => (
              <li key={idx} style={{ padding: '12px', borderBottom: '1px solid #eee' }}>
                <strong>{item.name}</strong> - {item.status}
              </li>
            ))}
          </ul>
        ) : (
          <p>No items found matching your search.</p>
        )}
      </div>
    </div>
  );
}
```

## Best Practices

### Accessibility
- Always include proper labels for form inputs
- Use semantic HTML elements
- Ensure keyboard navigation works
- Provide clear focus indicators
- Include ARIA attributes where needed
- Test with screen readers

### Form Validation
- Validate on submit, not on every keystroke
- Show clear, specific error messages
- Use ErrorSummary for multiple errors
- Focus the first error field after validation
- Provide inline error messages
- Don't rely solely on color for errors

### Performance
- Lazy load heavy components (tables, modals)
- Debounce search inputs
- Virtualize long lists
- Memoize expensive computations
- Use proper React keys for lists

### User Experience
- Provide loading states for async operations
- Show success feedback after actions
- Use confirmation dialogs for destructive actions
- Maintain context during navigation
- Ensure responsive behavior across devices

## Resources

Full documentation and component mapping available in the `references/` directory.

## Related Skills

- **sikt-design-system**: Main design system overview and guidelines
- **sikt-design-storybook**: Generate Storybook documentation URLs
