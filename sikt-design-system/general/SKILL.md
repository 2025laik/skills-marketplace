---
name: sikt-design-system
description: Expert guide for building web apps and components with Sikt Design System. Use when developers ask about Sikt components, styling, colors, typography, accessibility, or need help choosing the right component. Answers questions like "How do I style a button?", "What colors should I use?", "Which component for forms?", "How to make it accessible?"
---

# Sikt Design System

## Overview

This skill helps developers build web applications and components using the Sikt Design System. Whether you're creating a new app, implementing a specific component, or need styling guidance, this skill provides practical answers and code examples.

**Common Questions I Can Answer:**
- "What component should I use for a form?"
- "How do I style this button with Sikt colors?"
- "What's the correct typography for headings?"
- "How do I make my app accessible?"
- "Where can I find Sikt icons?"
- "What are the responsive breakpoints?"
- "How do I use design tokens?"

## Quick Start for Developers

### Installation

All Sikt Design System components require the base package. Install dependencies with npm:

```bash
npm install @sikt/sds-core @sikt/sds-<component-name>
```

**Two packages are always required:**

1. **`@sikt/sds-core`** - Base styles, fonts, design tokens (required for all projects)
2. **`@sikt/sds-<component-name>`** - The specific component (e.g., `@sikt/sds-button`, `@sikt/sds-input`)

**Examples:**

```bash
# For Button component
npm install @sikt/sds-core @sikt/sds-button

# For Form components
npm install @sikt/sds-core @sikt/sds-form @sikt/sds-input @sikt/sds-checkbox

# For multiple components
npm install @sikt/sds-core @sikt/sds-button @sikt/sds-card @sikt/sds-header
```

### Just Starting?
1. **Install core** package and desired components via npm
2. **Import CSS** once in your app entry point: `import '@sikt/sds-core/dist/index.css';`
3. **Choose components** from 43 available options (buttons, forms, cards, etc.)
4. **Apply design tokens** for colors, spacing, and typography
5. **Follow responsive breakpoints**: Mobile (<720px), Tablet (720px), Desktop (1024px)
6. **Test accessibility** using the built-in guidelines

### Need Something Specific?
- **Building a form?** → See Form & Input Components section
- **Creating a layout?** → See Layout & Container Components section
- **Showing feedback?** → See Message & Feedback Components section
- **Need component docs?** → Use the `sikt-design-system/storybook` skill for URLs
- **Need code examples?** → Use the `sikt-design-system/components` skill
- **Need installation help?** → See the Installation section above
- **Setting up a new project?** → See the Framework Setup Guides section below

## Framework Setup Guides

### React (Create React App)

1. Create new app and install dependencies:
```bash
npx create-react-app my-sikt-app
cd my-sikt-app
npm install @sikt/sds-core @sikt/sds-button
```

2. Import CSS in `src/index.js` or `src/index.tsx`:
```js
import React from 'react';
import ReactDOM from 'react-dom/client';
import '@sikt/sds-core/dist/index.css'; // Import Sikt styles FIRST
import './index.css'; // Your custom styles after
import App from './App';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(<App />);
```

3. Use components in `src/App.js`:
```jsx
import { Button } from '@sikt/sds-button';

function App() {
  return (
    <div style={{ padding: '24px' }}>
      <h1>My Sikt App</h1>
      <Button variant="primary">Click me</Button>
    </div>
  );
}

export default App;
```

### React (Vite)

1. Create new app and install dependencies:
```bash
npm create vite@latest my-sikt-app -- --template react-ts
cd my-sikt-app
npm install
npm install @sikt/sds-core @sikt/sds-button
```

2. Import CSS in `src/main.tsx`:
```tsx
import React from 'react';
import ReactDOM from 'react-dom/client';
import '@sikt/sds-core/dist/index.css'; // Import Sikt styles FIRST
import './index.css'; // Your custom styles after
import App from './App';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
```

3. Use components in `src/App.tsx`:
```tsx
import { Button } from '@sikt/sds-button';

function App() {
  return (
    <div style={{ padding: '24px' }}>
      <h1>My Sikt App</h1>
      <Button variant="primary">Click me</Button>
    </div>
  );
}

export default App;
```

### Next.js (App Router - Next.js 13+)

1. Create new app and install dependencies:
```bash
npx create-next-app@latest my-sikt-app
cd my-sikt-app
npm install @sikt/sds-core @sikt/sds-button
```

2. Import CSS in `app/layout.tsx`:
```tsx
import '@sikt/sds-core/dist/index.css'; // Import Sikt styles FIRST
import './globals.css'; // Your custom styles after

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
```

3. Use components in `app/page.tsx`:
```tsx
import { Button } from '@sikt/sds-button';

export default function Home() {
  return (
    <div style={{ padding: '24px' }}>
      <h1>My Sikt App</h1>
      <Button variant="primary">Click me</Button>
    </div>
  );
}
```

### Next.js (Pages Router - Next.js 12 and earlier)

1. Create new app and install dependencies:
```bash
npx create-next-app@latest my-sikt-app
cd my-sikt-app
npm install @sikt/sds-core @sikt/sds-button
```

2. Import CSS in `pages/_app.tsx`:
```tsx
import '@sikt/sds-core/dist/index.css'; // Import Sikt styles FIRST
import '../styles/globals.css'; // Your custom styles after
import type { AppProps } from 'next/app';

export default function App({ Component, pageProps }: AppProps) {
  return <Component {...pageProps} />;
}
```

3. Use components in `pages/index.tsx`:
```tsx
import { Button } from '@sikt/sds-button';

export default function Home() {
  return (
    <div style={{ padding: '24px' }}>
      <h1>My Sikt App</h1>
      <Button variant="primary">Click me</Button>
    </div>
  );
}
```

## Adding Sikt to an Existing Project

If you have an existing project and want to add Sikt Design System:

### Step 1: Install Dependencies
```bash
npm install @sikt/sds-core
# Add specific components as needed
npm install @sikt/sds-button @sikt/sds-input @sikt/sds-card
```

### Step 2: Import CSS
Add the CSS import to your application entry point (ONCE):
- **React/Vite**: `src/main.tsx` or `src/index.tsx`
- **Next.js App Router**: `app/layout.tsx`
- **Next.js Pages Router**: `pages/_app.tsx`

```tsx
import '@sikt/sds-core/dist/index.css';
```

**IMPORTANT**: Import Sikt CSS BEFORE your custom CSS to allow easy overrides.

### Step 3: Replace Components Gradually
You don't need to convert everything at once. Start with one component type:

**Before (custom button):**
```tsx
<button className="custom-btn primary" onClick={handleClick}>
  Submit
</button>
```

**After (Sikt button):**
```tsx
import { Button } from '@sikt/sds-button';

<Button variant="primary" onClick={handleClick}>
  Submit
</Button>
```

### Step 4: Update Colors and Spacing
Replace hard-coded colors with Sikt design tokens:

**Before:**
```css
.my-card {
  background: #ffffff;
  padding: 16px;
  border-radius: 4px;
}
```

**After:**
```css
.my-card {
  background: var(--sds-color-layout-surface-1);
  padding: var(--sds-space-padding-medium);
  border-radius: var(--sds-size-border-radius-small);
}
```

## Dark Mode Implementation

The Sikt Design System supports light and dark themes through theme-aware design tokens. Surface tokens automatically adapt when dark mode is enabled.

### Enabling Dark Mode

Add a `data-theme` attribute to your root HTML element:

```html
<html data-theme="dark">
  <!-- Your app -->
</html>
```

Or in React:
```tsx
<html data-theme={isDarkMode ? 'dark' : 'light'}>
  <body>{children}</body>
</html>
```

### Theme Toggle Implementation

```tsx
import { Button } from '@sikt/sds-button';
import { useState, useEffect } from 'react';

function ThemeToggle() {
  const [isDarkMode, setIsDarkMode] = useState(false);

  useEffect(() => {
    // Apply theme to html element
    document.documentElement.setAttribute(
      'data-theme',
      isDarkMode ? 'dark' : 'light'
    );
  }, [isDarkMode]);

  return (
    <Button onClick={() => setIsDarkMode(!isDarkMode)}>
      {isDarkMode ? 'Light Mode' : 'Dark Mode'}
    </Button>
  );
}
```

### Theme Persistence

Save theme preference to localStorage:

```tsx
import { useState, useEffect } from 'react';

function useTheme() {
  const [isDarkMode, setIsDarkMode] = useState(() => {
    // Check localStorage on mount
    const saved = localStorage.getItem('theme');
    return saved === 'dark';
  });

  useEffect(() => {
    // Update HTML and save to localStorage
    const theme = isDarkMode ? 'dark' : 'light';
    document.documentElement.setAttribute('data-theme', theme);
    localStorage.setItem('theme', theme);
  }, [isDarkMode]);

  const toggleTheme = () => setIsDarkMode(!isDarkMode);

  return { isDarkMode, toggleTheme };
}

// Usage in your app
function App() {
  const { isDarkMode, toggleTheme } = useTheme();

  return (
    <div>
      <Button onClick={toggleTheme}>
        Switch to {isDarkMode ? 'Light' : 'Dark'} Mode
      </Button>
    </div>
  );
}
```

### Respecting System Preference

Automatically use the user's system theme preference:

```tsx
import { useState, useEffect } from 'react';

function useTheme() {
  const [isDarkMode, setIsDarkMode] = useState(() => {
    // Check localStorage first, then system preference
    const saved = localStorage.getItem('theme');
    if (saved) return saved === 'dark';

    return window.matchMedia('(prefers-color-scheme: dark)').matches;
  });

  useEffect(() => {
    const theme = isDarkMode ? 'dark' : 'light';
    document.documentElement.setAttribute('data-theme', theme);
    localStorage.setItem('theme', theme);
  }, [isDarkMode]);

  // Listen for system theme changes
  useEffect(() => {
    const mediaQuery = window.matchMedia('(prefers-color-scheme: dark)');
    const handleChange = (e: MediaQueryListEvent) => {
      if (!localStorage.getItem('theme')) {
        setIsDarkMode(e.matches);
      }
    };

    mediaQuery.addEventListener('change', handleChange);
    return () => mediaQuery.removeEventListener('change', handleChange);
  }, []);

  const toggleTheme = () => setIsDarkMode(!isDarkMode);

  return { isDarkMode, toggleTheme };
}
```

### Theme-Aware Components

When using Sikt components, surface tokens automatically adapt:

```tsx
// This card will automatically switch colors in dark mode
<div style={{
  background: 'var(--sds-color-layout-surface-1)',
  padding: 'var(--sds-space-padding-medium)',
  borderRadius: 'var(--sds-size-border-radius-small)'
}}>
  <h2 style={{ color: 'var(--sds-color-text-primary)' }}>
    Card Title
  </h2>
  <p style={{ color: 'var(--sds-color-text-secondary)' }}>
    This content adapts to light/dark theme automatically.
  </p>
</div>
```

**Key Theme-Aware Tokens:**
- `--sds-color-layout-page-default` - Page background
- `--sds-color-layout-surface-1` - Primary content layer
- `--sds-color-layout-surface-2` - Elevated content layer
- `--sds-color-text-primary` - Main text color
- `--sds-color-text-secondary` - Muted text color

## When to Use This Skill

**Use this skill when developers ask about:**
- Which Sikt component to use for their use case
- How to style components with Sikt colors and typography
- What spacing, colors, or fonts are available
- How to implement Sikt branding (logos, colors, icons)
- Accessibility requirements and testing
- Responsive design and breakpoints
- Design token names and usage

## Core Capabilities

### 1. Visual Identity & Branding

**Brand Colors:**
- Primary: Purple palette (strongest brand differentiator)
- Secondary: Support colors for illustrations, data visualization, social media
- Token-based color system for digital products

**CRITICAL Design Principles:**
- **NO GRADIENTS**: Avoid using gradients in any form. Use solid colors from the design system tokens
- Use flat, solid colors for all UI elements (backgrounds, borders, text)
- Gradients compromise accessibility, brand consistency, and visual clarity

**Typography:**
- Primary font: Haffer (Regular 400, Semibold 600, Bold 700)
- Fallback: Arial
- Two headline packages: Editorial (high contrast) and Application (compact)
- Semantic tokens for headlines, body text, labels, and overlines

**Logos:**
- Primary logo (min: 60px screen / 20mm print)
- Secondary logo with full brand name (min: 90px screen / 35mm print)
- Icon logo for constrained spaces (min: 25px screen / 8mm print)
- Available in Bokmål, Nynorsk, Finnish, and Samisk

### 2. Design Tokens

Token naming convention:
```
--{prefix}-{type}-{category}-{name}-{variant}-{state}
```

**Token Types:**
- `sds-color-*`: Brand, interaction, feedback, text, surface colors
- `sds-space-*`: Padding (responsive), gap (fixed), margin
- `sds-size-*`: Border weight, border radius, dimensions
- `sds-typography-*`: Font size, weight, line height, letter spacing

**Spacing System:**
- Base tokens: 2px to 192px scale
- Padding tokens: Responsive (12px → 16px → 24px across devices)
- Gap tokens: Fixed (4px to 48px)

**Border System:**
- Weight: thin (1px), regular (2px), bold (4px)
- Radius: minimal (4px) to full (99999px)

### 3. Responsive Breakpoints

| Device | Breakpoint | Usage |
|--------|------------|-------|
| Mobile | < 720px | Default, mobile-first |
| Tablet | 720px | Tablet layouts |
| Desktop | 1024px | Full desktop experience |
| Ultrawide | 1440px | Large screen enhancements |

### 3b. NPM Package Reference

**Finding the correct package name:**

All components follow the pattern `@sikt/sds-<component-type>`. Use the table below to find exact package names:

| Use Case | NPM Package | Install Command |
|----------|-------------|-----------------|
| Buttons | `@sikt/sds-button` | `npm install @sikt/sds-core @sikt/sds-button` |
| Text inputs | `@sikt/sds-input` | `npm install @sikt/sds-core @sikt/sds-form @sikt/sds-input` |
| Email inputs | `@sikt/sds-input` | `npm install @sikt/sds-core @sikt/sds-form @sikt/sds-input` |
| Select dropdowns | `@sikt/sds-select` | `npm install @sikt/sds-core @sikt/sds-form @sikt/sds-select` |
| Checkboxes | `@sikt/sds-checkbox` | `npm install @sikt/sds-core @sikt/sds-form @sikt/sds-checkbox` |
| Radio buttons | `@sikt/sds-radio` | `npm install @sikt/sds-core @sikt/sds-form @sikt/sds-radio` |
| Toggles | `@sikt/sds-toggle` | `npm install @sikt/sds-core @sikt/sds-form @sikt/sds-toggle` |
| Date pickers | `@sikt/sds-input-datepicker` | `npm install @sikt/sds-core @sikt/sds-form @sikt/sds-input-datepicker` |
| File uploads | `@sikt/sds-input-file` | `npm install @sikt/sds-core @sikt/sds-form @sikt/sds-input-file` |
| Comboboxes | `@sikt/sds-combobox` | `npm install @sikt/sds-core @sikt/sds-form @sikt/sds-combobox` |
| Cards | `@sikt/sds-card` | `npm install @sikt/sds-core @sikt/sds-card` |
| Headers | `@sikt/sds-header` | `npm install @sikt/sds-core @sikt/sds-header` |
| Footers | `@sikt/sds-footer` | `npm install @sikt/sds-core @sikt/sds-footer` |
| Tables | `@sikt/sds-table` | `npm install @sikt/sds-core @sikt/sds-table` |
| Dialogs | `@sikt/sds-dialog` | `npm install @sikt/sds-core @sikt/sds-dialog` |
| Alerts | Message component | See Storybook for exact package |
| Icons | `@sikt/sds-icons` | `npm install @sikt/sds-icons` |
| Design tokens | `@sikt/sds-tokens` | `npm install @sikt/sds-tokens` |

**About `@sikt/sds-form`:**
The `@sikt/sds-form` package provides shared form utilities, styles, and base components required by all form input components (TextInput, Checkbox, Select, etc.). It includes:
- Common form field layouts and spacing
- Label and error message styling
- Form validation helpers
- Shared accessibility features

**When to install it:** Include `@sikt/sds-form` whenever you use any form input component. It's a peer dependency that ensures consistent form behavior across all input types.

For complete list of 43+ components, use the `sikt-design-storybook` skill to find Storybook documentation URLs.

### 4. Component Selection Guide (43 Components)

**"I need to collect user input..."**
- Single line text? → **Text Input** or **Email Input**
- Multiple lines? → **Text Area**
- Date? → **Datepicker Input**
- Choose one option? → **Radio Input**
- Choose multiple? → **Checkbox Input**
- Select from many options? → **Select Input** or **Combobox Input**
- Upload files? → **File Input**
- On/off toggle? → **Toggle Switch**

**"I need to show information or feedback..."**
- Important message? → **Alert**
- Form errors? → **Error Summary**
- Loading/error state? → **Application Status**
- Help text? → **Guide Panel**
- Status indicator? → **Badge**

**"I need navigation..."**
- Action button? → **Button**
- Page numbers? → **Pagination**
- Show hierarchy? → **Breadcrumbs**
- Organize content? → **Tabs**
- Modal dialog? → **Dialog**
- Context menu? → **Popover**

**"I need layout structure..."**
- Group content? → **Card** or **Section**
- Page structure? → **Header** and **Footer**
- Data display? → **Table**
- Collapsible content? → **Details**
- List items? → **List**

**All Components:**
Core: Heading, Link, Paragraph, Screen Reader Only
Message & Feedback: Alert, Application Status, Error Summary, Guide Panel
Forms & Input: Checkbox Input, Combobox Input, Datepicker Input, File Input, Radio Input, Select Input, Text Area, Text Input, Toggle Switch
Layout & Container: Badge, Breadcrumbs, Card, Details, Footer, Header, Logo, Section
Interactive & Navigation: Button, Dialog, Filter List, List, Pagination, Popover, Tabs, Table, Toggle Button, Toggle Segment, Progress Indicator

### 5. Icon Library

**Source:** Phosphor Icons (curated selection)

**Categories:** UI, Navigation, Action, Communication, Time & Date, Files, Sorting & Filtering, Status, Social Media

**Format:** SVG files with copy-to-clipboard integration

### 6. Accessibility Standards

**Compliance Requirements:**
- Private organizations: WCAG 2.0 (35 requirements)
- Public organizations: WCAG 2.1 Level A/AA (49 of 50 requirements)
- New solutions: WCAG 2.2 standards

**Key Testing Methods:**
1. Keyboard navigation (full functionality without mouse)
2. Heading structure (single H1, hierarchical)
3. Zoom testing (400% zoom, 200% text enlargement)
4. Image alt text (descriptive for informative, empty for decorative)
5. Color contrast (4.5:1 minimum for normal text, 3:1 for large text)
6. Automated tools (Axe DevTools, WAVE, Arc Toolkit)
7. Screen reader testing (NVDA, VoiceOver, TalkBack)

## Answering Common Developer Questions

### "How do I style a button with Sikt colors?"

```css
.my-button {
  background: var(--sds-color-interaction-primary-strong);
  color: var(--sds-color-text-inverse);
  padding: var(--sds-space-padding-medium);
  border-radius: var(--sds-size-border-radius-minimal);
  font: var(--sds-typography-body-medium);
}

.my-button:hover {
  background: var(--sds-color-interaction-primary-strong-hover);
}
```

### "How do I style a card with proper backgrounds?"

```css
/* Card on page background */
.my-card {
  background: var(--sds-color-layout-surface-1);
  padding: var(--sds-space-padding-medium);
  border-radius: var(--sds-size-border-radius-small);
}

/* Elevated card or modal (layered on surface-1) */
.my-modal {
  background: var(--sds-color-layout-surface-2);
  padding: var(--sds-space-padding-large);
  border-radius: var(--sds-size-border-radius-small);
}
```

**Important**: Use surface tokens for backgrounds, not interaction tokens. Surface tokens automatically adapt to light/dark themes.

### "What colors are available?"

**Surface Colors** (for backgrounds and containers - theme-aware):
- `--sds-color-layout-page-default` (page background)
- `--sds-color-layout-surface-1` (primary content layer - use for cards on page)
- `--sds-color-layout-surface-2` (secondary layer - use for elevated/nested content)
- **Layering hierarchy**: Always start with surface-1 on page-default, then layer surface-2 on top

**Interactive Colors** (for buttons, links, etc.):
- Primary: `--sds-color-interaction-primary-strong/subtle/transparent`
- Neutral: `--sds-color-interaction-neutral-strong/subtle/transparent`
- All include hover/active states

**Feedback Colors** (for alerts, messages):
- Success: `--sds-color-support-success-strong/subtle`
- Error: `--sds-color-support-critical-strong/subtle`
- Warning: `--sds-color-support-warning-strong/subtle`
- Info: `--sds-color-support-info-strong/subtle`

**Text Colors**:
- `--sds-color-text-primary` (main text)
- `--sds-color-text-secondary` (muted text)
- `--sds-color-text-inverse` (on dark backgrounds)

### "What typography should I use?"

**For content-heavy sites (Editorial):**
```css
h1 { font: var(--sds-typography-headline-editorial-h1); }
h2 { font: var(--sds-typography-headline-editorial-h2); }
p { font: var(--sds-typography-body-medium); }
```

**For dense applications (Application):**
```css
h1 { font: var(--sds-typography-headline-application-h1); }
h2 { font: var(--sds-typography-headline-application-h2); }
p { font: var(--sds-typography-body-medium); }
```

### "How do I make my form accessible?"

**Essential Checklist:**
1. **Labels**: Every input needs a visible label
   ```html
   <label for="email">Email</label>
   <input id="email" type="email" required>
   ```

2. **Error messages**: Clear, specific, linked to inputs
   ```html
   <input aria-describedby="email-error" aria-invalid="true">
   <span id="email-error">Please enter a valid email</span>
   ```

3. **Keyboard navigation**: Tab through all inputs, submit with Enter
4. **Focus indicators**: Visible focus states on all interactive elements
5. **Error summary**: Show all errors at top of form on submit

### "What spacing should I use?"

**Responsive Padding** (changes by device):
- Small: 8px → 12px → 16px
- Medium: 12px → 16px → 24px
- Large: 16px → 24px → 32px

```css
.container {
  padding: var(--sds-space-padding-medium);
}
```

**Fixed Gap** (same on all devices):
```css
.flex-container {
  display: flex;
  gap: var(--sds-space-gap-16); /* Always 16px */
}
```

### "Where can I find the component documentation?"

All components are documented in Storybook at `https://designsystem.sikt.no/storybook/`

To get a specific component's documentation URL:
- Use the `sikt-design-system/storybook` skill which has a Python script that generates and validates the correct URL for any component
- The script handles different URL patterns automatically
- Example: `python get_storybook_url.py "Button"` will find and return the correct Storybook URL

### "How do I implement responsive design?"

**Breakpoints:**
```css
/* Mobile first (default) */
.my-component {
  padding: 12px;
}

/* Tablet (720px+) */
@media (min-width: 720px) {
  .my-component {
    padding: 16px;
  }
}

/* Desktop (1024px+) */
@media (min-width: 1024px) {
  .my-component {
    padding: 24px;
  }
}
```

Or use responsive tokens:
```css
.my-component {
  padding: var(--sds-space-padding-medium); /* Handles all breakpoints */
}
```

## Troubleshooting

### Styles Not Loading

**Problem:** Components appear unstyled or have no borders/outlines.

**Solution:**
1. Verify CSS import is present in your app entry point:
   ```tsx
   import '@sikt/sds-core/dist/index.css';
   ```
2. Check the import is BEFORE your custom CSS
3. Ensure you're importing from the correct path (`/dist/index.css`)
4. Clear your build cache and restart dev server:
   ```bash
   rm -rf node_modules/.vite  # For Vite
   rm -rf .next                # For Next.js
   npm start                   # Restart
   ```

### Fonts Not Displaying

**Problem:** Text appears in Arial instead of Haffer font.

**Solution:**
- Haffer font is included in `@sikt/sds-core/dist/index.css`
- Verify the CSS file is imported
- Check browser DevTools Network tab to confirm font files are loading
- If behind a firewall, ensure font CDN is not blocked

### Components Not Found / Import Errors

**Problem:** `Cannot find module '@sikt/sds-button'` or similar error.

**Solution:**
1. Verify package is installed:
   ```bash
   npm list @sikt/sds-button
   ```
2. If not installed, install it:
   ```bash
   npm install @sikt/sds-button
   ```
3. Restart your dev server after installing

### TypeScript Errors

**Problem:** TypeScript complains about missing types.

**Solution:**
- All Sikt packages include TypeScript definitions
- If types are missing, ensure you're using the latest version:
  ```bash
  npm update @sikt/sds-core @sikt/sds-button
  ```
- Restart your TypeScript server in your IDE

### Dark Mode Not Working

**Problem:** Dark mode doesn't activate when `data-theme="dark"` is set.

**Solution:**
1. Verify `data-theme` attribute is on the `<html>` element (not `<body>`)
2. Check in browser DevTools that the attribute is present
3. Ensure you're using theme-aware tokens (`--sds-color-layout-surface-1`, not hard-coded colors)
4. Clear browser cache and reload

### Build Errors with CSS

**Problem:** Build fails with CSS-related errors.

**Solution:**
- Ensure your bundler supports CSS imports
- For Vite: CSS is supported by default
- For webpack: Ensure `css-loader` is configured
- For Next.js: CSS imports work out of the box in `_app.tsx` or `layout.tsx`

### Components Look Different Than Storybook

**Problem:** Components don't match Storybook examples.

**Solution:**
1. Verify you're using the latest version:
   ```bash
   npm update @sikt/sds-core @sikt/sds-button
   ```
2. Check if custom CSS is overriding Sikt styles
3. Use browser DevTools to inspect which styles are being applied
4. Ensure Sikt CSS is imported BEFORE custom CSS

### Performance Issues

**Problem:** Large bundle size or slow initial load.

**Solution:**
- Sikt Design System uses tree-shaking - only imported components are bundled
- Import components individually, not the entire package
- Use code splitting for large applications
- Consider lazy-loading components that aren't immediately visible

## Framework Support

Sikt Design System officially supports the following frameworks and environments:

### Fully Supported

| Framework/Tool | Version | Status | Notes |
|----------------|---------|--------|-------|
| React | 16.8+ | ✅ Full support | Hooks required (16.8+) |
| Next.js | 12+ | ✅ Full support | Both App Router and Pages Router |
| Vite | 3+ | ✅ Full support | Recommended for new React projects |
| Create React App | 5+ | ✅ Full support | Legacy, but fully supported |
| TypeScript | 4+ | ✅ Full support | Type definitions included |

### Experimental/Community Support

| Framework/Tool | Status | Notes |
|----------------|--------|-------|
| Vue.js | ⚠️ Experimental | Community packages available, not officially maintained |
| Svelte | ⚠️ Experimental | Community wrappers exist, test thoroughly |
| Angular | ⚠️ Experimental | Web components approach recommended |
| Remix | ⚠️ Experimental | Should work like standard React, not extensively tested |
| Astro | ⚠️ Experimental | React integration should work, verify SSR behavior |

### Not Supported

| Framework/Tool | Status | Notes |
|----------------|--------|-------|
| React Native | ❌ Not supported | Design system is web-only, tokens not compatible |
| Electron | ⚠️ Limited | Web views work, but desktop-specific features not optimized |

### Browser Support

| Browser | Version | Status |
|---------|---------|--------|
| Chrome | Last 2 versions | ✅ Fully supported |
| Firefox | Last 2 versions | ✅ Fully supported |
| Safari | Last 2 versions | ✅ Fully supported |
| Edge | Last 2 versions | ✅ Fully supported |
| IE 11 | - | ❌ Not supported |

**Accessibility:** All components tested with:
- NVDA (Windows)
- VoiceOver (macOS/iOS)
- TalkBack (Android)
- JAWS (Windows)

## Best Practices

**Visual Identity:**
- Purple is used as a subtle accent color throughout the design
- Surface tokens provide theme-aware backgrounds that adapt to light/dark mode
- Strong purple for primary actions (buttons) and interactive elements
- Use support colors for specific feedback states (success, error, warning)
- Maintain logo protection zones
- Never modify logo proportions or colors

**Typography:**
- Left-align text (no justified alignment)
- Max line length: ~90 characters
- Generous line height for Haffer font
- Sentence Case primarily; ALL CAPS only for headers/overlines
- Underlines only for links

**Color:**
- Use semantic tokens for clear intent
- Verify contrast ratios with WebAIM tools
- Consider colorblind accessibility
- Avoid colors with unintended meaning

**Spacing:**
- Use padding tokens for responsive spacing
- Use gap tokens for consistent element spacing
- Design mobile-first, enhance for larger screens
- Leverage border radius consistently

**Components:**
- Use semantic components matching content meaning
- Cards and containers use semantic surface tokens (`var(--sds-color-layout-surface-1)` for primary layer, `var(--sds-color-layout-surface-2)` for elevated content)
- Surface tokens automatically adapt to light/dark themes
- Apply consistent rounded corners (`var(--sds-size-border-radius-small)`)
- Follow layering hierarchy: page-default → surface-1 → surface-2
- Follow accessibility guidelines
- Customize through design tokens
- Test responsive behavior
- Provide clear feedback for user actions
- Handle errors gracefully

## Common Patterns

### Form with Validation
```jsx
<form>
  <TextInput
    label="Email"
    type="email"
    required
    errorMessage="Please enter a valid email"
  />
  <TextArea
    label="Message"
    required
    errorMessage="Message is required"
  />
  <Button type="submit">Send</Button>
</form>
```

### Alert Messages
```jsx
<Alert variant="success">Your changes have been saved.</Alert>
<Alert variant="error">An error occurred. Please try again.</Alert>
<Alert variant="warning">Your session will expire soon.</Alert>
<Alert variant="info">New features are available.</Alert>
```

### Card Layout
```jsx
<Card>
  <Heading level={2}>Card Title</Heading>
  <Paragraph>Card content goes here.</Paragraph>
  <Button>Action</Button>
</Card>
```

### Dialog Pattern
```jsx
<Dialog
  title="Confirm Action"
  open={isOpen}
  onClose={() => setIsOpen(false)}
>
  <Paragraph>Are you sure you want to proceed?</Paragraph>
  <Button onClick={handleConfirm}>Confirm</Button>
  <Button variant="secondary" onClick={() => setIsOpen(false)}>
    Cancel
  </Button>
</Dialog>
```

## Resources

### Documentation References
- **Full documentation**: See `references/` directory for detailed guidelines
- **Component mapping**: Complete Storybook URL mapping available
- **Design tokens**: Comprehensive token reference with examples
- **Accessibility**: WCAG testing methods and checklists

### External Resources
- **Storybook**: https://designsystem.sikt.no/storybook/
- **Design System Site**: https://designsystem.sikt.no/
- **Figma Files**: Available through Sikt organization
- **GitLab Repository**: Component library source code
- **Slack Support**: Community channel for questions

### Related Skills
- **sikt-design-storybook**: Generate component-specific Storybook URLs
- **sikt-design-components**: Detailed component implementation guides

## Notes

- All components are built with accessibility in mind (WCAG 2.1/2.2)
- Components support customization through design tokens
- Design system follows universal design principles
- Documentation is in Norwegian but implementation should support internationalization
- Purple is the strongest brand differentiator - use prominently
- Test all implementations across device breakpoints
- Publish accessibility statements for public websites (uustatus.no)
