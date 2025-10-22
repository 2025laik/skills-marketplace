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

### Just Starting?
1. **Choose components** from 43 available options (buttons, forms, cards, etc.)
2. **Apply design tokens** for colors, spacing, and typography
3. **Follow responsive breakpoints**: Mobile (<720px), Tablet (720px), Desktop (1024px)
4. **Test accessibility** using the built-in guidelines

### Need Something Specific?
- **Building a form?** → See Form & Input Components section
- **Creating a layout?** → See Layout & Container Components section
- **Showing feedback?** → See Message & Feedback Components section
- **Need component docs?** → Use the `sikt-design-system/storybook` skill for URLs
- **Need code examples?** → Use the `sikt-design-system/components` skill

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

### "What colors are available?"

**Interactive Colors** (for buttons, links, etc.):
- Primary: `--sds-color-interaction-primary-strong/subtle/transparent`
- Secondary: `--sds-color-interaction-secondary-strong/subtle/transparent`
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

## Best Practices

**Visual Identity:**
- Purple should dominate compositions
- Use support colors sparingly for accents
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
