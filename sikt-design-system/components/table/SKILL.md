---
name: sikt-design-table
description: Ready-to-use code examples for Sikt table components. Use when developers ask "How do I create a table?", "Show me sortable tables", "How to add pagination?", or need table implementations with sorting, pagination, and filtering.
---

# Sikt Table Components

## Overview

This skill provides implementation examples for Sikt Design System table components including basic tables, sortable tables, paginated tables, and advanced table features.

## Installation

```bash
npm install @sikt/sds-table @sikt/sds-pagination @sikt/sds-button @sikt/sds-core
```

Import components and stylesheets:

```js
import { Table } from '@sikt/sds-table';
import { Pagination } from '@sikt/sds-pagination';
import { Button } from '@sikt/sds-button';
import '@sikt/sds-core/dist/index.css';
import '@sikt/sds-table/dist/index.css';
import '@sikt/sds-pagination/dist/index.css';
import '@sikt/sds-button/dist/index.css';
```

## Basic Table

```jsx
import { Table } from '@sikt/sds-table';

function BasicTable({ data }) {
  return (
    <Table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Email</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
        {data.map((row, index) => (
          <tr key={index}>
            <td>{row.name}</td>
            <td>{row.email}</td>
            <td>{row.status}</td>
          </tr>
        ))}
      </tbody>
    </Table>
  );
}
```

## Sortable Table

```jsx
import { Table } from '@sikt/sds-table';
import { Button } from '@sikt/sds-button';
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

## Paginated Table

```jsx
import { Table } from '@sikt/sds-table';
import { Pagination } from '@sikt/sds-pagination';
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

## Table with Actions

```jsx
import { Table } from '@sikt/sds-table';
import { Button } from '@sikt/sds-button';

function TableWithActions({ data, onEdit, onDelete }) {
  return (
    <Table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Email</th>
          <th>Status</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        {data.map((row, index) => (
          <tr key={index}>
            <td>{row.name}</td>
            <td>{row.email}</td>
            <td>{row.status}</td>
            <td>
              <div style={{ display: 'flex', gap: '8px' }}>
                <Button variant="text" onClick={() => onEdit(row)}>
                  Edit
                </Button>
                <Button variant="text" onClick={() => onDelete(row)}>
                  Delete
                </Button>
              </div>
            </td>
          </tr>
        ))}
      </tbody>
    </Table>
  );
}
```

## Table with Selection

```jsx
import { Table } from '@sikt/sds-table';
import { Checkbox } from '@sikt/sds-checkbox';
import { useState } from 'react';

function SelectableTable({ data }) {
  const [selectedRows, setSelectedRows] = useState([]);

  const toggleRow = (rowId) => {
    setSelectedRows(prev =>
      prev.includes(rowId)
        ? prev.filter(id => id !== rowId)
        : [...prev, rowId]
    );
  };

  const toggleAll = () => {
    if (selectedRows.length === data.length) {
      setSelectedRows([]);
    } else {
      setSelectedRows(data.map(row => row.id));
    }
  };

  return (
    <Table>
      <thead>
        <tr>
          <th>
            <Checkbox
              checked={selectedRows.length === data.length}
              onChange={toggleAll}
              aria-label="Select all rows"
            />
          </th>
          <th>Name</th>
          <th>Email</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
        {data.map((row, index) => (
          <tr key={index}>
            <td>
              <Checkbox
                checked={selectedRows.includes(row.id)}
                onChange={() => toggleRow(row.id)}
                aria-label={`Select ${row.name}`}
              />
            </td>
            <td>{row.name}</td>
            <td>{row.email}</td>
            <td>{row.status}</td>
          </tr>
        ))}
      </tbody>
    </Table>
  );
}
```

## Responsive Table

```jsx
import { Table } from '@sikt/sds-table';

function ResponsiveTable({ data }) {
  return (
    <div style={{ overflowX: 'auto' }}>
      <Table>
        <thead>
          <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Department</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          {data.map((row, index) => (
            <tr key={index}>
              <td data-label="Name">{row.name}</td>
              <td data-label="Email">{row.email}</td>
              <td data-label="Phone">{row.phone}</td>
              <td data-label="Department">{row.department}</td>
              <td data-label="Status">{row.status}</td>
            </tr>
          ))}
        </tbody>
      </Table>
    </div>
  );
}
```

## Table with Sorting and Pagination

```jsx
import { Table } from '@sikt/sds-table';
import { Pagination } from '@sikt/sds-pagination';
import { Button } from '@sikt/sds-button';
import { useState } from 'react';

function AdvancedTable({ data, itemsPerPage = 10 }) {
  const [currentPage, setCurrentPage] = useState(1);
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

  const totalPages = Math.ceil(sortedData.length / itemsPerPage);
  const startIndex = (currentPage - 1) * itemsPerPage;
  const endIndex = startIndex + itemsPerPage;
  const currentData = sortedData.slice(startIndex, endIndex);

  const requestSort = (key) => {
    let direction = 'asc';
    if (sortConfig.key === key && sortConfig.direction === 'asc') {
      direction = 'desc';
    }
    setSortConfig({ key, direction });
  };

  return (
    <div>
      <Table>
        <thead>
          <tr>
            <th>
              <Button variant="text" onClick={() => requestSort('name')}>
                Name {sortConfig.key === 'name' && (sortConfig.direction === 'asc' ? '↑' : '↓')}
              </Button>
            </th>
            <th>
              <Button variant="text" onClick={() => requestSort('email')}>
                Email {sortConfig.key === 'email' && (sortConfig.direction === 'asc' ? '↑' : '↓')}
              </Button>
            </th>
            <th>
              <Button variant="text" onClick={() => requestSort('status')}>
                Status {sortConfig.key === 'status' && (sortConfig.direction === 'asc' ? '↑' : '↓')}
              </Button>
            </th>
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

## Empty State

```jsx
function EmptyTable() {
  return (
    <Table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Email</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td colSpan={3} style={{ textAlign: 'center', padding: '48px' }}>
            <p>No data available</p>
          </td>
        </tr>
      </tbody>
    </Table>
  );
}
```

## Best Practices

### Table Structure
- Use semantic HTML (`<table>`, `<thead>`, `<tbody>`, `<th>`, `<td>`)
- Provide clear column headers
- Keep tables simple and scannable
- Use consistent column widths

### Data Display
- Left-align text, right-align numbers
- Use consistent formatting
- Highlight important information
- Consider zebra striping for readability

### Performance
- Virtualize large datasets
- Implement pagination for long lists
- Debounce sorting and filtering
- Load data progressively

## Accessibility Best Practices

- Use proper table markup
- Include `scope` attribute on header cells
- Provide captions when needed
- Ensure keyboard navigation works
- Make sortable columns accessible
- Announce sort direction to screen readers
- Use ARIA labels for icon buttons

## Resources

- [Table Component Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-table-readme--docs)
- [npm Package: @sikt/sds-table](https://www.npmjs.com/package/@sikt/sds-table)
- [npm Package: @sikt/sds-pagination](https://www.npmjs.com/package/@sikt/sds-pagination)

## Related Skills

- **sikt-design-button**: Button components for table actions
- **sikt-design-search-filter**: Search and filter for tables
- **sikt-design-general**: General design system guidelines
