---
name: sikt-design-navigation
description: Ready-to-use code examples for Sikt navigation components. Use when developers ask "How do I create tabs?", "Show me breadcrumbs", "How to build navigation?", or need navigation implementations with tabs, breadcrumbs, and menu patterns.
---

# Sikt Navigation Components

## Overview

This skill provides implementation examples for Sikt Design System navigation components including tabs, breadcrumbs, navigation menus, and navigation patterns.

## Installation

```bash
npm install @sikt/sds-tabs @sikt/sds-breadcrumbs @sikt/sds-core
```

Import components:

```js
import { Tabs } from '@sikt/sds-tabs';
import { Breadcrumbs } from '@sikt/sds-breadcrumbs';
```

## Tabs Component

### Basic Tabs

```jsx
import { Tabs } from '@sikt/sds-tabs';
import { useState } from 'react';

function BasicTabs() {
  const [activeTab, setActiveTab] = useState('tab1');

  const tabs = [
    { id: 'tab1', label: 'Tab 1' },
    { id: 'tab2', label: 'Tab 2' },
    { id: 'tab3', label: 'Tab 3' }
  ];

  return (
    <div>
      <Tabs
        tabs={tabs}
        activeTab={activeTab}
        onChange={setActiveTab}
      />

      <div style={{ padding: '24px 0' }}>
        {activeTab === 'tab1' && <div>Content for Tab 1</div>}
        {activeTab === 'tab2' && <div>Content for Tab 2</div>}
        {activeTab === 'tab3' && <div>Content for Tab 3</div>}
      </div>
    </div>
  );
}
```

### Tabs with Content

```jsx
import { Tabs } from '@sikt/sds-tabs';
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

### Tabs with Icons

```jsx
import { Tabs } from '@sikt/sds-tabs';
import { useState } from 'react';

function TabsWithIcons() {
  const [activeTab, setActiveTab] = useState('dashboard');

  const tabs = [
    { id: 'dashboard', label: 'Dashboard', icon: 'dashboard' },
    { id: 'profile', label: 'Profile', icon: 'person' },
    { id: 'settings', label: 'Settings', icon: 'settings' }
  ];

  return (
    <Tabs
      tabs={tabs}
      activeTab={activeTab}
      onChange={setActiveTab}
    />
  );
}
```

## Breadcrumbs Component

### Basic Breadcrumbs

```jsx
import { Breadcrumbs } from '@sikt/sds-breadcrumbs';

function BasicBreadcrumbs() {
  const items = [
    { label: 'Home', href: '/' },
    { label: 'Products', href: '/products' },
    { label: 'Category', href: '/products/category' },
    { label: 'Product Name', href: '#', current: true }
  ];

  return <Breadcrumbs items={items} />;
}
```

### Dynamic Breadcrumbs

```jsx
import { Breadcrumbs } from '@sikt/sds-breadcrumbs';

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

## Navigation Menu

### Horizontal Navigation

```jsx
function HorizontalNav() {
  return (
    <nav>
      <ul style={{ display: 'flex', gap: '24px', listStyle: 'none', padding: 0 }}>
        <li><a href="/">Home</a></li>
        <li><a href="/about">About</a></li>
        <li><a href="/services">Services</a></li>
        <li><a href="/contact">Contact</a></li>
      </ul>
    </nav>
  );
}
```

### Vertical Navigation

```jsx
function VerticalNav() {
  return (
    <nav>
      <ul style={{ listStyle: 'none', padding: 0 }}>
        <li style={{ marginBottom: '8px' }}>
          <a href="/dashboard" style={{ display: 'block', padding: '8px 16px' }}>
            Dashboard
          </a>
        </li>
        <li style={{ marginBottom: '8px' }}>
          <a href="/projects" style={{ display: 'block', padding: '8px 16px' }}>
            Projects
          </a>
        </li>
        <li style={{ marginBottom: '8px' }}>
          <a href="/team" style={{ display: 'block', padding: '8px 16px' }}>
            Team
          </a>
        </li>
        <li style={{ marginBottom: '8px' }}>
          <a href="/settings" style={{ display: 'block', padding: '8px 16px' }}>
            Settings
          </a>
        </li>
      </ul>
    </nav>
  );
}
```

### Sidebar Navigation

```jsx
import { useState } from 'react';

function SidebarNav() {
  const [activeItem, setActiveItem] = useState('dashboard');

  const navItems = [
    { id: 'dashboard', label: 'Dashboard', icon: 'dashboard' },
    { id: 'projects', label: 'Projects', icon: 'folder' },
    { id: 'team', label: 'Team', icon: 'people' },
    { id: 'settings', label: 'Settings', icon: 'settings' }
  ];

  return (
    <nav style={{ width: '250px', padding: '16px', backgroundColor: '#f8f9fa' }}>
      <ul style={{ listStyle: 'none', padding: 0 }}>
        {navItems.map(item => (
          <li key={item.id} style={{ marginBottom: '8px' }}>
            <a
              href={`/${item.id}`}
              onClick={(e) => {
                e.preventDefault();
                setActiveItem(item.id);
              }}
              style={{
                display: 'block',
                padding: '12px 16px',
                borderRadius: '4px',
                backgroundColor: activeItem === item.id ? '#007bff' : 'transparent',
                color: activeItem === item.id ? 'white' : 'inherit',
                textDecoration: 'none'
              }}
            >
              {item.label}
            </a>
          </li>
        ))}
      </ul>
    </nav>
  );
}
```

## Dropdown Navigation

```jsx
import { useState } from 'react';

function DropdownNav() {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <div style={{ position: 'relative' }}>
      <button
        onClick={() => setIsOpen(!isOpen)}
        style={{ padding: '8px 16px', cursor: 'pointer' }}
      >
        Menu
      </button>

      {isOpen && (
        <div style={{
          position: 'absolute',
          top: '100%',
          left: 0,
          backgroundColor: 'white',
          border: '1px solid #dee2e6',
          borderRadius: '4px',
          boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
          marginTop: '4px',
          minWidth: '200px',
          zIndex: 1000
        }}>
          <ul style={{ listStyle: 'none', padding: 0, margin: 0 }}>
            <li>
              <a href="/profile" style={{ display: 'block', padding: '12px 16px' }}>
                Profile
              </a>
            </li>
            <li>
              <a href="/settings" style={{ display: 'block', padding: '12px 16px' }}>
                Settings
              </a>
            </li>
            <li>
              <a href="/logout" style={{ display: 'block', padding: '12px 16px' }}>
                Logout
              </a>
            </li>
          </ul>
        </div>
      )}
    </div>
  );
}
```

## Mobile Navigation

```jsx
import { useState } from 'react';

function MobileNav() {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <div>
      <button
        onClick={() => setIsOpen(!isOpen)}
        style={{ padding: '8px', cursor: 'pointer' }}
        aria-label="Toggle menu"
      >
        ☰
      </button>

      {isOpen && (
        <nav style={{
          position: 'fixed',
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          backgroundColor: 'white',
          zIndex: 1000,
          padding: '24px'
        }}>
          <button
            onClick={() => setIsOpen(false)}
            style={{ float: 'right', fontSize: '24px', cursor: 'pointer' }}
          >
            ×
          </button>

          <ul style={{ listStyle: 'none', padding: 0, marginTop: '48px' }}>
            <li style={{ marginBottom: '16px' }}>
              <a href="/" style={{ fontSize: '20px' }}>Home</a>
            </li>
            <li style={{ marginBottom: '16px' }}>
              <a href="/about" style={{ fontSize: '20px' }}>About</a>
            </li>
            <li style={{ marginBottom: '16px' }}>
              <a href="/services" style={{ fontSize: '20px' }}>Services</a>
            </li>
            <li style={{ marginBottom: '16px' }}>
              <a href="/contact" style={{ fontSize: '20px' }}>Contact</a>
            </li>
          </ul>
        </nav>
      )}
    </div>
  );
}
```

## Pagination Navigation

```jsx
import { Pagination } from '@sikt/sds-pagination';
import { useState } from 'react';

function PaginationNav({ totalPages }) {
  const [currentPage, setCurrentPage] = useState(1);

  return (
    <Pagination
      currentPage={currentPage}
      totalPages={totalPages}
      onPageChange={setCurrentPage}
    />
  );
}
```

## Best Practices

### Navigation Structure
- Use semantic HTML (`<nav>`, `<ul>`, `<li>`)
- Keep navigation clear and consistent
- Highlight active/current page
- Provide clear visual feedback on hover

### Tabs
- Limit number of tabs (5-7 maximum)
- Use clear, concise labels
- Show active tab clearly
- Consider mobile responsiveness

### Breadcrumbs
- Show full navigation path
- Keep labels short and clear
- Make all levels clickable except current
- Use on deep hierarchies only

## Accessibility Best Practices

- Use proper ARIA attributes (`aria-current`, `aria-label`)
- Ensure keyboard navigation works
- Provide clear focus indicators
- Use semantic HTML for navigation
- Make mobile menus keyboard accessible
- Announce tab changes to screen readers

## Responsive Navigation

- Mobile-first approach
- Hamburger menu for mobile
- Touch-friendly tap targets
- Consider screen size breakpoints
- Test across devices

## Resources

- [Tabs Component Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-tabs-readme--docs)
- [Breadcrumbs Component Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-breadcrumbs-readme--docs)
- [npm Package: @sikt/sds-tabs](https://www.npmjs.com/package/@sikt/sds-tabs)
- [npm Package: @sikt/sds-breadcrumbs](https://www.npmjs.com/package/@sikt/sds-breadcrumbs)

## Related Skills

- **sikt-design-button**: Button components for navigation
- **sikt-design-layout**: Layout components with navigation
- **sikt-design-general**: General design system guidelines
