---
name: dad-joke-generator
description: This skill should be used when users request dad jokes, want to generate funny puns, need icebreaker jokes, or ask for clean family-friendly humor. It provides access to a large database of dad jokes through APIs and can fetch random jokes or search for jokes about specific topics.
---

# Dad Joke Generator

## Overview

Provide users with access to thousands of dad jokes from various online sources. Fetch random dad jokes or search for jokes containing specific keywords. All jokes are clean, family-friendly, and perfect for groan-inducing moments.

## Quick Start

When users request dad jokes, choose the appropriate approach:

1. **Random dad joke requested** → Execute `scripts/get_dad_joke.py`
2. **Multiple jokes needed** → Execute `scripts/get_dad_joke.py --count N`
3. **Topic-specific joke requested** → Execute `scripts/get_dad_joke.py --search "topic"`
4. **User wants to know about sources** → Reference `references/dad_joke_sources.md`

## Fetching Random Dad Jokes

To provide a random dad joke from the icanhazdadjoke.com database:

```bash
python3 scripts/get_dad_joke.py
```

**When to use:**
- User asks: "Tell me a dad joke"
- User requests: "Make me laugh"
- User says: "I need a joke"

**Multiple jokes:** Add `--count` parameter to fetch multiple random jokes:

```bash
python3 scripts/get_dad_joke.py --count 5
```

## Searching for Specific Jokes

To find dad jokes about particular topics or containing specific words:

```bash
python3 scripts/get_dad_joke.py --search "computer"
```

**When to use:**
- User asks: "Tell me a joke about dogs"
- User requests: "Dad joke about programming"
- User says: "Funny joke related to pizza"

**Search tips:**
- Use simple, single-word search terms for best results
- Common themes work well: animals, food, technology, professions, sports
- The API returns up to 10 matching jokes by default

## Generating Custom Jokes

When users request dad jokes but the script is unavailable or returns errors, generate dad jokes directly by following these characteristics:

**Dad joke structure:**
- Setup and punchline format
- Pun-based or wordplay humor
- Clean and family-friendly
- Groan-worthy but endearing
- Often involves double meanings or unexpected word associations

**Example patterns:**
- Question and answer format: "Why don't scientists trust atoms?" / "Because they make up everything!"
- Statement with twist: "I used to hate facial hair, but then it grew on me."
- Observational puns: "I'm reading a book about anti-gravity. It's impossible to put down!"

**Quality guidelines:**
- Keep jokes short (1-2 sentences)
- Avoid offensive or controversial topics
- Focus on wholesome, universal humor
- The worse the pun, the better the dad joke
- Embrace the predictable and cheesy

## Dad Joke Sources

For comprehensive information about dad joke APIs, databases, and communities, consult `references/dad_joke_sources.md`. This reference includes:

- Detailed API documentation for multiple dad joke services
- Reddit communities with millions of curated dad jokes
- Comparison of different joke sources
- Selection criteria for APIs
- Characteristics of quality dad jokes

Use this reference when:
- The primary script encounters issues
- Users ask about joke sources or origins
- Alternative APIs are needed
- Understanding dad joke characteristics for generation

## Resources

### scripts/get_dad_joke.py
Executable Python script that fetches dad jokes from icanhazdadjoke.com API. Supports random joke fetching and keyword search. Requires only Python 3 standard library (no external dependencies).

### references/dad_joke_sources.md
Comprehensive documentation of dad joke sources including icanhazdadjoke.com, DadJokes.io, API Ninjas, Reddit's r/dadjokes community, and more. Contains API specifications, usage examples, and dad joke quality characteristics.
