#!/usr/bin/env python3
"""
Compile Lilypond (.ly) files to PDF or PNG format

This script provides a reliable wrapper around the lilypond command with:
- Installation checking
- Clear error messages
- Output format options
- Resolution control for PNG output
"""

import argparse
import os
import subprocess
import sys
from pathlib import Path

def check_lilypond_installed():
    """Check if lilypond is installed and accessible."""
    try:
        result = subprocess.run(
            ['lilypond', '--version'],
            capture_output=True,
            text=True,
            check=True
        )
        version = result.stdout.split('\n')[0]
        return True, version
    except FileNotFoundError:
        return False, "Lilypond not found. Install from https://lilypond.org/download.html"
    except subprocess.CalledProcessError as e:
        return False, f"Error checking Lilypond version: {e}"

def compile_lilypond(input_file, output_format='pdf', output_dir=None, resolution=300):
    """
    Compile a Lilypond file to the specified format.

    Args:
        input_file: Path to .ly file
        output_format: 'pdf' or 'png'
        output_dir: Output directory (default: same as input file)
        resolution: DPI for PNG output (default: 300)

    Returns:
        tuple: (success: bool, message: str)
    """
    input_path = Path(input_file)

    if not input_path.exists():
        return False, f"Input file not found: {input_file}"

    if input_path.suffix != '.ly':
        return False, f"Input file must have .ly extension, got: {input_path.suffix}"

    # Build lilypond command
    cmd = ['lilypond']

    # Set output directory
    if output_dir:
        output_path = Path(output_dir)
        output_path.mkdir(parents=True, exist_ok=True)
        cmd.extend(['-o', str(output_path / input_path.stem)])
    else:
        cmd.extend(['-o', str(input_path.parent / input_path.stem)])

    # Set format-specific options
    if output_format == 'png':
        cmd.extend(['--png', f'-dresolution={resolution}'])

    cmd.append(str(input_path))

    # Execute compilation
    try:
        result = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            check=True
        )

        output_file = f"{input_path.stem}.{output_format}"
        return True, f"Successfully compiled to {output_file}\n{result.stdout}"

    except subprocess.CalledProcessError as e:
        error_msg = f"Compilation failed:\n{e.stderr}"
        return False, error_msg

def main():
    parser = argparse.ArgumentParser(
        description='Compile Lilypond files to PDF or PNG',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s score.ly
  %(prog)s score.ly --format png
  %(prog)s score.ly --format png --resolution 600
  %(prog)s score.ly --output-dir ./output
        """
    )

    parser.add_argument('input_file', help='Input .ly file')
    parser.add_argument(
        '--format',
        choices=['pdf', 'png'],
        default='pdf',
        help='Output format (default: pdf)'
    )
    parser.add_argument(
        '--output-dir',
        help='Output directory (default: same as input file)'
    )
    parser.add_argument(
        '--resolution',
        type=int,
        default=300,
        help='Resolution in DPI for PNG output (default: 300)'
    )

    args = parser.parse_args()

    # Check if lilypond is installed
    installed, message = check_lilypond_installed()
    if not installed:
        print(f"Error: {message}", file=sys.stderr)
        sys.exit(1)

    print(f"Using {message}")

    # Compile the file
    success, message = compile_lilypond(
        args.input_file,
        output_format=args.format,
        output_dir=args.output_dir,
        resolution=args.resolution
    )

    if success:
        print(message)
        sys.exit(0)
    else:
        print(message, file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
