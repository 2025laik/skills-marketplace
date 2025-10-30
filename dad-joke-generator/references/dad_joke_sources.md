# Dad Joke Sources and APIs

This reference document contains information about various dad joke sources discovered online, including APIs, databases, and community collections.

## Primary APIs

### 1. icanhazdadjoke.com
**URL:** https://icanhazdadjoke.com/api
**Status:** Free, no API key required
**Features:**
- Fetch random dad jokes
- Search jokes by keyword
- Multiple format support (JSON, plain text, HTML)
- GraphQL support
- Largest collection of dad jokes on the internet

**API Endpoints:**
- Random joke: `GET https://icanhazdadjoke.com/`
- Search: `GET https://icanhazdadjoke.com/search?term={query}&limit={limit}`
- Specific joke by ID: `GET https://icanhazdadjoke.com/j/{joke_id}`

**Headers Required:**
```
Accept: application/json
User-Agent: Your app name (your-url)
```

**Rate Limits:** None specified, but be respectful

### 2. DadJokes.io
**URL:** https://www.dadjokes.io/
**RapidAPI:** https://rapidapi.com/KegenGuyll/api/dad-jokes/details
**Status:** API key required (available on RapidAPI)
**Features:**
- Unlimited supply of dad jokes
- AI-powered jokes using ChatGPT
- Returns setup/punchline/type/id
- Search functionality
- Filter by joke type

**Ranking:** 3rd on Rakuten "top jokes APIs"

### 3. API Ninjas Dad Jokes API
**URL:** https://api-ninjas.com/api/dadjokes
**Status:** API key required
**Features:**
- Thousands of dad jokes
- Free tier: 100 jokes
- Premium tier: 15,000+ jokes
- Simple JSON responses

### 4. JsonGPT Dad Jokes API
**URL:** https://jsongpt.com/api/dad-jokes
**Status:** API integration available
**Features:**
- AI-generated dad jokes
- Described as "the best Dad Jokes API"
- Perfect for applications and websites

## Community Sources

### Reddit's r/dadjokes
**URL:** https://reddit.com/r/dadjokes
**Members:** 6+ million
**Established:** 2011
**Description:** The largest community for dad jokes with daily submissions of groaners and guffaws. Moderators keep content clean and family-friendly.

**Curated Collections:**
- Multiple websites compile the best upvoted jokes from r/dadjokes
- Collections range from 160+ to 2000+ jokes
- Examples: goffaw.com, punnz.com, ponly.com, punsplanet.com

**Characteristics:**
- Clean, witty one-liners
- Community-upvoted quality
- Guaranteed chuckles and groans
- Perfect for all ages

## Other Resources

### GitHub Repositories
- **DadJokes-io/Dad_Jokes_API:** https://github.com/DadJokes-io/Dad_Jokes_API
- **KegenGuyll/DadJokes_API:** https://github.com/KegenGuyll/DadJokes_API

## Selection Criteria for Primary API

The script in this skill uses **icanhazdadjoke.com** as the primary source because:
1. Free and no API key required
2. Largest collection available
3. Simple, well-documented API
4. Reliable and maintained
5. Multiple format support
6. Search functionality
7. No rate limits specified

## Dad Joke Characteristics

Based on community analysis, quality dad jokes typically feature:
- Clean, family-friendly humor
- Puns and wordplay
- One-liner format
- Setup and punchline structure
- Groan-worthy but endearing
- Wholesome content suitable for all ages
- Often involve clever word associations or double meanings

## Usage Guidelines

When generating or presenting dad jokes:
1. Keep them clean and appropriate for all audiences
2. Embrace the "groan factor" - that's what makes them dad jokes
3. Timing and delivery matter in presentation
4. Can be used for icebreakers, light moments, or entertainment
5. Remember: the worse the joke, the better the dad joke
