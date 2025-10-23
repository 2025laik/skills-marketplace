---
name: sikt-design-drawer
description: Ready-to-use code examples for Sikt drawer components. Use when developers ask "How do I create a drawer?", "Show me side panel examples", "How to implement slide-out navigation?", or need drawer/side panel implementations for navigation, filters, or content.
---

# Sikt Drawer Components

## Overview

This skill provides implementation examples for Sikt Design System drawer components including side panels, slide-out navigation, and overlay drawers.

## Installation

```bash
npm install @sikt/sds-drawer @sikt/sds-button @sikt/sds-core
```

Import the core CSS file (REQUIRED) and components:

```js
// REQUIRED: Import core styles for design tokens, base styles, and component styling
import '@sikt/sds-core/dist/index.css';

// Import components
import { Drawer } from '@sikt/sds-drawer';
import { Button } from '@sikt/sds-button';
```

**CRITICAL**:
- You MUST import `@sikt/sds-core/dist/index.css` for components to display correctly with borders, outlines, and proper styling
- Do NOT import component-specific CSS files (e.g., `@sikt/sds-button/dist/index.css`) - these are not needed
- Components will not have proper styling without the core CSS import

## Basic Drawer

```jsx
import { Drawer } from '@sikt/sds-drawer';
import { Button } from '@sikt/sds-button';
import { useState } from 'react';

function BasicDrawer() {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <div>
      <Button onClick={() => setIsOpen(true)}>
        Open Drawer
      </Button>

      <Drawer
        open={isOpen}
        onClose={() => setIsOpen(false)}
        title="Drawer Title"
      >
        <p>Drawer content goes here.</p>
      </Drawer>
    </div>
  );
}
```

## Drawer Positions

### Left Drawer

```jsx
import { Drawer } from '@sikt/sds-drawer';
import { Button } from '@sikt/sds-button';
import { useState } from 'react';

function LeftDrawer() {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <div>
      <Button onClick={() => setIsOpen(true)}>
        Open Left Drawer
      </Button>

      <Drawer
        open={isOpen}
        onClose={() => setIsOpen(false)}
        position="left"
        title="Navigation"
      >
        <nav>
          <ul>
            <li><a href="/">Home</a></li>
            <li><a href="/about">About</a></li>
            <li><a href="/contact">Contact</a></li>
          </ul>
        </nav>
      </Drawer>
    </div>
  );
}
```

### Right Drawer

```jsx
import { Drawer } from '@sikt/sds-drawer';
import { Button } from '@sikt/sds-button';
import { useState } from 'react';

function RightDrawer() {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <div>
      <Button onClick={() => setIsOpen(true)}>
        Open Right Drawer
      </Button>

      <Drawer
        open={isOpen}
        onClose={() => setIsOpen(false)}
        position="right"
        title="Settings"
      >
        <div>
          <h3>Preferences</h3>
          <p>Configure your settings here.</p>
        </div>
      </Drawer>
    </div>
  );
}
```

## Navigation Drawer

```jsx
import { Drawer } from '@sikt/sds-drawer';
import { Button } from '@sikt/sds-button';
import { useState } from 'react';

function NavigationDrawer() {
  const [isOpen, setIsOpen] = useState(false);
  const [activeItem, setActiveItem] = useState('dashboard');

  const navItems = [
    { id: 'dashboard', label: 'Dashboard', icon: '📊' },
    { id: 'projects', label: 'Projects', icon: '📁' },
    { id: 'team', label: 'Team', icon: '👥' },
    { id: 'settings', label: 'Settings', icon: '⚙️' }
  ];

  return (
    <div>
      <Button onClick={() => setIsOpen(true)}>
        ☰ Menu
      </Button>

      <Drawer
        open={isOpen}
        onClose={() => setIsOpen(false)}
        position="left"
        title="Navigation"
      >
        <nav style={{ padding: '16px' }}>
          <ul style={{ listStyle: 'none', padding: 0 }}>
            {navItems.map(item => (
              <li key={item.id} style={{ marginBottom: '8px' }}>
                <a
                  href={`/${item.id}`}
                  onClick={(e) => {
                    e.preventDefault();
                    setActiveItem(item.id);
                    setIsOpen(false);
                  }}
                  style={{
                    display: 'flex',
                    alignItems: 'center',
                    padding: '12px',
                    borderRadius: '4px',
                    backgroundColor: activeItem === item.id ? '#007bff' : 'transparent',
                    color: activeItem === item.id ? 'white' : 'inherit',
                    textDecoration: 'none'
                  }}
                >
                  <span style={{ marginRight: '8px' }}>{item.icon}</span>
                  {item.label}
                </a>
              </li>
            ))}
          </ul>
        </nav>
      </Drawer>
    </div>
  );
}
```

## Filter Drawer

```jsx
import { Drawer } from '@sikt/sds-drawer';
import { Button } from '@sikt/sds-button';
import { Checkbox } from '@sikt/sds-checkbox';
import { Select } from '@sikt/sds-select';
import { useState } from 'react';

function FilterDrawer() {
  const [isOpen, setIsOpen] = useState(false);
  const [filters, setFilters] = useState({
    category: 'all',
    inStock: false,
    onSale: false
  });

  const applyFilters = () => {
    console.log('Applying filters:', filters);
    setIsOpen(false);
  };

  return (
    <div>
      <Button onClick={() => setIsOpen(true)}>
        Filter Results
      </Button>

      <Drawer
        open={isOpen}
        onClose={() => setIsOpen(false)}
        position="right"
        title="Filters"
      >
        <div style={{ padding: '16px' }}>
          <Select
            label="Category"
            value={filters.category}
            onChange={(e) => setFilters({ ...filters, category: e.target.value })}
            options={[
              { value: 'all', label: 'All Categories' },
              { value: 'electronics', label: 'Electronics' },
              { value: 'clothing', label: 'Clothing' }
            ]}
          />

          <Checkbox
            label="In Stock Only"
            checked={filters.inStock}
            onChange={(e) => setFilters({ ...filters, inStock: e.target.checked })}
          />

          <Checkbox
            label="On Sale"
            checked={filters.onSale}
            onChange={(e) => setFilters({ ...filters, onSale: e.target.checked })}
          />

          <div style={{ marginTop: '24px', display: 'flex', gap: '12px' }}>
            <Button onClick={applyFilters}>Apply Filters</Button>
            <Button variant="secondary" onClick={() => setIsOpen(false)}>Cancel</Button>
          </div>
        </div>
      </Drawer>
    </div>
  );
}
```

## Cart Drawer

```jsx
import { Drawer } from '@sikt/sds-drawer';
import { Button } from '@sikt/sds-button';
import { useState } from 'react';

function CartDrawer() {
  const [isOpen, setIsOpen] = useState(false);
  const [cartItems, setCartItems] = useState([
    { id: 1, name: 'Product 1', price: 99, quantity: 1 },
    { id: 2, name: 'Product 2', price: 149, quantity: 2 }
  ]);

  const total = cartItems.reduce((sum, item) => sum + (item.price * item.quantity), 0);

  return (
    <div>
      <Button onClick={() => setIsOpen(true)}>
        🛒 Cart ({cartItems.length})
      </Button>

      <Drawer
        open={isOpen}
        onClose={() => setIsOpen(false)}
        position="right"
        title="Shopping Cart"
      >
        <div style={{ padding: '16px' }}>
          {cartItems.length === 0 ? (
            <p>Your cart is empty</p>
          ) : (
            <>
              <ul style={{ listStyle: 'none', padding: 0 }}>
                {cartItems.map(item => (
                  <li key={item.id} style={{ marginBottom: '16px', paddingBottom: '16px', borderBottom: '1px solid #eee' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between' }}>
                      <div>
                        <strong>{item.name}</strong>
                        <p>Quantity: {item.quantity}</p>
                      </div>
                      <div>{item.price} kr</div>
                    </div>
                  </li>
                ))}
              </ul>

              <div style={{ marginTop: '24px', paddingTop: '24px', borderTop: '2px solid #333' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '18px', fontWeight: 'bold' }}>
                  <span>Total:</span>
                  <span>{total} kr</span>
                </div>
                <Button fullWidth style={{ marginTop: '16px' }}>
                  Checkout
                </Button>
              </div>
            </>
          )}
        </div>
      </Drawer>
    </div>
  );
}
```

## Persistent Drawer

```jsx
import { Drawer } from '@sikt/sds-drawer';
import { Button } from '@sikt/sds-button';
import { useState } from 'react';

function PersistentDrawer() {
  const [isOpen, setIsOpen] = useState(true);

  return (
    <div style={{ display: 'flex' }}>
      <Drawer
        open={isOpen}
        onClose={() => setIsOpen(false)}
        persistent
        position="left"
        title="Navigation"
      >
        <nav style={{ padding: '16px', width: '250px' }}>
          <ul style={{ listStyle: 'none', padding: 0 }}>
            <li style={{ marginBottom: '8px' }}><a href="/">Home</a></li>
            <li style={{ marginBottom: '8px' }}><a href="/about">About</a></li>
            <li style={{ marginBottom: '8px' }}><a href="/contact">Contact</a></li>
          </ul>
        </nav>
      </Drawer>

      <main style={{ flex: 1, padding: '24px', marginLeft: isOpen ? '0' : '0' }}>
        <Button onClick={() => setIsOpen(!isOpen)}>
          {isOpen ? 'Close' : 'Open'} Drawer
        </Button>
        <h1>Main Content</h1>
        <p>Content area adjusts when drawer opens/closes.</p>
      </main>
    </div>
  );
}
```

## Mobile Drawer

```jsx
import { Drawer } from '@sikt/sds-drawer';
import { Button } from '@sikt/sds-button';
import { useState } from 'react';

function MobileDrawer() {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <div>
      <header style={{ padding: '16px', backgroundColor: '#007bff', color: 'white', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <Button variant="text" onClick={() => setIsOpen(true)} style={{ color: 'white' }}>
          ☰
        </Button>
        <h1 style={{ margin: 0 }}>App Title</h1>
        <div style={{ width: '40px' }} />
      </header>

      <Drawer
        open={isOpen}
        onClose={() => setIsOpen(false)}
        position="left"
        fullWidth
      >
        <nav style={{ padding: '24px' }}>
          <ul style={{ listStyle: 'none', padding: 0 }}>
            <li style={{ marginBottom: '16px' }}>
              <a href="/" style={{ fontSize: '18px' }}>Home</a>
            </li>
            <li style={{ marginBottom: '16px' }}>
              <a href="/products" style={{ fontSize: '18px' }}>Products</a>
            </li>
            <li style={{ marginBottom: '16px' }}>
              <a href="/about" style={{ fontSize: '18px' }}>About</a>
            </li>
            <li style={{ marginBottom: '16px' }}>
              <a href="/contact" style={{ fontSize: '18px' }}>Contact</a>
            </li>
          </ul>
        </nav>
      </Drawer>
    </div>
  );
}
```

## Drawer with Footer

```jsx
import { Drawer } from '@sikt/sds-drawer';
import { Button } from '@sikt/sds-button';
import { useState } from 'react';

function DrawerWithFooter() {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <div>
      <Button onClick={() => setIsOpen(true)}>
        Open Drawer
      </Button>

      <Drawer
        open={isOpen}
        onClose={() => setIsOpen(false)}
        title="Confirm Action"
      >
        <div style={{ padding: '16px', minHeight: '300px' }}>
          <p>Are you sure you want to proceed with this action?</p>
          <p>This operation cannot be undone.</p>
        </div>

        <div style={{ padding: '16px', borderTop: '1px solid #eee', display: 'flex', gap: '12px', justifyContent: 'flex-end' }}>
          <Button variant="secondary" onClick={() => setIsOpen(false)}>
            Cancel
          </Button>
          <Button variant="danger" onClick={() => setIsOpen(false)}>
            Confirm
          </Button>
        </div>
      </Drawer>
    </div>
  );
}
```

## Best Practices

### Drawer Usage
- Use for secondary navigation or supplementary content
- Position left for navigation, right for contextual actions
- Keep drawer width appropriate (250-400px typically)
- Provide clear close mechanisms

### Content Organization
- Keep content focused and relevant
- Use headers to identify drawer purpose
- Include actions at bottom when needed
- Avoid deeply nested content

### Mobile Considerations
- Use full-width drawers on mobile
- Ensure touch-friendly tap targets
- Consider bottom drawers for mobile
- Test swipe gestures

## Accessibility Best Practices

- Use proper ARIA attributes (`role="dialog"`, `aria-modal`)
- Trap focus within drawer when open
- Close on Escape key press
- Return focus to trigger element after closing
- Provide clear close button
- Ensure keyboard navigation works

## Common Use Cases

- **Navigation** - Primary or secondary navigation menus
- **Filters** - Filter panels for search results or product listings
- **Cart** - Shopping cart side panel
- **Settings** - Application settings panel
- **User Profile** - User account information
- **Notifications** - Notification center

## Resources

- [Drawer Component Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-drawer--docs)
- [npm Package: @sikt/sds-drawer](https://www.npmjs.com/package/@sikt/sds-drawer)

## Related Skills

- **sikt-design-navigation**: Navigation patterns
- **sikt-design-dialog**: Modal dialogs
- **sikt-design-layout**: Layout components
- **sikt-design-general**: General design system guidelines
