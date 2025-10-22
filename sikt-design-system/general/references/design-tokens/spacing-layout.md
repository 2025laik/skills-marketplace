# Spacing, Layout & Breakpoints

## Spacing System

### Base Tokens
Foundation sizes ranging from 2px to 192px, used as references for semantic tokens.

**Scale:**
- `xxxs`: 2px
- `xxs`: 4px
- `xs`: 8px
- `s`: 12px
- `m`: 16px
- `l`: 24px
- `xl`: 32px
- `xxl`: 48px
- Further increments up to 192px

### Padding Tokens
Responsive values that adjust by device, ensuring appropriate spacing on different screen sizes.

**Example:** Medium padding
- Mobile: 12px
- Tablet: 16px
- Desktop: 24px

### Gap Tokens
Fixed spacing between elements across all devices (4px to 48px), maintaining visual rhythm independent of screen size.

**Available values:**
- 4px, 8px, 12px, 16px, 20px, 24px, 32px, 40px, 48px

## Border System

### Border Weight
- **Thin**: 1px
- **Regular**: 2px
- **Bold**: 4px

### Border Radius
- **Minimal**: 4px
- **Small**: 8px
- **Medium**: 12px
- **Large**: 16px
- **Extra Large**: 24px
- **Full**: 99999px (fully rounded)

## Responsive Breakpoints

The system supports four device categories with defined breakpoints.

| Device | Breakpoint | Usage |
|--------|------------|-------|
| Mobile | < 720px | Default, mobile-first approach |
| Tablet | 720px | Transition to tablet layouts |
| Desktop | 1024px | Full desktop experience |
| Ultrawide | 1440px | Enhanced layouts for large screens |

These breakpoints define when the interface switches between different sizes and devices.

## Token Examples

### Spacing Tokens
```css
/* Padding (responsive) */
--sds-space-padding-small
--sds-space-padding-medium
--sds-space-padding-large

/* Gap (fixed) */
--sds-space-gap-4
--sds-space-gap-8
--sds-space-gap-16
--sds-space-gap-24
```

### Border Tokens
```css
/* Border weight */
--sds-size-border-thin
--sds-size-border-regular
--sds-size-border-bold

/* Border radius */
--sds-size-border-radius-minimal
--sds-size-border-radius-small
--sds-size-border-radius-medium
--sds-size-border-radius-full
```

## Best Practices

1. **Use padding tokens** for spacing that should adapt to screen size
2. **Use gap tokens** for consistent element spacing
3. **Design mobile-first**, then enhance for larger screens
4. **Test at all breakpoints** to ensure proper responsive behavior
5. **Leverage border radius** consistently for visual harmony
