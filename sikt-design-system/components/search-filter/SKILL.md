---
name: sikt-design-search-filter
description: Ready-to-use code examples for Sikt search and filter components. Use when developers ask "How do I add search?", "Show me filter examples", "How to implement search and filter?", or need search and filtering implementations for data lists and tables.
---

# Sikt Search and Filter Components

## Overview

This skill provides implementation examples for Sikt Design System search and filter patterns including search inputs, filter dropdowns, and combined search and filter functionality.

## Installation

```bash
npm install @sikt/sds-input @sikt/sds-select @sikt/sds-button @sikt/sds-core
```

Import the core CSS file (REQUIRED) and components:

```js
// REQUIRED: Import core styles for design tokens, base styles, and component styling
import '@sikt/sds-core/dist/index.css';

// Import components
import { TextInput } from '@sikt/sds-input';
import { Select } from '@sikt/sds-select';
import { Button } from '@sikt/sds-button';
```

**CRITICAL**:
- You MUST import `@sikt/sds-core/dist/index.css` for components to display correctly with borders, outlines, and proper styling
- Do NOT import component-specific CSS files (e.g., `@sikt/sds-button/dist/index.css`) - these are not needed
- Components will not have proper styling without the core CSS import

## Basic Search

```jsx
import { TextInput } from '@sikt/sds-input';
import { useState } from 'react';

function BasicSearch({ data }) {
  const [searchTerm, setSearchTerm] = useState('');

  const filteredData = data.filter(item =>
    item.name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div>
      <TextInput
        label="Search"
        placeholder="Search items..."
        value={searchTerm}
        onChange={(e) => setSearchTerm(e.target.value)}
      />

      <ul style={{ marginTop: '16px' }}>
        {filteredData.map((item, idx) => (
          <li key={idx}>{item.name}</li>
        ))}
      </ul>
    </div>
  );
}
```

## Search with Debounce

```jsx
import { TextInput } from '@sikt/sds-input';
import { useState, useEffect } from 'react';

function DebouncedSearch({ onSearch }) {
  const [searchTerm, setSearchTerm] = useState('');

  useEffect(() => {
    const timer = setTimeout(() => {
      onSearch(searchTerm);
    }, 300);

    return () => clearTimeout(timer);
  }, [searchTerm, onSearch]);

  return (
    <TextInput
      label="Search"
      placeholder="Search..."
      value={searchTerm}
      onChange={(e) => setSearchTerm(e.target.value)}
    />
  );
}
```

## Filter Dropdown

```jsx
import { Select } from '@sikt/sds-select';
import { useState } from 'react';

function FilterDropdown({ data }) {
  const [filter, setFilter] = useState('all');

  const filteredData = data.filter(item => {
    if (filter === 'all') return true;
    return item.category === filter;
  });

  return (
    <div>
      <Select
        label="Filter by Category"
        value={filter}
        onChange={(e) => setFilter(e.target.value)}
        options={[
          { value: 'all', label: 'All Categories' },
          { value: 'category1', label: 'Category 1' },
          { value: 'category2', label: 'Category 2' }
        ]}
      />

      <ul style={{ marginTop: '16px' }}>
        {filteredData.map((item, idx) => (
          <li key={idx}>{item.name} - {item.category}</li>
        ))}
      </ul>
    </div>
  );
}
```

## Search and Filter Combined

```jsx
import { TextInput } from '@sikt/sds-input';
import { Select } from '@sikt/sds-select';
import { Button } from '@sikt/sds-button';
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

## Multi-Select Filter

```jsx
import { Checkbox } from '@sikt/sds-checkbox';
import { Button } from '@sikt/sds-button';
import { useState } from 'react';

function MultiSelectFilter({ data }) {
  const [selectedCategories, setSelectedCategories] = useState([]);

  const toggleCategory = (category) => {
    setSelectedCategories(prev =>
      prev.includes(category)
        ? prev.filter(c => c !== category)
        : [...prev, category]
    );
  };

  const filteredData = data.filter(item =>
    selectedCategories.length === 0 || selectedCategories.includes(item.category)
  );

  return (
    <div>
      <div style={{ marginBottom: '24px' }}>
        <h3>Filter by Category</h3>
        <Checkbox
          label="Category 1"
          checked={selectedCategories.includes('category1')}
          onChange={() => toggleCategory('category1')}
        />
        <Checkbox
          label="Category 2"
          checked={selectedCategories.includes('category2')}
          onChange={() => toggleCategory('category2')}
        />
        <Checkbox
          label="Category 3"
          checked={selectedCategories.includes('category3')}
          onChange={() => toggleCategory('category3')}
        />

        <Button variant="secondary" onClick={() => setSelectedCategories([])}>
          Clear All
        </Button>
      </div>

      <ul>
        {filteredData.map((item, idx) => (
          <li key={idx}>{item.name}</li>
        ))}
      </ul>
    </div>
  );
}
```

## Date Range Filter

```jsx
import { TextInput } from '@sikt/sds-input';
import { Button } from '@sikt/sds-button';
import { useState } from 'react';

function DateRangeFilter({ data }) {
  const [startDate, setStartDate] = useState('');
  const [endDate, setEndDate] = useState('');

  const filteredData = data.filter(item => {
    if (!startDate && !endDate) return true;

    const itemDate = new Date(item.date);
    const start = startDate ? new Date(startDate) : null;
    const end = endDate ? new Date(endDate) : null;

    if (start && itemDate < start) return false;
    if (end && itemDate > end) return false;

    return true;
  });

  const clearDates = () => {
    setStartDate('');
    setEndDate('');
  };

  return (
    <div>
      <div style={{ display: 'flex', gap: '12px', marginBottom: '24px' }}>
        <TextInput
          label="Start Date"
          type="date"
          value={startDate}
          onChange={(e) => setStartDate(e.target.value)}
        />

        <TextInput
          label="End Date"
          type="date"
          value={endDate}
          onChange={(e) => setEndDate(e.target.value)}
        />

        <Button variant="secondary" onClick={clearDates}>
          Clear
        </Button>
      </div>

      <ul>
        {filteredData.map((item, idx) => (
          <li key={idx}>{item.name} - {item.date}</li>
        ))}
      </ul>
    </div>
  );
}
```

## Advanced Filter Panel

```jsx
import { TextInput } from '@sikt/sds-input';
import { Select } from '@sikt/sds-select';
import { Checkbox } from '@sikt/sds-checkbox';
import { Button } from '@sikt/sds-button';
import { useState } from 'react';

function AdvancedFilterPanel({ data, onFilter }) {
  const [filters, setFilters] = useState({
    search: '',
    category: 'all',
    status: 'all',
    tags: []
  });

  const applyFilters = () => {
    const filtered = data.filter(item => {
      const matchesSearch = item.name.toLowerCase().includes(filters.search.toLowerCase());
      const matchesCategory = filters.category === 'all' || item.category === filters.category;
      const matchesStatus = filters.status === 'all' || item.status === filters.status;
      const matchesTags = filters.tags.length === 0 || filters.tags.some(tag => item.tags.includes(tag));

      return matchesSearch && matchesCategory && matchesStatus && matchesTags;
    });

    onFilter(filtered);
  };

  const resetFilters = () => {
    setFilters({
      search: '',
      category: 'all',
      status: 'all',
      tags: []
    });
  };

  return (
    <aside style={{ padding: '16px', backgroundColor: '#f8f9fa', borderRadius: '4px' }}>
      <h3>Filters</h3>

      <div style={{ marginBottom: '16px' }}>
        <TextInput
          label="Search"
          value={filters.search}
          onChange={(e) => setFilters({ ...filters, search: e.target.value })}
        />
      </div>

      <div style={{ marginBottom: '16px' }}>
        <Select
          label="Category"
          value={filters.category}
          onChange={(e) => setFilters({ ...filters, category: e.target.value })}
          options={[
            { value: 'all', label: 'All' },
            { value: 'cat1', label: 'Category 1' },
            { value: 'cat2', label: 'Category 2' }
          ]}
        />
      </div>

      <div style={{ marginBottom: '16px' }}>
        <Select
          label="Status"
          value={filters.status}
          onChange={(e) => setFilters({ ...filters, status: e.target.value })}
          options={[
            { value: 'all', label: 'All' },
            { value: 'active', label: 'Active' },
            { value: 'inactive', label: 'Inactive' }
          ]}
        />
      </div>

      <div style={{ marginBottom: '16px' }}>
        <h4>Tags</h4>
        <Checkbox label="Tag 1" />
        <Checkbox label="Tag 2" />
        <Checkbox label="Tag 3" />
      </div>

      <div style={{ display: 'flex', gap: '8px' }}>
        <Button onClick={applyFilters}>Apply</Button>
        <Button variant="secondary" onClick={resetFilters}>Reset</Button>
      </div>
    </aside>
  );
}
```

## Active Filters Display

```jsx
import { Button } from '@sikt/sds-button';

function ActiveFilters({ filters, onRemove }) {
  const activeFilters = Object.entries(filters).filter(([key, value]) =>
    value && value !== 'all' && value !== ''
  );

  if (activeFilters.length === 0) return null;

  return (
    <div style={{ display: 'flex', gap: '8px', flexWrap: 'wrap', marginBottom: '16px' }}>
      <span>Active filters:</span>
      {activeFilters.map(([key, value]) => (
        <div key={key} style={{
          padding: '4px 8px',
          backgroundColor: '#e9ecef',
          borderRadius: '4px',
          display: 'flex',
          alignItems: 'center',
          gap: '8px'
        }}>
          <span>{key}: {value}</span>
          <button
            onClick={() => onRemove(key)}
            style={{ background: 'none', border: 'none', cursor: 'pointer' }}
          >
            ×
          </button>
        </div>
      ))}
    </div>
  );
}
```

## Best Practices

### Search Implementation
- Debounce search input to avoid excessive filtering
- Provide clear placeholder text
- Show search results count
- Handle empty search results gracefully

### Filter Implementation
- Group related filters together
- Show filter count when applied
- Provide clear all filters option
- Maintain filter state in URL when appropriate

### User Experience
- Show loading states during filtering
- Provide visual feedback for active filters
- Keep filters visible and accessible
- Consider mobile-friendly filter layouts

## Performance Optimization

- Debounce search inputs (300ms recommended)
- Memoize filter functions for large datasets
- Virtualize long filtered lists
- Consider server-side filtering for very large datasets

## Accessibility Best Practices

- Provide clear labels for all filter inputs
- Ensure keyboard navigation works
- Announce filter results to screen readers
- Use proper ARIA attributes
- Make clear filters button keyboard accessible

## Resources

- [Input Component Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-input-readme--docs)
- [Select Component Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-select-readme--docs)
- [npm Package: @sikt/sds-input](https://www.npmjs.com/package/@sikt/sds-input)
- [npm Package: @sikt/sds-select](https://www.npmjs.com/package/@sikt/sds-select)

## Related Skills

- **sikt-design-form**: Form components for filters
- **sikt-design-table**: Tables with search and filter
- **sikt-design-button**: Button components for filters
- **sikt-design-general**: General design system guidelines
