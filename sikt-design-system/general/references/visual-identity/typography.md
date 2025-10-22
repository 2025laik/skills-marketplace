# Typography System

## Font Families

### Primary: Haffer
Haffer is Sikt's standard typeface, designed by Czech foundry Displaay. It combines tight lines with character that delivers both professionalism and approachability.

**Available Weights:**
- Haffer Bold (700)
- Haffer Semibold (600)
- Haffer Regular (400)

### Fallback: Arial
Arial serves as the replacement font when Haffer isn't practical, as it's available system-wide on Windows and macOS.

## Product Development Typography

The typography system employs design tokens for four attributes:
- Font size
- Font weight
- Line height
- Letter spacing

### Semantic Token Categories

The system provides semantic tokens for four content types:
- Headlines (Editorial and Application packages)
- Body text
- Labels
- Overlines

## Headline Packages

### Editorial
Features high size contrast between largest and smallest headings, suited for most interfaces. Allows emphasis flexibility through varied hierarchy levels.

**Best for:**
- Marketing pages
- Content-heavy applications
- Editorial interfaces
- Documentation sites

### Application
Designed for information-dense products with compact layouts. Smaller maximum sizes and reduced contrast between hierarchy steps.

**Best for:**
- Complex applications
- Dense data interfaces
- Admin panels
- Tools with limited vertical space

Both packages scale responsively across mobile, tablet, and desktop viewports using modes.

## Usage Principles

### Core Philosophy
Typography equals "design for reading" (design for lesing). The goal centers on making text readable and comprehensible while projecting organizational professionalism.

### Hierarchy Considerations
- Establish appropriate heading levels to aid reader navigation
- Ensure substantial visual differentiation between hierarchy levels
- Avoid excessive hierarchy (5-6 levels typically exceed necessity)
- Teams can skip headline levels to strengthen hierarchy as needed

## Composition Best Practices

### Line Height
Haffer requires generous spacing compared to other typefaces.

### Paragraph Breaks
Prefer whitespace over indentation for digital products.

### Line Length
Target approximately 90 characters maximum. Sikt wraps content between 700–900 pixels.

### Alignment
Left-align text exclusively. Avoid justified alignment in digital contexts.

### Case
- **Sentence Case**: Use primarily
- **ALL CAPS**: Restrict to column headers and overline headings

### Underlines
Reserve exclusively for links.

### Color
- Default to black or white
- Brand colors acceptable for titles
- Maintain sufficient contrast for accessibility

## Customization

Custom styles are permitted provided they use Sikt's base tokens for attributes. The system recommends implementing responsive scaling similar to the Editorial and Application packages.

## Token Examples

```css
/* Headline tokens */
--sds-typography-headline-editorial-h1
--sds-typography-headline-application-h1

/* Body text tokens */
--sds-typography-body-large
--sds-typography-body-medium
--sds-typography-body-small

/* Label tokens */
--sds-typography-label-large
--sds-typography-label-medium

/* Overline tokens */
--sds-typography-overline
```
