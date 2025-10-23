---
name: sikt-design-list
description: Ready-to-use code examples for Sikt list components. Use when developers ask "How do I create lists?", "Show me list examples", "How to implement FilterList?", or need list implementations for data display, navigation, and filtered content.
---

# Sikt List Components

## Overview

This skill provides implementation examples for Sikt Design System list components including basic lists, filter lists, and structured data lists.

## Installation

```bash
npm install @sikt/sds-list @sikt/sds-filter-list @sikt/sds-core
```

Import the core CSS file (REQUIRED) and components:

```js
// REQUIRED: Import core styles for design tokens, base styles, and component styling
import '@sikt/sds-core/dist/index.css';

// Import components
import { List, FilterList } from '@sikt/sds-list';
```

**CRITICAL**:
- You MUST import `@sikt/sds-core/dist/index.css` for components to display correctly with borders, outlines, and proper styling
- Do NOT import component-specific CSS files (e.g., `@sikt/sds-button/dist/index.css`) - these are not needed
- Components will not have proper styling without the core CSS import

## Basic List

### Unordered List

```jsx
import { List } from '@sikt/sds-list';

function UnorderedList() {
  const items = ['Item 1', 'Item 2', 'Item 3'];

  return (
    <List>
      {items.map((item, idx) => (
        <li key={idx}>{item}</li>
      ))}
    </List>
  );
}
```

### Ordered List

```jsx
import { List } from '@sikt/sds-list';

function OrderedList() {
  const steps = ['First step', 'Second step', 'Third step'];

  return (
    <List ordered>
      {steps.map((step, idx) => (
        <li key={idx}>{step}</li>
      ))}
    </List>
  );
}
```

### Description List

```jsx
function DescriptionList() {
  return (
    <dl>
      <dt>Name</dt>
      <dd>John Doe</dd>

      <dt>Email</dt>
      <dd>john@example.com</dd>

      <dt>Role</dt>
      <dd>Developer</dd>
    </dl>
  );
}
```

## FilterList Component

### Basic FilterList

```jsx
import { FilterList } from '@sikt/sds-filter-list';
import { useState } from 'react';

function BasicFilterList() {
  const [searchTerm, setSearchTerm] = useState('');

  const items = [
    { id: 1, name: 'Norway', category: 'Country' },
    { id: 2, name: 'Sweden', category: 'Country' },
    { id: 3, name: 'Oslo', category: 'City' },
    { id: 4, name: 'Stockholm', category: 'City' }
  ];

  const filteredItems = items.filter(item =>
    item.name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <FilterList
      searchValue={searchTerm}
      onSearchChange={setSearchTerm}
      placeholder="Search..."
    >
      {filteredItems.map(item => (
        <li key={item.id}>{item.name}</li>
      ))}
    </FilterList>
  );
}
```

### Interactive List

```jsx
import { List } from '@sikt/sds-list';

function InteractiveList() {
  const [selectedId, setSelectedId] = useState(null);

  const items = [
    { id: 1, title: 'Item 1', description: 'Description 1' },
    { id: 2, title: 'Item 2', description: 'Description 2' },
    { id: 3, title: 'Item 3', description: 'Description 3' }
  ];

  return (
    <List>
      {items.map(item => (
        <li
          key={item.id}
          onClick={() => setSelectedId(item.id)}
          style={{
            padding: '12px',
            cursor: 'pointer',
            backgroundColor: selectedId === item.id ? '#e9ecef' : 'transparent'
          }}
        >
          <strong>{item.title}</strong>
          <p style={{ margin: '4px 0 0' }}>{item.description}</p>
        </li>
      ))}
    </List>
  );
}
```

### Grouped List

```jsx
import { List } from '@sikt/sds-list';

function GroupedList() {
  const groups = {
    'Fruits': ['Apple', 'Banana', 'Orange'],
    'Vegetables': ['Carrot', 'Broccoli', 'Spinach']
  };

  return (
    <div>
      {Object.entries(groups).map(([category, items]) => (
        <div key={category} style={{ marginBottom: '24px' }}>
          <h3>{category}</h3>
          <List>
            {items.map((item, idx) => (
              <li key={idx}>{item}</li>
            ))}
          </List>
        </div>
      ))}
    </div>
  );
}
```

## Best Practices

- Use semantic HTML list elements
- Keep list items concise
- Provide clear labels for grouped lists
- Use appropriate list type (ordered vs unordered)
- Make interactive lists keyboard accessible

## Accessibility

- Use proper list markup (`<ul>`, `<ol>`, `<li>`)
- Provide ARIA labels for complex lists
- Ensure keyboard navigation
- Support screen readers

## Resources

- [List Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-list--docs)
- [FilterList Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-filter-list--docs)

## Related Skills

- **sikt-design-search-filter**: Search and filter patterns
- **sikt-design-table**: Table data display
- **sikt-design-general**: General guidelines
