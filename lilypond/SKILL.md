---
name: lilypond
description: This skill enables sheet music engraving using Lilypond. Use this skill when compiling Lilypond (.ly) files to PDF or PNG formats, or when converting music notation from ABC notation or MusicXML to Lilypond format.
---

# Lilypond

## Overview

Lilypond is a text-based music engraving system that produces high-quality sheet music. This skill provides tools and guidance for compiling Lilypond files and converting from other music notation formats.

## When to Use This Skill

Use this skill when:
- Compiling .ly files to PDF or PNG output
- Converting ABC notation to Lilypond format
- Converting MusicXML files to Lilypond format
- Rendering sheet music from Lilypond source files

## Quick Start

### Prerequisites

Ensure Lilypond is installed on the system. Download from: https://lilypond.org/download.html

Verify installation:
```bash
lilypond --version
```

## Compiling Lilypond Files

### Using the Compilation Script

The `scripts/compile_lilypond.py` script provides reliable compilation with error handling and output options.

**Basic compilation to PDF:**
```bash
python3 scripts/compile_lilypond.py score.ly
```

**Compile to PNG format:**
```bash
python3 scripts/compile_lilypond.py score.ly --format png
```

**Specify output directory:**
```bash
python3 scripts/compile_lilypond.py score.ly --output-dir ./output
```

**Control PNG resolution:**
```bash
python3 scripts/compile_lilypond.py score.ly --format png --resolution 600
```

### Direct Lilypond Compilation

For simple cases, use lilypond directly:
```bash
lilypond score.ly           # Produces score.pdf
lilypond --png score.ly     # Produces score.png
```

## Converting from ABC Notation

ABC notation is a text-based music format commonly used for folk and traditional music. Convert to Lilypond using the `abc2ly` tool (included with Lilypond).

**Basic conversion:**
```bash
abc2ly tune.abc -o tune.ly
```

**Common options:**
- `--strict`: Enable strict checking of ABC syntax
- `--beams`: Specify beaming style

**Example ABC notation:**
```abc
X:1
T:Example Tune
M:4/4
K:C
C D E F | G A B c |
```

After conversion, compile the resulting .ly file using the compilation script or lilypond command.

## Converting from MusicXML

MusicXML is an XML-based music notation format used by many scorewriters (Finale, Sibelius, MuseScore). Convert to Lilypond using the `musicxml2ly` tool (included with Lilypond).

**Basic conversion:**
```bash
musicxml2ly score.xml -o score.ly
```

**Common options:**
- `--nd` or `--no-articulation-directions`: Ignore articulation directions from MusicXML
- `--nrp` or `--no-rest-positions`: Ignore rest positions from MusicXML
- `--nsb` or `--no-system-breaks`: Ignore system breaks from MusicXML
- `--npb` or `--no-page-breaks`: Ignore page breaks from MusicXML

**Note:** MusicXML conversion may require manual adjustment of the resulting .ly file, as not all MusicXML features map directly to Lilypond syntax.

## Best Practices

### File Organization

Organize Lilypond projects with clear structure:
```
project/
├── source/          # .ly source files
├── output/          # Generated PDFs/PNGs
└── includes/        # Shared Lilypond includes
```

### Common Lilypond Patterns

**Basic file structure:**
```lilypond
\version "2.24.0"

\header {
  title = "Title"
  composer = "Composer"
}

\score {
  \new Staff {
    \relative c' {
      c4 d e f
      g a b c
    }
  }
  \layout { }
  \midi { }
}
```

**Setting paper size and margins:**
```lilypond
\paper {
  #(set-paper-size "letter")
  left-margin = 1\in
  right-margin = 1\in
}
```

**Multiple voices:**
```lilypond
\new Staff <<
  \new Voice = "first" { \voiceOne ... }
  \new Voice = "second" { \voiceTwo ... }
>>
```

### Debugging Compilation Errors

When compilation fails:
1. Check the error message for line numbers
2. Verify all opening braces have closing braces
3. Ensure version statement matches installed Lilypond version
4. Check for proper quoting of strings and proper escaping
5. Use the `--loglevel=DEBUG` flag for detailed output

### Output Quality

For professional printing, use high-resolution PNG:
```bash
python3 scripts/compile_lilypond.py score.ly --format png --resolution 600
```

For screen display, default 300 DPI is sufficient.
