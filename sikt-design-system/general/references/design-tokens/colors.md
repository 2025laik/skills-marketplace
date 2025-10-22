# Color System and Tokens

## Token Structure

The Sikt Design System uses **two token types**:

1. **Semantic tokens** - Named by function/use (e.g., `sds-color-interaction-primary-strong`)
2. **Base tokens** - Core palette foundation referencing color groups: Purple, Blue, Green, Yellow, Red, Neutral

## Semantic Token Naming

Up to four hierarchical levels:
```
--sds-color-{element/function}-{theme}-{variant}-{state}
```

**Examples:**
- `--sds-color-interaction-primary-strong`
- `--sds-color-interaction-primary-strong-hover`
- `--sds-color-support-success-subtle`
- `--sds-color-text-primary`

## Color Categories

### Page Composition
Layout and surface colors for page structure:

```css
--sds-color-layout-page-default      /* Page background */
--sds-color-layout-surface-1         /* Content layer 1 */
--sds-color-layout-surface-2         /* Content layer 2 */
```

### Text Colors
```css
--sds-color-text-primary             /* Primary text */
--sds-color-text-secondary           /* Secondary/muted text */
--sds-color-text-tertiary            /* Tertiary/subtle text */
--sds-color-text-disabled            /* Disabled text */
--sds-color-text-inverse             /* Text on dark backgrounds */
```

### Interactive Components
Three intensity levels with hover and active states:

**Strong Variant** (highest contrast):
```css
--sds-color-interaction-primary-strong
--sds-color-interaction-primary-strong-hover
--sds-color-interaction-primary-strong-active

--sds-color-interaction-secondary-strong
--sds-color-interaction-secondary-strong-hover
--sds-color-interaction-secondary-strong-active

--sds-color-interaction-tertiary-strong
--sds-color-interaction-tertiary-strong-hover
--sds-color-interaction-tertiary-strong-active
```

**Subtle Variant** (medium contrast):
```css
--sds-color-interaction-primary-subtle
--sds-color-interaction-primary-subtle-hover
--sds-color-interaction-primary-subtle-active
```

**Transparent Variant** (low contrast):
```css
--sds-color-interaction-primary-transparent
--sds-color-interaction-primary-transparent-hover
--sds-color-interaction-primary-transparent-active
```

### Status/Feedback Colors
Each status type includes strong and subtle variants:

**Info:**
```css
--sds-color-support-info-strong
--sds-color-support-info-subtle
```

**Success:**
```css
--sds-color-support-success-strong
--sds-color-support-success-subtle
```

**Warning:**
```css
--sds-color-support-warning-strong
--sds-color-support-warning-subtle
```

**Critical/Error:**
```css
--sds-color-support-critical-strong
--sds-color-support-critical-subtle
```

### Category Palette
Designed to work well together for content differentiation without semantic meaning.

**Use cases:**
- Tagging systems
- Information visualization
- Data charts and graphs
- Task differentiation in lists
- Non-semantic color coding

```css
--sds-color-category-1
--sds-color-category-2
--sds-color-category-3
--sds-color-category-4
--sds-color-category-5
--sds-color-category-6
--sds-color-category-7
--sds-color-category-8
```

### Brand Colors
```css
--sds-color-brand-primary            /* Purple (primary brand) */
--sds-color-brand-secondary
--sds-color-brand-accent
```

### Border Colors
```css
--sds-color-border-default
--sds-color-border-subtle
--sds-color-border-strong
--sds-color-border-focus             /* Focus rings */
```

## Base Color Palette

The base tokens reference the official Sikt color palette:

### Primary Palette (Lilla)
- **Sikt lilla 01**: `#6F5D7A` - Main brand purple
- **Sikt lilla 02**: `#B4B0FB` - Medium purple
- **Sikt lilla 03**: `#F3F1FE` - Light purple
- **Sikt Mørk**: `#0F0035` - Dark (nearly black)
- **Sikt Lys**: `#FFFFFF` - Light (white)

### Secondary Palette (Sekundærpalett)

**Rosa (Pink):**
- **Sikt rosa 01**: `#FF78BF`
- **Sikt rosa 02**: `#FFBD54`
- **Sikt rosa 03**: `#FFE0F7`

**Blå (Blue):**
- **Sikt blå 01**: `#3068FF`
- **Sikt blå 02**: `#76A8FF`
- **Sikt blå 03**: `#E1E0FF`

**Grønn (Green):**
- **Sikt grønn 01**: `#13B833`
- **Sikt grønn 02**: `#A3E8BF`
- **Sikt grønn 03**: `#E3F3E8`

**Oransje (Orange):**
- **Sikt oransje 01**: `#FF956E`
- **Sikt oransje 02**: `#FFB6A1`
- **Sikt oransje 03**: `#FFE8E8`

**Gul (Yellow):**
- **Sikt gul 01**: `#FFC630`
- **Sikt gul 02**: `#FFE398`
- **Sikt gul 03**: `#FFF4D7`

## Usage Guidelines

### Status Colors
Status colors (info, success, warning, critical) should remain **within SDS components** for:
- Alert messages
- Form validation feedback
- System notifications
- Application status indicators

**Don't use** status colors for content categorization or general styling.

### Category Colors
Category colors are **better suited for**:
- Data visualization
- Content tagging
- List/table row differentiation
- Non-semantic color coding
- Charts and graphs

**Important**: Category colors should map to the secondary palette colors (rosa, blå, grønn, oransje, gul) to maintain consistency with the Sikt brand identity. The primary purple palette remains reserved for brand identity and primary interactions.

### Interactive Colors
- **Primary**: Main actions, primary buttons, key interactive elements
- **Secondary**: Supporting actions, secondary buttons
- **Tertiary**: Subtle interactions, tertiary actions
- Use **strong** variant for high emphasis
- Use **subtle** variant for medium emphasis
- Use **transparent** variant for low emphasis

### Text Colors
- **Primary**: Main body text, headings
- **Secondary**: Supporting text, labels
- **Tertiary**: De-emphasized text, metadata
- **Inverse**: Text on dark backgrounds
- Always verify contrast ratios meet WCAG requirements

## Dark Mode Support

The color system includes **modes** for light and dark themes:
- Light mode (default)
- Dark mode

Tokens automatically adapt to the active mode, ensuring consistent appearance across themes.

## Best Practices

### Accessibility
1. **Verify contrast ratios**:
   - Normal text: 4.5:1 minimum (WCAG AA)
   - Large text (18pt+): 3:1 minimum (WCAG AA)
   - Enhanced: 7:1 for normal text (WCAG AAA)

2. **Don't rely on color alone**:
   - Add icons to status messages
   - Include text labels with colored indicators
   - Use patterns or textures in charts

3. **Test for colorblindness**:
   - Verify color combinations are distinguishable
   - Use colorblind-safe palettes for data visualization
   - Provide alternative indicators (shape, pattern, label)

### Implementation
1. **Use semantic tokens** when available for clearer intent
2. **Reference base tokens** only for custom implementations
3. **Leverage hover/active states** for interactive feedback
4. **Test in both light and dark modes** if supporting theme switching
5. **Document color choices** with token names for maintainability

### Common Patterns

**Button Colors:**
```css
.button-primary {
  background: var(--sds-color-interaction-primary-strong);
  color: var(--sds-color-text-inverse);
}

.button-primary:hover {
  background: var(--sds-color-interaction-primary-strong-hover);
}

.button-primary:active {
  background: var(--sds-color-interaction-primary-strong-active);
}
```

**Alert Messages:**
```css
.alert-success {
  background: var(--sds-color-support-success-subtle);
  border: 1px solid var(--sds-color-support-success-strong);
  color: var(--sds-color-text-primary);
}
```

**Form Validation:**
```css
.input-error {
  border-color: var(--sds-color-support-critical-strong);
}

.input-error-message {
  color: var(--sds-color-support-critical-strong);
}
```

**Category Tags:**
```css
.tag-1 { background: var(--sds-color-category-1); }
.tag-2 { background: var(--sds-color-category-2); }
.tag-3 { background: var(--sds-color-category-3); }
```

## Migration and Compatibility

When updating from legacy color values:
1. Identify the semantic purpose of each color
2. Map to appropriate semantic tokens
3. Test contrast ratios
4. Verify hover/active states
5. Check dark mode appearance
6. Update documentation

## Resources

- **WebAIM Contrast Checker**: https://webaim.org/resources/contrastchecker/
- **Figma Variables**: Access token values in Figma design files
- **Storybook**: View colors in component examples
- **GitLab**: Token definitions in source code
