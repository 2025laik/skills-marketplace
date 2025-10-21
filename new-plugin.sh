#!/bin/bash

# new-plugin.sh - Create a new Claude skill plugin

set -e

show_help() {
    cat << EOF
Create a new Claude skill plugin

Usage:
    ./new-plugin.sh <plugin-name> [options]

Arguments:
    plugin-name         Name in kebab-case (e.g., aws-s3-basics)

Options:
    -d, --description   Plugin description (required)
    -s, --scripts       Create scripts/ directory
    -r, --references    Create references/ directory
    -a, --assets        Create assets/ directory
    -h, --help          Show this help message

Examples:
    ./new-plugin.sh my-new-skill -d "Help with XYZ tasks"
    ./new-plugin.sh aws-s3-basics -d "S3 bucket operations" -s -r

Structure:
    Each plugin requires:
    - SKILL.md with YAML frontmatter (name, description)
    - Optional: scripts/, references/, assets/ directories

    After creation, add the plugin to .claude-plugin/marketplace.json

EOF
}

create_skill_md() {
    local name="$1"
    local description="$2"
    local filepath="$3"

    cat > "$filepath" << EOF
---
name: $name
description: $description
---

# ${name//-/ }

## Overview

[Add overview of what this skill does and when to use it]

## Usage

[Add detailed instructions on how to use this skill]

## Examples

[Add example scenarios and commands]

EOF
}

# Parse arguments
PLUGIN_NAME=""
DESCRIPTION=""
CREATE_SCRIPTS=false
CREATE_REFERENCES=false
CREATE_ASSETS=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -d|--description)
            DESCRIPTION="$2"
            shift 2
            ;;
        -s|--scripts)
            CREATE_SCRIPTS=true
            shift
            ;;
        -r|--references)
            CREATE_REFERENCES=true
            shift
            ;;
        -a|--assets)
            CREATE_ASSETS=true
            shift
            ;;
        -*)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
        *)
            if [ -z "$PLUGIN_NAME" ]; then
                PLUGIN_NAME="$1"
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
if [ -z "$PLUGIN_NAME" ]; then
    echo "Error: plugin-name is required"
    show_help
    exit 1
fi

if [ -z "$DESCRIPTION" ]; then
    echo "Error: description is required (use -d or --description)"
    show_help
    exit 1
fi

# Validate plugin name format (kebab-case)
if [[ ! "$PLUGIN_NAME" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
    echo "Error: plugin-name must be in kebab-case (lowercase letters, numbers, hyphens only)"
    exit 1
fi

PLUGIN_DIR="skills/$PLUGIN_NAME"

# Check if plugin already exists
if [ -d "$PLUGIN_DIR" ]; then
    echo "Error: Plugin '$PLUGIN_NAME' already exists at $PLUGIN_DIR"
    exit 1
fi

# Create plugin directory
echo "Creating plugin: $PLUGIN_NAME"
mkdir -p "$PLUGIN_DIR"

# Create SKILL.md
echo "Creating SKILL.md..."
create_skill_md "$PLUGIN_NAME" "$DESCRIPTION" "$PLUGIN_DIR/SKILL.md"

# Create optional directories
if [ "$CREATE_SCRIPTS" = true ]; then
    echo "Creating scripts/ directory..."
    mkdir -p "$PLUGIN_DIR/scripts"
    cat > "$PLUGIN_DIR/scripts/.gitkeep" << EOF
# Place executable scripts here (Python, Bash, etc.)
# Example: rotate_pdf.py, check_status.sh
EOF
fi

if [ "$CREATE_REFERENCES" = true ]; then
    echo "Creating references/ directory..."
    mkdir -p "$PLUGIN_DIR/references"
    cat > "$PLUGIN_DIR/references/.gitkeep" << EOF
# Place reference documentation here
# Example: api_docs.md, schema.md, policies.md
EOF
fi

if [ "$CREATE_ASSETS" = true ]; then
    echo "Creating assets/ directory..."
    mkdir -p "$PLUGIN_DIR/assets"
    cat > "$PLUGIN_DIR/assets/.gitkeep" << EOF
# Place output assets here (templates, images, etc.)
# Example: logo.png, template.yaml, boilerplate/
EOF
fi

echo ""
echo "Plugin created successfully at: $PLUGIN_DIR"
echo ""
echo "Next steps:"
echo "1. Edit $PLUGIN_DIR/SKILL.md to add instructions"
echo "2. Add plugin entry to .claude-plugin/marketplace.json:"
echo ""
echo "   {\"
echo "     \"name\": \"$PLUGIN_NAME\","
echo "     \"source\": \"./$PLUGIN_DIR\","
echo "     \"description\": \"$DESCRIPTION\""
echo "   }"
echo ""
