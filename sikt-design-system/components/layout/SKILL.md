---
name: sikt-design-layout
description: Ready-to-use code examples for Sikt layout components. Use when developers ask "How do I create a page layout?", "Show me header and footer", "How to use cards?", or need layout implementations with headers, footers, cards, and grid systems.
---

# Sikt Layout Components

## Overview

This skill provides implementation examples for Sikt Design System layout components including page layouts, headers, footers, cards, and grid systems.

## Installation

```bash
npm install @sikt/sds-header @sikt/sds-footer @sikt/sds-card @sikt/sds-section @sikt/sds-button @sikt/sds-core
```

Import components:

```js
import { Header } from '@sikt/sds-header';
import { Footer } from '@sikt/sds-footer';
import { Card } from '@sikt/sds-card';
import { Section } from '@sikt/sds-section';
import { Button } from '@sikt/sds-button';
```

## Page Layout with Header and Footer

```jsx
import { Header } from '@sikt/sds-header';
import { Footer } from '@sikt/sds-footer';

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

## Header Component

### Basic Header

```jsx
import { Header } from '@sikt/sds-header';

function BasicHeader() {
  return (
    <Header
      logo={{ src: '/logo.png', alt: 'Company Logo' }}
      navigation={[
        { label: 'Home', href: '/' },
        { label: 'Products', href: '/products' },
        { label: 'Services', href: '/services' },
        { label: 'About', href: '/about' }
      ]}
    />
  );
}
```

### Header with User Menu

```jsx
import { Header } from '@sikt/sds-header';

function HeaderWithUser() {
  return (
    <Header
      navigation={[
        { label: 'Dashboard', href: '/dashboard' },
        { label: 'Projects', href: '/projects' }
      ]}
      userMenu={{
        name: 'John Doe',
        avatar: '/avatar.jpg',
        items: [
          { label: 'Profile', href: '/profile' },
          { label: 'Settings', href: '/settings' },
          { label: 'Logout', href: '/logout' }
        ]
      }}
    />
  );
}
```

## Footer Component

### Basic Footer

```jsx
import { Footer } from '@sikt/sds-footer';

function BasicFooter() {
  return (
    <Footer
      links={[
        { label: 'Privacy Policy', href: '/privacy' },
        { label: 'Terms of Service', href: '/terms' },
        { label: 'Contact Us', href: '/contact' }
      ]}
      copyright="© 2024 Sikt. All rights reserved."
    />
  );
}
```

### Footer with Multiple Columns

```jsx
import { Footer } from '@sikt/sds-footer';

function MultiColumnFooter() {
  return (
    <footer style={{ backgroundColor: '#f8f9fa', padding: '48px 24px', marginTop: 'auto' }}>
      <div style={{ maxWidth: '1200px', margin: '0 auto', display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '32px' }}>
        <div>
          <h3>Company</h3>
          <ul style={{ listStyle: 'none', padding: 0 }}>
            <li><a href="/about">About Us</a></li>
            <li><a href="/careers">Careers</a></li>
            <li><a href="/press">Press</a></li>
          </ul>
        </div>

        <div>
          <h3>Products</h3>
          <ul style={{ listStyle: 'none', padding: 0 }}>
            <li><a href="/product-1">Product 1</a></li>
            <li><a href="/product-2">Product 2</a></li>
            <li><a href="/pricing">Pricing</a></li>
          </ul>
        </div>

        <div>
          <h3>Support</h3>
          <ul style={{ listStyle: 'none', padding: 0 }}>
            <li><a href="/help">Help Center</a></li>
            <li><a href="/contact">Contact</a></li>
            <li><a href="/status">Status</a></li>
          </ul>
        </div>

        <div>
          <h3>Legal</h3>
          <ul style={{ listStyle: 'none', padding: 0 }}>
            <li><a href="/privacy">Privacy</a></li>
            <li><a href="/terms">Terms</a></li>
            <li><a href="/cookies">Cookies</a></li>
          </ul>
        </div>
      </div>

      <div style={{ maxWidth: '1200px', margin: '32px auto 0', textAlign: 'center', borderTop: '1px solid #dee2e6', paddingTop: '24px' }}>
        <p>© 2024 Sikt. All rights reserved.</p>
      </div>
    </footer>
  );
}
```

## Card Component

### Basic Card

```jsx
import { Card } from '@sikt/sds-card';

function BasicCard() {
  return (
    <Card>
      <h3>Card Title</h3>
      <p>Card content goes here.</p>
    </Card>
  );
}
```

### Card with Image

```jsx
import { Card } from '@sikt/sds-card';
import { Button } from '@sikt/sds-button';

function ImageCard({ title, description, image, link }) {
  return (
    <Card>
      <img
        src={image}
        alt={title}
        style={{ width: '100%', height: '200px', objectFit: 'cover', borderRadius: '4px 4px 0 0' }}
      />
      <div style={{ padding: '16px' }}>
        <h3 style={{ margin: '0 0 8px 0' }}>{title}</h3>
        <p style={{ margin: '0 0 16px 0', color: '#666' }}>{description}</p>
        <a href={link}><Button>Learn More</Button></a>
      </div>
    </Card>
  );
}
```

### Card with Actions

```jsx
import { Card } from '@sikt/sds-card';
import { Button } from '@sikt/sds-button';

function ActionCard({ title, description, onEdit, onDelete }) {
  return (
    <Card>
      <div style={{ padding: '16px' }}>
        <h3>{title}</h3>
        <p>{description}</p>

        <div style={{ display: 'flex', gap: '12px', marginTop: '16px' }}>
          <Button variant="secondary" onClick={onEdit}>
            Edit
          </Button>
          <Button variant="danger" onClick={onDelete}>
            Delete
          </Button>
        </div>
      </div>
    </Card>
  );
}
```

## Card Grid Layout

```jsx
import { Card } from '@sikt/sds-card';
import { Button } from '@sikt/sds-button';

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

## Container Component

```jsx
function Container({ children, size = 'default' }) {
  const sizes = {
    small: '800px',
    default: '1200px',
    large: '1400px',
    full: '100%'
  };

  return (
    <div style={{ maxWidth: sizes[size], margin: '0 auto', padding: '0 16px' }}>
      {children}
    </div>
  );
}
```

## Two-Column Layout

```jsx
function TwoColumnLayout({ sidebar, main }) {
  return (
    <div style={{ display: 'grid', gridTemplateColumns: '250px 1fr', gap: '24px' }}>
      <aside style={{ padding: '16px', backgroundColor: '#f8f9fa', borderRadius: '4px' }}>
        {sidebar}
      </aside>

      <main style={{ padding: '16px' }}>
        {main}
      </main>
    </div>
  );
}
```

## Three-Column Layout

```jsx
function ThreeColumnLayout({ left, center, right }) {
  return (
    <div style={{ display: 'grid', gridTemplateColumns: '200px 1fr 200px', gap: '24px' }}>
      <aside style={{ padding: '16px' }}>
        {left}
      </aside>

      <main style={{ padding: '16px' }}>
        {center}
      </main>

      <aside style={{ padding: '16px' }}>
        {right}
      </aside>
    </div>
  );
}
```

## Hero Section

```jsx
function HeroSection({ title, subtitle, ctaText, ctaLink, backgroundImage }) {
  return (
    <section style={{
      backgroundImage: `url(${backgroundImage})`,
      backgroundSize: 'cover',
      backgroundPosition: 'center',
      padding: '120px 24px',
      textAlign: 'center',
      color: 'white'
    }}>
      <div style={{ maxWidth: '800px', margin: '0 auto' }}>
        <h1 style={{ fontSize: '48px', marginBottom: '16px' }}>{title}</h1>
        <p style={{ fontSize: '20px', marginBottom: '32px' }}>{subtitle}</p>
        <a href={ctaLink}>
          <Button size="large">{ctaText}</Button>
        </a>
      </div>
    </section>
  );
}
```

## Section Component

```jsx
import { Section } from '@sikt/sds-section';

function SectionLayout() {
  return (
    <div>
      <Section title="Features" backgroundColor="#f8f9fa">
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '24px' }}>
          <div>Feature 1</div>
          <div>Feature 2</div>
          <div>Feature 3</div>
        </div>
      </Section>

      <Section title="Testimonials">
        <p>Customer feedback goes here...</p>
      </Section>

      <Section title="Contact" backgroundColor="#e9ecef">
        <p>Get in touch with us...</p>
      </Section>
    </div>
  );
}
```

## Best Practices

### Layout Structure
- Use semantic HTML (`<header>`, `<main>`, `<footer>`, `<section>`, `<aside>`)
- Maintain consistent spacing and margins
- Use max-width for content containers
- Ensure responsive behavior

### Grid Systems
- Use CSS Grid or Flexbox for layouts
- Make layouts responsive with media queries
- Consider mobile-first design
- Use consistent gap spacing

### Cards
- Keep card content concise
- Use consistent card sizes in grids
- Provide clear call-to-action buttons
- Include hover states for interactive cards

## Accessibility Best Practices

- Use proper semantic HTML structure
- Ensure sufficient color contrast
- Provide skip navigation links
- Make navigation keyboard accessible
- Use proper heading hierarchy
- Include ARIA landmarks where needed

## Responsive Design

- Mobile-first approach
- Flexible grid layouts
- Responsive images
- Touch-friendly interactive elements
- Test across different screen sizes

## Resources

- [Header Component Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-header-readme--docs)
- [Footer Component Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-footer-readme--docs)
- [Card Component Storybook](https://designsystem.sikt.no/storybook/?path=/docs/components-card-readme--docs)
- [npm Package: @sikt/sds-header](https://www.npmjs.com/package/@sikt/sds-header)
- [npm Package: @sikt/sds-footer](https://www.npmjs.com/package/@sikt/sds-footer)
- [npm Package: @sikt/sds-card](https://www.npmjs.com/package/@sikt/sds-card)

## Related Skills

- **sikt-design-button**: Button components for layouts
- **sikt-design-navigation**: Navigation components
- **sikt-design-general**: General design system guidelines
