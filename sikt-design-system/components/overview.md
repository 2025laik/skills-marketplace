# Component Library Overview

The Sikt Design System provides **43 production-ready components** organized for consistent product development.

## Component Categories

### Core Components
Basic text and accessibility utilities.

- **Heading** – Text hierarchy element for structuring content
- **Link** – Navigation element for internal and external links
- **Paragraph** – Body text component for readable content
- **Screen Reader Only** – Accessibility utility for screen reader-only content

### Message & Feedback Components
Communicate system status and provide user guidance.

- **Alert** – Notification messaging for important information
- **Application Status** – System state indicator for application-level feedback
- **Error Summary** – Error collection display, typically at top of forms
- **Guide Panel** – Instructional messaging to help users

### Form & Input Components
Collect and validate user input.

- **Checkbox Input** – Multiple selection from options
- **Combobox Input** – Searchable dropdown for large option sets
- **Datepicker Input** – Date selection with calendar interface
- **File Input** – File upload control
- **Radio Input** – Single selection from mutually exclusive options
- **Select Input** – Dropdown selection for moderate option sets
- **Text Area** – Multi-line text entry
- **Text Input** – Single-line text entry
- **Toggle Switch** – Binary toggle control (on/off states)

### Layout & Container Components
Organize and structure content.

- **Badge** – Label indicator for status or category
- **Breadcrumbs** – Navigation path showing page hierarchy
- **Card** – Content container for grouped information
- **Details** – Expandable/collapsible section (disclosure widget)
- **Footer** – Page footer for copyright, links, and meta information
- **Header** – Page header with navigation and branding
- **Logo** – Brand mark component with variants
- **Section** – Content grouping for semantic page structure

### Interactive & Navigation Components
Enable user interaction and navigation.

- **Button** – Action trigger for user interactions
- **Dialog** – Modal overlay for focused tasks or confirmations
- **Filter List** – Filtered content display with search/filter controls
- **List** – Ordered or unordered item lists
- **Pagination** – Page navigation for long content or data sets
- **Popover** – Contextual overlay for supplementary information
- **Tabs** – Tabbed content for organizing related information
- **Table** – Data grid display for structured information
- **Toggle Button** – State-based button (pressed/unpressed)
- **Toggle Segment** – Segmented control for mutually exclusive options
- **Progress Indicator** – Task progress visualization

## Storybook Documentation

All components are documented in **Storybook** with:
- Interactive examples
- Props/API documentation
- Usage guidelines
- Accessibility notes
- Code examples

### Storybook URL Pattern

Components follow this URL pattern:
```
https://designsystem.sikt.no/storybook/?path=/docs/components-{component-name}--docs
```

**Examples:**
- Button: `?path=/docs/components-button--docs`
- Header: `?path=/docs/components-header-readme--docs`
- Email Input: `?path=/docs/components-input-email--docs`

## Component Usage Principles

### Consistency
Use components as designed to maintain visual and behavioral consistency across products.

### Accessibility
All components are built with accessibility in mind, following WCAG 2.1/2.2 guidelines.

### Customization
Components support customization through:
- Design tokens (colors, spacing, typography)
- Props/attributes for behavior
- CSS custom properties for styling

### Composition
Components can be composed together to create complex interfaces while maintaining consistency.

## Implementation

### Integration Methods
- **React Components**: Available via npm package
- **Web Components**: Standard HTML custom elements
- **Direct HTML/CSS**: For non-JavaScript implementations

### Development Resources
- **GitLab**: Component library source code
- **Figma**: Design files and component specifications
- **Storybook**: Interactive documentation and examples
- **Slack**: Community support and questions

## Component Implementation Skills

The Sikt Design System component implementations are organized into focused skills for easy access:

### Available Component Skills

**Core Interaction:**
- **sikt-design-button** - Button component examples with variants, sizes, and states
- **sikt-design-form** - Form components including TextInput, Checkbox, Radio, Select with validation and Section grouping
- **sikt-design-advanced-inputs** - Advanced input components: Combobox, InputDatepicker, InputFile, Toggle

**Feedback & Messaging:**
- **sikt-design-alert** - Alert and feedback patterns including toasts and status messages
- **sikt-design-badge** - Badge, Message, and Logo components for status indicators and branding
- **sikt-design-progress** - Progress indicators including progress bars, spinners, and step indicators

**Overlays & Navigation:**
- **sikt-design-dialog** - Dialog and modal patterns for confirmations and forms
- **sikt-design-drawer** - Drawer and side panel components for navigation and filters
- **sikt-design-popover** - Popover and tooltip components for contextual information
- **sikt-design-navigation** - Navigation components including Tabs, Breadcrumbs, and menus

**Data Display:**
- **sikt-design-table** - Table components with sorting, pagination, and selection
- **sikt-design-list** - List components including FilterList for data display
- **sikt-design-search-filter** - Search and filter patterns for data lists

**Layout & Structure:**
- **sikt-design-layout** - Layout patterns including Header, Footer, Card, Section, and grid systems
- **sikt-design-accordion** - Accordion and collapsible content components

**Visual Elements:**
- **sikt-design-icons** - Icon usage with accessibility patterns and component integration

Each skill provides:
- Ready-to-use code examples
- Installation instructions
- npm package references
- Accessibility best practices
- Storybook documentation links

## Best Practices

1. **Use semantic components** - Choose components that match the semantic meaning of your content
2. **Follow accessibility guidelines** - Ensure proper labels, ARIA attributes, and keyboard navigation
3. **Leverage design tokens** - Use tokens for customization to maintain consistency
4. **Test responsive behavior** - Verify components work across all breakpoints
5. **Provide feedback** - User actions should have clear visual feedback
6. **Handle errors gracefully** - Show clear, actionable error messages
7. **Keep it simple** - Don't over-complicate interfaces with unnecessary components
