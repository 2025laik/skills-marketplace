# Design Tokens

Design tokens are the foundational design building blocks of the Sikt Design System, connecting values with easily understood names.

## Purpose

Design tokens standardize design decisions across tools and code, enabling consistency regardless of technology choices. Semantic tokens—those with names indicating usage context—enhance clarity and reusability.

## Implementation

### Figma Integration
Sikt leverages Figma's Variables feature to manage tokens for:
- Dimensions
- Layout
- Color
- Typography

### Organizational Structure

**Collections**: Group related variables by type (colors, spacing, etc.)

**Modes**: Provide context-dependent alternative values:
- Light/dark mode for colors
- Responsive breakpoints for typography
- Device-specific padding values

## Naming Convention

Tokens follow a general-to-specific pattern:

```
--{prefix}-{type}-{category}-{name}-{variant}-{state}
```

**Components:**
- **Prefix**: `sds` (Sikt Design System)
- **Type**: `color`, `space`, `size`, `typography`
- **Category**: `brand`, `interaction`, `feedback`, `text`
- **Name**: `primary`, `secondary`, `tertiary`
- **Variant**: `subtle`, `transparent`, `solid`
- **State**: `default`, `hover`, `active`, `disabled`

### Examples

```css
--sds-color-interaction-primary-transparent-default
--sds-color-text-primary
--sds-space-padding-medium
--sds-size-border-radius-minimal
```

## Token Categories

### Color Tokens
- Brand colors
- Interaction colors (primary, secondary, tertiary)
- Feedback colors (success, error, warning, info)
- Text colors
- Surface colors

### Spacing Tokens
- Padding (responsive, adjusts by device)
- Gap (fixed across all devices)
- Margin

### Size Tokens
- Border weight: thin (1px), regular (2px), bold (4px)
- Border radius: minimal (4px) to full (99999px)
- Component dimensions

### Typography Tokens
- Font size
- Font weight
- Line height
- Letter spacing

## Best Practices

1. **Use semantic tokens** when available for clearer intent
2. **Leverage base tokens** as references for custom implementations
3. **Respect responsive modes** to ensure proper scaling
4. **Maintain token hierarchy** for consistent design decisions
