#!/usr/bin/env python3
"""
Sikt Design System Storybook URL Generator

Fetches and validates actual Storybook documentation URLs.
Usage: python get_storybook_url.py <component_name>
"""

import sys
import urllib.request
import urllib.error
from typing import Optional


BASE_URL = "https://designsystem.sikt.no/storybook/?path=/docs/"

# Suffix patterns to try, in order of preference
SUFFIX_PATTERNS = [
    "readme--docs",  # Most common for main component docs
    "--docs",        # Alternative docs format
    "--readme",      # Another readme variant
]


def to_kebab_case(text: str) -> str:
    """Convert component name to kebab-case."""
    return text.lower().replace(" ", "-")


def build_component_path(component_name: str) -> str:
    """Build the component path portion of the URL."""
    kebab_name = to_kebab_case(component_name)

    # Handle input components - they need "input-" prefix
    input_keywords = ["checkbox", "radio", "select", "combobox", "datepicker",
                      "file", "email", "text", "password", "number", "tel",
                      "search", "textarea"]

    # Check if this is an input component
    if "input" in kebab_name:
        # Already has input in the name, use as-is
        return f"components-{kebab_name}"
    elif any(keyword in kebab_name for keyword in input_keywords):
        # Add input prefix
        # Special case: "text area" becomes "input-textarea" not "input-text-area"
        if kebab_name == "text-area":
            return "components-input-textarea"
        return f"components-input-{kebab_name}"

    # Standard component
    return f"components-{kebab_name}"


def validate_url(url: str) -> bool:
    """Check if a URL returns a valid response."""
    try:
        req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req, timeout=5) as response:
            return response.status == 200
    except (urllib.error.HTTPError, urllib.error.URLError, Exception):
        return False


def get_storybook_url(component_name: str, validate: bool = True) -> Optional[str]:
    """
    Get the Storybook documentation URL for a component.

    Args:
        component_name: The component name (e.g., "Button", "Email Input", "Text Area")
        validate: If True, validates that the URL actually exists

    Returns:
        Full Storybook documentation URL, or None if not found
    """
    component_path = build_component_path(component_name)

    # Try each suffix pattern
    for suffix in SUFFIX_PATTERNS:
        url = f"{BASE_URL}{component_path}-{suffix}"

        if not validate:
            return url

        if validate_url(url):
            return url

    return None


def main():
    """CLI interface for getting Storybook URLs."""
    if len(sys.argv) < 2:
        print("Usage: python get_storybook_url.py <component_name>")
        print("\nExamples:")
        print("  python get_storybook_url.py Button")
        print("  python get_storybook_url.py 'Email Input'")
        print("  python get_storybook_url.py 'Text Area'")
        sys.exit(1)

    component_name = " ".join(sys.argv[1:])

    print(f"Searching for: {component_name}")
    url = get_storybook_url(component_name, validate=True)

    if url:
        print(f"✓ Found: {url}")
    else:
        print(f"✗ No documentation found for '{component_name}'")
        print("\nTried patterns:")
        component_path = build_component_path(component_name)
        for suffix in SUFFIX_PATTERNS:
            print(f"  - {BASE_URL}{component_path}-{suffix}")
        sys.exit(1)


if __name__ == "__main__":
    main()
