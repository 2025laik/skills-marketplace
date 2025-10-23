# Color System

## Overview

Sikt uses a two-tier token system: base tokens define the palette, semantic tokens map colors to specific use cases.

## Primary Identity

**Purple palette** is the strongest brand differentiator. Use prominently when Sikt is the main brand. Support colors serve as small accents only.

## Color Token Categories

### Brand Colors (`color-brand-`)
Apply to branding elements and cross-product navigation. Uses primary purple palette with neutral tones.

### Interaction Colors (`color-interaction-`)

**Two palettes:**
- **Primary**: Brand-based purple, strong visual presence
- **Neutral**: Muted gray, for complex interfaces with many interactive elements

**Three intensity levels:**
- **Strong**: High contrast, primary actions
- **Subtle**: Reduced contrast, secondary actions
- **Transparent**: Minimal background, tertiary actions

**Each includes three states:** default, hover, pressed

### Semantic Colors (`color-support-`)
Communicate feedback and status:
- **Info**: Informational messages
- **Success**: Successful operations
- **Warning**: Caution or upcoming issues
- **Critical**: Errors or blocked actions

### Layout Colors
- **Page structure**: Default, secondary, header variants for information-dense pages
- **Component surfaces**: Backgrounds for tables, cards, sections
- **Dividers**: Strong and subtle variants for visual separation
- **Focus**: Blue-based borders for keyboard navigation

### Text Colors
- **Primary**: General text content
- **Secondary**: Lower hierarchy, supporting text
- **Inverse**: Text on strong backgrounds
- **Critical**: Error states
- **High contrast**: Accessibility requirements

## Usage Guidelines

**Color hierarchy:**
- Purple dominates when Sikt is primary brand
- Support colors as small accents only
- Maintain token-based implementation

**Semantic caution:**
- Avoid colors with unintended associations (e.g., orange/green implying good/bad)
- Consider cultural color meanings in data visualization

**Product exceptions:**
- Products with strong established brands may use custom themes
- Must maintain connection to Sikt family through extended color system

**Accessibility:**
- Verify contrast ratios meet WCAG standards (4.5:1 normal text, 3:1 large text)
- Test with colorblind simulation tools
- Use semantic tokens for clear intent

## Token Naming Pattern

```
--sds-color-{category}-{name}-{variant}-{state}
```

**Examples:**
```css
--sds-color-brand-accent-strong
--sds-color-interaction-primary-strong-hover
--sds-color-support-success-subtle
--sds-color-text-primary
```

## References

- **Storybook tokens**: https://designsystem.sikt.no/storybook/?path=/docs/tokens-color--docs
- **Token guide**: https://designsystem.sikt.no/produktutvikling/fargetokens/
- **Visual identity**: https://designsystem.sikt.no/visuell-identitet/fargepalett/
