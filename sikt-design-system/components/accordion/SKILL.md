---
name: sikt-design-accordion
description: Ready-to-use code examples for Sikt accordion and collapsible components. Use when developers ask "How do I create an accordion?", "Show me collapsible sections", "How to implement expandable content?", or need accordion, details, and disclosure widget patterns.
---

# Sikt Accordion and Collapsible Components

## Overview

This skill provides implementation examples for Sikt Design System accordion and collapsible content patterns including accordion components, details/disclosure widgets, and expandable sections.

## Installation

```bash
npm install @sikt/sds-accordion @sikt/sds-details @sikt/sds-core
```

Import the core CSS file (REQUIRED) and components:

```js
// REQUIRED: Import core styles for design tokens, base styles, and component styling
import '@sikt/sds-core/dist/index.css';

// Import components
import { Accordion } from '@sikt/sds-accordion';
import { Details } from '@sikt/sds-details';
```

**CRITICAL**:
- You MUST import `@sikt/sds-core/dist/index.css` for components to display correctly with borders, outlines, and proper styling
- Do NOT import component-specific CSS files (e.g., `@sikt/sds-accordion/dist/index.css`) - these are not needed
- Components will not have proper styling without the core CSS import

## Basic Accordion

```jsx
import { Accordion } from '@sikt/sds-accordion';
import { useState } from 'react';

function BasicAccordion() {
  const [activeIndex, setActiveIndex] = useState(null);

  const items = [
    {
      id: 'item1',
      title: 'Accordion Item 1',
      content: 'Content for the first accordion item goes here.'
    },
    {
      id: 'item2',
      title: 'Accordion Item 2',
      content: 'Content for the second accordion item goes here.'
    },
    {
      id: 'item3',
      title: 'Accordion Item 3',
      content: 'Content for the third accordion item goes here.'
    }
  ];

  return (
    <Accordion
      items={items}
      activeIndex={activeIndex}
      onChange={setActiveIndex}
    />
  );
}
```

## Multi-Expand Accordion

```jsx
import { Accordion } from '@sikt/sds-accordion';
import { useState } from 'react';

function MultiExpandAccordion() {
  const [expandedItems, setExpandedItems] = useState([]);

  const items = [
    {
      id: 'item1',
      title: 'Section 1',
      content: 'Content for section 1'
    },
    {
      id: 'item2',
      title: 'Section 2',
      content: 'Content for section 2'
    },
    {
      id: 'item3',
      title: 'Section 3',
      content: 'Content for section 3'
    }
  ];

  const toggleItem = (itemId) => {
    setExpandedItems(prev =>
      prev.includes(itemId)
        ? prev.filter(id => id !== itemId)
        : [...prev, itemId]
    );
  };

  return (
    <div>
      {items.map(item => (
        <Accordion
          key={item.id}
          expanded={expandedItems.includes(item.id)}
          onChange={() => toggleItem(item.id)}
          title={item.title}
        >
          {item.content}
        </Accordion>
      ))}
    </div>
  );
}
```

## Details Component (Native HTML)

```jsx
import { Details } from '@sikt/sds-details';

function DetailsWidget() {
  return (
    <Details summary="Click to expand">
      <p>This content is hidden by default and can be expanded.</p>
      <p>The Details component uses the native HTML details element.</p>
    </Details>
  );
}
```

## FAQ Pattern

```jsx
import { Accordion } from '@sikt/sds-accordion';
import { useState } from 'react';

function FAQAccordion() {
  const [activeIndex, setActiveIndex] = useState(null);

  const faqs = [
    {
      id: 'faq1',
      question: 'What is Sikt Design System?',
      answer: 'Sikt Design System is a comprehensive set of design guidelines and reusable components for building consistent user interfaces.'
    },
    {
      id: 'faq2',
      question: 'How do I get started?',
      answer: 'Install the required npm packages and import the components you need. Refer to the documentation for specific implementation details.'
    },
    {
      id: 'faq3',
      question: 'Is it accessible?',
      answer: 'Yes, all components follow WCAG 2.1/2.2 guidelines and include proper ARIA attributes for screen reader support.'
    }
  ];

  return (
    <section>
      <h2>Frequently Asked Questions</h2>
      <Accordion
        items={faqs.map(faq => ({
          id: faq.id,
          title: faq.question,
          content: faq.answer
        }))}
        activeIndex={activeIndex}
        onChange={setActiveIndex}
      />
    </section>
  );
}
```

## Nested Accordion

```jsx
import { Accordion } from '@sikt/sds-accordion';
import { useState } from 'react';

function NestedAccordion() {
  const [activeParent, setActiveParent] = useState(null);
  const [activeChild, setActiveChild] = useState(null);

  return (
    <Accordion
      items={[
        {
          id: 'parent1',
          title: 'Parent Item 1',
          content: (
            <Accordion
              items={[
                { id: 'child1', title: 'Child Item 1', content: 'Child content 1' },
                { id: 'child2', title: 'Child Item 2', content: 'Child content 2' }
              ]}
              activeIndex={activeChild}
              onChange={setActiveChild}
            />
          )
        },
        {
          id: 'parent2',
          title: 'Parent Item 2',
          content: 'Parent content 2'
        }
      ]}
      activeIndex={activeParent}
      onChange={setActiveParent}
    />
  );
}
```

## Accordion with Icons

```jsx
import { Accordion } from '@sikt/sds-accordion';
import { useState } from 'react';

function IconAccordion() {
  const [activeIndex, setActiveIndex] = useState(null);

  const items = [
    {
      id: 'item1',
      title: 'Account Settings',
      icon: 'settings',
      content: 'Manage your account preferences and settings.'
    },
    {
      id: 'item2',
      title: 'Privacy & Security',
      icon: 'lock',
      content: 'Control your privacy and security options.'
    },
    {
      id: 'item3',
      title: 'Notifications',
      icon: 'notifications',
      content: 'Configure your notification preferences.'
    }
  ];

  return (
    <Accordion
      items={items}
      activeIndex={activeIndex}
      onChange={setActiveIndex}
      showIcons
    />
  );
}
```

## Controlled Accordion

```jsx
import { Accordion } from '@sikt/sds-accordion';
import { Button } from '@sikt/sds-button';
import { useState } from 'react';

function ControlledAccordion() {
  const [activeIndex, setActiveIndex] = useState(null);

  const items = [
    { id: 'item1', title: 'Item 1', content: 'Content 1' },
    { id: 'item2', title: 'Item 2', content: 'Content 2' },
    { id: 'item3', title: 'Item 3', content: 'Content 3' }
  ];

  return (
    <div>
      <div style={{ marginBottom: '16px' }}>
        <Button onClick={() => setActiveIndex(0)}>Open First</Button>
        <Button onClick={() => setActiveIndex(null)}>Close All</Button>
      </div>

      <Accordion
        items={items}
        activeIndex={activeIndex}
        onChange={setActiveIndex}
      />
    </div>
  );
}
```

## Accordion with Rich Content

```jsx
import { Accordion } from '@sikt/sds-accordion';
import { Button } from '@sikt/sds-button';
import { useState } from 'react';

function RichContentAccordion() {
  const [activeIndex, setActiveIndex] = useState(null);

  const items = [
    {
      id: 'item1',
      title: 'Getting Started',
      content: (
        <div>
          <p>Follow these steps to get started:</p>
          <ol>
            <li>Install the required packages</li>
            <li>Import components in your project</li>
            <li>Start building your interface</li>
          </ol>
          <Button>View Documentation</Button>
        </div>
      )
    },
    {
      id: 'item2',
      title: 'Advanced Features',
      content: (
        <div>
          <h4>Key Features:</h4>
          <ul>
            <li>Customizable styling</li>
            <li>Accessibility built-in</li>
            <li>Responsive design</li>
          </ul>
        </div>
      )
    }
  ];

  return (
    <Accordion
      items={items}
      activeIndex={activeIndex}
      onChange={setActiveIndex}
    />
  );
}
```

## Settings Panel Pattern

```jsx
import { Accordion } from '@sikt/sds-accordion';
import { Checkbox } from '@sikt/sds-checkbox';
import { Select } from '@sikt/sds-select';
import { useState } from 'react';

function SettingsPanel() {
  const [activeIndex, setActiveIndex] = useState(null);

  const sections = [
    {
      id: 'general',
      title: 'General Settings',
      content: (
        <div>
          <Checkbox label="Enable notifications" />
          <Checkbox label="Auto-save changes" />
        </div>
      )
    },
    {
      id: 'display',
      title: 'Display Settings',
      content: (
        <div>
          <Select
            label="Theme"
            options={[
              { value: 'light', label: 'Light' },
              { value: 'dark', label: 'Dark' }
            ]}
          />
        </div>
      )
    }
  ];

  return (
    <aside style={{ width: '300px', padding: '16px' }}>
      <h3>Settings</h3>
      <Accordion
        items={sections}
        activeIndex={activeIndex}
        onChange={setActiveIndex}
      />
    </aside>
  );
}
```

## Best Practices

### Accordion Usage
- Use for grouping related content that users may want to show/hide
- Keep titles clear and descriptive
- Consider default expanded state for important content
- Limit nesting to 2 levels maximum

### Content Organization
- Group logically related information
- Use consistent content structure within items
- Provide visual feedback for expanded/collapsed states
- Ensure smooth transitions

### Performance
- Lazy load content in accordion items if heavy
- Avoid deeply nested accordions
- Consider virtualization for very long lists

## Accessibility Best Practices

- Use proper ARIA attributes (`aria-expanded`, `aria-controls`)
- Ensure keyboard navigation works (Enter/Space to toggle)
- Provide clear focus indicators
- Use semantic heading levels in titles
- Announce state changes to screen readers
- Make expand/collapse buttons keyboard accessible

## Common Use Cases

- **FAQs** - Frequently asked questions sections
- **Settings Panels** - Grouped settings and preferences
- **Documentation** - Long-form content organization
- **Navigation** - Collapsible menu sections
- **Product Details** - Expandable product information
- **Forms** - Multi-section forms with optional fields

## Resources

- [Accordion Component Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-accordion--docs)
- [Details Component Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-details--docs)
- [npm Package: @sikt/sds-accordion](https://www.npmjs.com/package/@sikt/sds-accordion)
- [npm Package: @sikt/sds-details](https://www.npmjs.com/package/@sikt/sds-details)

## Related Skills

- **sikt-design-navigation**: Navigation patterns with collapsible menus
- **sikt-design-layout**: Layout patterns for content organization
- **sikt-design-general**: General design system guidelines
