---
name: sikt-design-components
description: Ready-to-use code examples for Sikt components. Use when developers ask "How do I build a form?", "Show me a table example", "How to implement a modal?", "Give me code for alerts", or need complete working implementations with validation, accessibility, and best practices.
---

# Sikt Component Implementation Examples

## Overview

This skill provides copy-paste ready code examples for common UI patterns. When developers ask for implementation help, use these proven patterns.

**Common Developer Requests:**
- "Show me how to build a form with validation"
- "I need a table with sorting and pagination"
- "How do I implement a confirmation dialog?"
- "Give me an example of alert messages"
- "Show me a layout with header and footer"
- "How do I create tabs?"
- "I need a search and filter component"

## When to Use This Skill

**Use this skill when developers:**
- Ask for code examples ("Show me...", "How do I build...", "Give me an example...")
- Need complete implementations, not just concepts
- Want to see validation patterns
- Need accessibility best practices in code
- Ask about specific patterns (forms, tables, modals, navigation)

## Component Implementation Patterns

### 1. Form Implementation

#### Basic Form with Validation

```jsx
import { TextInput, TextArea, Checkbox, Button, ErrorSummary } from '@sikt/design-system';

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
        <ErrorSummary
          title="Please correct the following errors:"
          errors={Object.entries(errors).map(([key, message]) => ({
            field: key,
            message
          }))}
        />
      )}

      <TextInput
        label="Name"
        id="name"
        value={formData.name}
        onChange={(e) => setFormData({ ...formData, name: e.target.value })}
        error={errors.name}
        required
      />

      <TextInput
        label="Email"
        type="email"
        id="email"
        value={formData.email}
        onChange={(e) => setFormData({ ...formData, email: e.target.value })}
        error={errors.email}
        required
      />

      <TextArea
        label="Message"
        id="message"
        value={formData.message}
        onChange={(e) => setFormData({ ...formData, message: e.target.value })}
        error={errors.message}
        rows={5}
        required
      />

      <Checkbox
        label="I accept the terms and conditions"
        id="consent"
        checked={formData.consent}
        onChange={(e) => setFormData({ ...formData, consent: e.target.checked })}
        error={errors.consent}
      />

      <Button type="submit">Send Message</Button>
    </form>
  );
}
```

#### Multi-Step Form

```jsx
import { TextInput, Radio, Button, ProgressIndicator } from '@sikt/design-system';

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
          <Heading level={2}>Personal Information</Heading>
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
          <Heading level={2}>Preferences</Heading>
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
          <Heading level={2}>Confirmation</Heading>
          <Paragraph>Review your information...</Paragraph>
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
import { Alert } from '@sikt/design-system';
import { useState, useEffect } from 'react';

function ToastNotification({ message, variant, duration = 5000, onClose }) {
  useEffect(() => {
    const timer = setTimeout(() => {
      onClose();
    }, duration);

    return () => clearTimeout(timer);
  }, [duration, onClose]);

  return (
    <div style={{
      position: 'fixed',
      top: '20px',
      right: '20px',
      zIndex: 1000,
      maxWidth: '400px'
    }}>
      <Alert variant={variant} onClose={onClose}>
        {message}
      </Alert>
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
import { ApplicationStatus, Button } from '@sikt/design-system';

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
      <ApplicationStatus
        variant="loading"
        title="Loading data..."
        message="Please wait while we fetch your information."
      />
    );
  }

  if (status === 'error') {
    return (
      <ApplicationStatus
        variant="error"
        title="Failed to load data"
        message={error}
        action={<Button onClick={loadData}>Try Again</Button>}
      />
    );
  }

  return <div>{/* Render data */}</div>;
}
```

### 3. Dialog and Modal Patterns

#### Confirmation Dialog

```jsx
import { Dialog, Button, Paragraph } from '@sikt/design-system';

function DeleteConfirmationDialog({ isOpen, onClose, onConfirm, itemName }) {
  return (
    <Dialog
      open={isOpen}
      onClose={onClose}
      title="Confirm Deletion"
      aria-describedby="dialog-description"
    >
      <Paragraph id="dialog-description">
        Are you sure you want to delete "{itemName}"? This action cannot be undone.
      </Paragraph>

      <div style={{ display: 'flex', gap: '12px', marginTop: '24px' }}>
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
import { Dialog, TextInput, Button } from '@sikt/design-system';

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
import { Table, Button } from '@sikt/design-system';
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
import { Table, Pagination } from '@sikt/design-system';
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
import { Header, Footer, Section, Container } from '@sikt/design-system';

function PageLayout({ children }) {
  return (
    <div style={{ minHeight: '100vh', display: 'flex', flexDirection: 'column' }}>
      <Header
        logo={<Logo />}
        navigation={[
          { label: 'Home', href: '/' },
          { label: 'About', href: '/about' },
          { label: 'Contact', href: '/contact' }
        ]}
        userMenu={[
          { label: 'Profile', href: '/profile' },
          { label: 'Settings', href: '/settings' },
          { label: 'Logout', href: '/logout' }
        ]}
      />

      <main style={{ flex: 1 }}>
        <Container>
          {children}
        </Container>
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
import { Card, Heading, Paragraph, Button } from '@sikt/design-system';

function CardGrid({ items }) {
  return (
    <div style={{
      display: 'grid',
      gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))',
      gap: 'var(--sds-space-gap-24)'
    }}>
      {items.map((item, index) => (
        <Card key={index}>
          {item.image && (
            <img
              src={item.image}
              alt={item.title}
              style={{ width: '100%', height: '200px', objectFit: 'cover' }}
            />
          )}
          <Heading level={3}>{item.title}</Heading>
          <Paragraph>{item.description}</Paragraph>
          <Button href={item.link}>Learn More</Button>
        </Card>
      ))}
    </div>
  );
}
```

### 6. Navigation Patterns

#### Tabs with Content

```jsx
import { Tabs, Section } from '@sikt/design-system';
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

      <Section>
        {activeTab === 'overview' && (
          <div>
            <Heading level={2}>Overview</Heading>
            <Paragraph>Overview content...</Paragraph>
          </div>
        )}

        {activeTab === 'details' && (
          <div>
            <Heading level={2}>Details</Heading>
            <Paragraph>Detailed information...</Paragraph>
          </div>
        )}

        {activeTab === 'settings' && (
          <div>
            <Heading level={2}>Settings</Heading>
            <Paragraph>Settings options...</Paragraph>
          </div>
        )}
      </Section>
    </div>
  );
}
```

#### Breadcrumb Navigation

```jsx
import { Breadcrumbs } from '@sikt/design-system';

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
import { TextInput, Select, FilterList, Button } from '@sikt/design-system';
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

      <FilterList items={filteredData} />
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
