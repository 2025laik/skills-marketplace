#!/bin/bash

# new-plugin.sh - Create a new Claude skill
# This script follows the guidelines from skill-creator/

set -e

show_help() {
    cat << EOF
Create a new Claude skill following skill-creator guidelines

Usage:
    ./new-plugin.sh <skill-name> --path <path>

Arguments:
    skill-name          Name in kebab-case (e.g., aws-s3-basics)
    --path              Directory where skill should be created (required)

Options:
    -h, --help          Show this help message

Examples:
    ./new-plugin.sh my-new-skill --path skills/
    ./new-plugin.sh aws-s3-basics --path skills/

Structure:
    Each skill includes:
    - SKILL.md with YAML frontmatter and comprehensive TODO guidance
    - Example files in scripts/, references/, and assets/ directories
    - All directories created by default (delete unused ones as needed)

EOF
}

create_skill_md() {
    local name="$1"
    local filepath="$2"
    # Convert kebab-case to Title Case
    local title=$(echo "$name" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1')

    cat > "$filepath" << 'SKILLEOF'
---
name: SKILL_NAME
description: [TODO: Complete and informative explanation of what the skill does and when to use it. Include WHEN to use this skill - specific scenarios, file types, or tasks that trigger it.]
---

# SKILL_TITLE

## Overview

[TODO: 1-2 sentences explaining what this skill enables]

## Structuring This Skill

[TODO: Choose the structure that best fits this skill's purpose. Common patterns:

**1. Workflow-Based** (best for sequential processes)
- Works well when there are clear step-by-step procedures
- Example: DOCX skill with "Workflow Decision Tree" → "Reading" → "Creating" → "Editing"
- Structure: ## Overview → ## Workflow Decision Tree → ## Step 1 → ## Step 2...

**2. Task-Based** (best for tool collections)
- Works well when the skill offers different operations/capabilities
- Example: PDF skill with "Quick Start" → "Merge PDFs" → "Split PDFs" → "Extract Text"
- Structure: ## Overview → ## Quick Start → ## Task Category 1 → ## Task Category 2...

**3. Reference/Guidelines** (best for standards or specifications)
- Works well for brand guidelines, coding standards, or requirements
- Example: Brand styling with "Brand Guidelines" → "Colors" → "Typography" → "Features"
- Structure: ## Overview → ## Guidelines → ## Specifications → ## Usage...

**4. Capabilities-Based** (best for integrated systems)
- Works well when the skill provides multiple interrelated features
- Example: Product Management with "Core Capabilities" → numbered capability list
- Structure: ## Overview → ## Core Capabilities → ### 1. Feature → ### 2. Feature...

Patterns can be mixed and matched as needed. Most skills combine patterns (e.g., start with task-based, add workflow for complex operations).

Delete this entire "Structuring This Skill" section when done - it's just guidance.]

## [TODO: Replace with the first main section based on chosen structure]

[TODO: Add content here. See examples in existing skills:
- Code samples for technical skills
- Decision trees for complex workflows
- Concrete examples with realistic user requests
- References to scripts/templates/references as needed]

## Resources

This skill includes example resource directories that demonstrate how to organize different types of bundled resources:

### scripts/
Executable code (Python/Bash/etc.) that can be run directly to perform specific operations.

**Examples from other skills:**
- PDF skill: `fill_fillable_fields.py`, `extract_form_field_info.py` - utilities for PDF manipulation
- DOCX skill: `document.py`, `utilities.py` - Python modules for document processing

**Appropriate for:** Python scripts, shell scripts, or any executable code that performs automation, data processing, or specific operations.

**Note:** Scripts may be executed without loading into context, but can still be read by Claude for patching or environment adjustments.

### references/
Documentation and reference material intended to be loaded into context to inform Claude's process and thinking.

**Examples from other skills:**
- Product management: `communication.md`, `context_building.md` - detailed workflow guides
- BigQuery: API reference documentation and query examples
- Finance: Schema documentation, company policies

**Appropriate for:** In-depth documentation, API references, database schemas, comprehensive guides, or any detailed information that Claude should reference while working.

### assets/
Files not intended to be loaded into context, but rather used within the output Claude produces.

**Examples from other skills:**
- Brand styling: PowerPoint template files (.pptx), logo files
- Frontend builder: HTML/React boilerplate project directories
- Typography: Font files (.ttf, .woff2)

**Appropriate for:** Templates, boilerplate code, document templates, images, icons, fonts, or any files meant to be copied or used in the final output.

---

**Any unneeded directories can be deleted.** Not every skill requires all three types of resources.
SKILLEOF

    # Replace placeholders
    sed -i '' "s/SKILL_NAME/$name/g" "$filepath"
    sed -i '' "s/SKILL_TITLE/$title/g" "$filepath"
}

# Parse arguments
SKILL_NAME=""
OUTPUT_PATH=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        --path)
            OUTPUT_PATH="$2"
            shift 2
            ;;
        -*)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
        *)
            if [ -z "$SKILL_NAME" ]; then
                SKILL_NAME="$1"
            else
                echo "Unexpected argument: $1"
                show_help
                exit 1
            fi
            shift
            ;;
    esac
done

# Validate inputs
if [ -z "$SKILL_NAME" ]; then
    echo "Error: skill-name is required"
    show_help
    exit 1
fi

if [ -z "$OUTPUT_PATH" ]; then
    echo "Error: --path is required"
    show_help
    exit 1
fi

# Validate skill name format (kebab-case)
if [[ ! "$SKILL_NAME" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
    echo "Error: skill-name must be in kebab-case (lowercase letters, numbers, hyphens only)"
    exit 1
fi

SKILL_DIR="$OUTPUT_PATH/$SKILL_NAME"

# Check if skill already exists
if [ -d "$SKILL_DIR" ]; then
    echo "Error: Skill '$SKILL_NAME' already exists at $SKILL_DIR"
    exit 1
fi

# Create skill directory
echo "Creating skill: $SKILL_NAME"
mkdir -p "$SKILL_DIR"

# Create SKILL.md
echo "Creating SKILL.md..."
create_skill_md "$SKILL_NAME" "$SKILL_DIR/SKILL.md"

# Always create all resource directories with example files
echo "Creating scripts/ directory with example..."
mkdir -p "$SKILL_DIR/scripts"
cat > "$SKILL_DIR/scripts/example.py" << 'EOF'
#!/usr/bin/env python3
"""
Example helper script for SKILL_NAME

This is a placeholder script that can be executed directly.
Replace with actual implementation or delete if not needed.

Example real scripts from other skills:
- pdf/scripts/fill_fillable_fields.py - Fills PDF form fields
- pdf/scripts/convert_pdf_to_images.py - Converts PDF pages to images
"""

def main():
    print("This is an example script for SKILL_NAME")
    # TODO: Add actual script logic here
    # This could be data processing, file conversion, API calls, etc.

if __name__ == "__main__":
    main()
EOF
sed -i '' "s/SKILL_NAME/$SKILL_NAME/g" "$SKILL_DIR/scripts/example.py"
chmod +x "$SKILL_DIR/scripts/example.py"

echo "Creating references/ directory with example..."
mkdir -p "$SKILL_DIR/references"
cat > "$SKILL_DIR/references/api_reference.md" << 'EOF'
# Reference Documentation for SKILL_TITLE

This is a placeholder for detailed reference documentation.
Replace with actual reference content or delete if not needed.

Example real reference docs from other skills:
- product-management/references/communication.md - Comprehensive guide for status updates
- product-management/references/context_building.md - Deep-dive on gathering context
- bigquery/references/ - API references and query examples

## When Reference Docs Are Useful

Reference docs are ideal for:
- Comprehensive API documentation
- Detailed workflow guides
- Complex multi-step processes
- Information too lengthy for main SKILL.md
- Content that's only needed for specific use cases

## Structure Suggestions

### API Reference Example
- Overview
- Authentication
- Endpoints with examples
- Error codes
- Rate limits

### Workflow Guide Example
- Prerequisites
- Step-by-step instructions
- Common patterns
- Troubleshooting
- Best practices
EOF
# Convert kebab-case to Title Case
title=$(echo "$SKILL_NAME" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1')
sed -i '' "s/SKILL_TITLE/$title/g" "$SKILL_DIR/references/api_reference.md"

echo "Creating assets/ directory with example..."
mkdir -p "$SKILL_DIR/assets"
cat > "$SKILL_DIR/assets/example_asset.txt" << 'EOF'
# Example Asset File

This placeholder represents where asset files would be stored.
Replace with actual asset files (templates, images, fonts, etc.) or delete if not needed.

Asset files are NOT intended to be loaded into context, but rather used within
the output Claude produces.

Example asset files from other skills:
- Brand guidelines: logo.png, slides_template.pptx
- Frontend builder: hello-world/ directory with HTML/React boilerplate
- Typography: custom-font.ttf, font-family.woff2
- Data: sample_data.csv, test_dataset.json

## Common Asset Types

- Templates: .pptx, .docx, boilerplate directories
- Images: .png, .jpg, .svg, .gif
- Fonts: .ttf, .otf, .woff, .woff2
- Boilerplate code: Project directories, starter files
- Icons: .ico, .svg
- Data files: .csv, .json, .xml, .yaml

Note: This is a text placeholder. Actual assets can be any file type.
EOF

echo ""
echo "Skill created successfully at: $SKILL_DIR"
echo ""
echo "Next steps:"
echo "1. Edit $SKILL_DIR/SKILL.md to complete the TODO items and update the description"
echo "2. Customize or delete the example files in scripts/, references/, and assets/"
echo "3. Run the validator when ready to check the skill structure"
echo ""
