# Accessibility Guidelines & WCAG Compliance

## Universal Design Philosophy

Sikt follows universal design principles, ensuring:

> "All shall be able to use Sikt's solutions, regardless of functional ability."

This involves designing products accessible to people with:
- Vision disabilities
- Hearing disabilities
- Mobility disabilities
- Cognitive disabilities

## WCAG Compliance Requirements

### Legal Framework

**Private Organizations:**
- Must comply with 35 requirements from WCAG 2.0

**Public Organizations:**
- Must comply with 49 of 50 requirements from WCAG 2.1 (Level A and AA)

**New Solutions:**
- Developed according to WCAG 2.2 standards

### Required Documentation

Public websites and apps must publish accessibility statements on **uustatus.no**, documenting:
- Compliance status
- Known issues
- Remediation plans

## Key Testing Methods

### 1. Keyboard Navigation
**What to test:**
- All functionality works without a mouse
- Focus visibility is clear
- Tab order is logical
- No keyboard traps exist

**Tools:** Manual testing with Tab, Enter, Space, Arrow keys

### 2. Heading Structure
**What to test:**
- Single H1 per page
- Hierarchical structure (no skipped levels)
- Proper landmarks

**Tools:** HeadingsMap browser extension

### 3. Zoom Testing
**Requirements:**
- Responsive at 400% zoom
- Text enlargement at 200%
- No horizontal scrolling
- All content remains accessible

**How:** Browser zoom settings, OS text size controls

### 4. Image Alternative Text
**Requirements:**
- Informative images have descriptive alt text
- Decorative images have empty alt (`alt=""`)
- Alt text conveys meaning, not just description

**Testing:** Screen reader, browser inspection tools

### 5. Color Contrast
**Requirements:**
- **WCAG 1.4.3 (Minimum)**: 4.5:1 for normal text, 3:1 for large text
- **WCAG 1.4.6 (Enhanced)**: 7:1 for normal text, 4.5:1 for large text

**Tools:**
- WebAIM Contrast Checker
- Browser DevTools
- Axe DevTools

### 6. Automated Tools
**Coverage:** Approximately 20-30% of accessibility issues

**Recommended Tools:**
- **Axe DevTools**: Comprehensive automated testing
- **WAVE**: Visual feedback browser extension
- **Arc Toolkit**: Testing and reporting

### 7. Screen Reader Testing
**Recommended Screen Readers:**
- **Windows**: NVDA (free)
- **macOS/iOS**: VoiceOver (built-in)
- **Android**: TalkBack (built-in)

**What to test:**
- All content is announced
- Interactive elements are properly labeled
- Navigation is logical
- Dynamic content updates are announced

## Common Accessibility Issues

### Critical Issues
- Missing alt text on informative images
- Insufficient color contrast
- No keyboard access to interactive elements
- Missing form labels
- Improper heading hierarchy

### Important Issues
- Missing skip links
- No focus indicators
- Inaccessible custom controls
- Time-limited content without controls
- Auto-playing media

### Enhancement Opportunities
- Descriptive link text (avoid "click here")
- Visible focus indicators (not just browser default)
- Consistent navigation patterns
- Clear error messages
- Multiple ways to find content

## Support Resources

### Internal Support
Sikt maintains a professional network for universal design, offering:
- Guidance on accessibility requirements
- Testing assistance
- Expert consultation

**Contact:** Specialist Eivind Riise

### External Resources
- **WCAG Guidelines**: w3.org/WAI/WCAG21/quickref/
- **WebAIM**: webaim.org
- **UU-status (Norway)**: uustatus.no
- **Difi's Accessibility Directive**: uu.difi.no

## Accessibility Checklist

Before launch, verify:
- [ ] Keyboard navigation works completely
- [ ] Proper heading hierarchy
- [ ] Alt text on all informative images
- [ ] Color contrast meets WCAG AA minimums
- [ ] Forms have proper labels and error handling
- [ ] Screen reader testing completed
- [ ] Automated tools show no errors
- [ ] Zoom testing at 200% and 400%
- [ ] Accessibility statement published (if required)
- [ ] Known issues documented and prioritized

## Best Practices

1. **Design with accessibility from the start** - retrofitting is harder
2. **Use semantic HTML** - proper elements provide built-in accessibility
3. **Test early and often** - don't wait until launch
4. **Involve users with disabilities** - real user testing is invaluable
5. **Stay updated on standards** - WCAG evolves over time
6. **Document decisions** - explain accessibility choices
7. **Train the team** - everyone should understand basics
