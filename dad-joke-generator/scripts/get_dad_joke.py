#!/usr/bin/env python3
"""
Fetches dad jokes from icanhazdadjoke.com API

This script provides easy access to a large database of dad jokes.
It can fetch random jokes or search for jokes containing specific terms.

Usage:
    # Get a random dad joke
    python3 get_dad_joke.py

    # Search for jokes containing a specific term
    python3 get_dad_joke.py --search "computer"

    # Get multiple random jokes
    python3 get_dad_joke.py --count 5
"""

import sys
import argparse
import json

try:
    import urllib.request
except ImportError:
    print("Error: urllib is required but not available", file=sys.stderr)
    sys.exit(1)


def fetch_random_joke():
    """Fetch a random dad joke from icanhazdadjoke.com"""
    url = "https://icanhazdadjoke.com/"
    headers = {
        "Accept": "application/json",
        "User-Agent": "Claude Code Dad Joke Generator (https://github.com/anthropics/claude-code)"
    }

    try:
        req = urllib.request.Request(url, headers=headers)
        with urllib.request.urlopen(req, timeout=10) as response:
            data = json.loads(response.read().decode())
            return data.get("joke", "No joke found")
    except Exception as e:
        return f"Error fetching joke: {str(e)}"


def search_jokes(search_term, limit=10):
    """Search for dad jokes containing a specific term"""
    url = f"https://icanhazdadjoke.com/search?term={urllib.parse.quote(search_term)}&limit={limit}"
    headers = {
        "Accept": "application/json",
        "User-Agent": "Claude Code Dad Joke Generator (https://github.com/anthropics/claude-code)"
    }

    try:
        req = urllib.request.Request(url, headers=headers)
        with urllib.request.urlopen(req, timeout=10) as response:
            data = json.loads(response.read().decode())
            results = data.get("results", [])

            if not results:
                return f"No jokes found for '{search_term}'"

            jokes = [result.get("joke") for result in results]
            return "\n\n".join(jokes)
    except Exception as e:
        return f"Error searching jokes: {str(e)}"


def main():
    parser = argparse.ArgumentParser(
        description="Fetch dad jokes from icanhazdadjoke.com",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s                          Get a random dad joke
  %(prog)s --search "computer"      Search for jokes about computers
  %(prog)s --count 3                Get 3 random jokes
        """
    )
    parser.add_argument(
        "--search",
        type=str,
        help="Search for jokes containing this term"
    )
    parser.add_argument(
        "--count",
        type=int,
        default=1,
        help="Number of random jokes to fetch (default: 1)"
    )

    args = parser.parse_args()

    if args.search:
        print(search_jokes(args.search, limit=args.count))
    else:
        for i in range(args.count):
            if i > 0:
                print("\n" + "-" * 50 + "\n")
            print(fetch_random_joke())


if __name__ == "__main__":
    main()
