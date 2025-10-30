---
name: lichess-player-lookup
description: This skill should be used when users need to look up Lichess.org chess player information, specifically their ratings in bullet, blitz, and rapid time controls. Use when users ask about a player's rating, profile, or performance on Lichess.
---

# Lichess Player Lookup

## Overview

This skill enables looking up chess players on Lichess.org and retrieving their ratings across different time controls (bullet, blitz, rapid). Lichess provides a free public API that returns comprehensive player data without requiring authentication.

## When to Use This Skill

Use this skill when users request:
- A player's rating on Lichess
- Bullet, blitz, or rapid ratings for a specific username
- Player profile information from Lichess.org
- Performance statistics for a Lichess user

## How It Works

Lichess provides a public API endpoint that returns player data in JSON format:

**Endpoint:** `https://lichess.org/api/user/{username}`

The API returns a JSON object where ratings are contained in the `perfs` object with the following structure:

```json
{
  "id": "drnykterstein",
  "username": "DrNykterstein",
  "perfs": {
    "bullet": {
      "games": 9559,
      "rating": 3218,
      "rd": 72,
      "prog": 21
    },
    "blitz": {
      "games": 604,
      "rating": 3131,
      "rd": 151,
      "prog": 22,
      "prov": true
    },
    "rapid": {
      "games": 0,
      "rating": 2500,
      "rd": 150,
      "prog": 0,
      "prov": true
    }
  }
}
```

### Rating Object Fields

Each time control (bullet, blitz, rapid) contains:
- `rating` - Current rating (this is the main value to extract)
- `games` - Number of games played in this time control
- `rd` - Rating deviation (uncertainty measure)
- `prog` - Rating progress (change from previous period)
- `prov` - Provisional status (true if player has played fewer than a certain number of games)

## Workflow

### Step 1: Construct the API URL

Given a username, construct the API URL:
```
https://lichess.org/api/user/{username}
```

**Important notes:**
- Usernames are case-insensitive
- Remove any leading `@` symbol if the user includes it
- No authentication required

### Step 2: Fetch Player Data

Use the WebFetch tool to retrieve player information:

```
WebFetch:
  url: https://lichess.org/api/user/{username}
  prompt: "Extract the username and ratings for bullet, blitz, and rapid time controls from the API response. For each rating, include the rating value, number of games played, and whether it's provisional. Present the information in a clear, user-friendly format."
```

### Step 3: Present Results

Format the results clearly for the user:
- Display the username
- Show bullet, blitz, and rapid ratings
- Include relevant context:
  - Number of games played in each time control
  - Note if a rating is provisional (usually means fewer games played)
  - Indicate if a player has not played games in a specific time control (games: 0)

## Example Usage

### Example 1: Simple Rating Lookup

**User:** "What are Magnus Carlsen's ratings on Lichess? His username is DrNykterstein"

**Action:**
1. Construct URL: `https://lichess.org/api/user/DrNykterstein`
2. Use WebFetch to retrieve data
3. Present ratings:
   ```
   DrNykterstein's Lichess Ratings:
   - Bullet: 3218 (9,559 games)
   - Blitz: 3131 (604 games, provisional)
   - Rapid: 2500 (0 games, provisional)
   ```

### Example 2: User Provides @ Symbol

**User:** "Look up @hikaru on Lichess"

**Action:**
1. Remove `@` symbol from username
2. Construct URL: `https://lichess.org/api/user/hikaru`
3. Fetch and present ratings

## Time Control Definitions

For context when presenting results:
- **Bullet**: Very fast games (typically under 3 minutes total)
- **Blitz**: Fast games (typically 3-10 minutes total)
- **Rapid**: Slower games (typically 10-30 minutes total)

## Error Handling

If a username is not found or the API returns an error:
- Inform the user that the username doesn't exist on Lichess
- Suggest checking the spelling or trying a different username
- Lichess usernames are case-insensitive, so case variations should work

## Rate Limiting

The Lichess API uses rate limiting to ensure responsiveness for everyone:
- Make only one request at a time
- If a 429 status code is received, wait a full minute before making another request
- For this skill's use case (individual player lookups), rate limiting should rarely be encountered

## Additional Information

The API returns much more data than just ratings, including:
- Classical, correspondence, and variant ratings (Chess960, King of the Hill, etc.)
- Online/offline status
- Account creation date
- Profile information
- Playing statistics

Focus on bullet, blitz, and rapid ratings as requested, but be aware that additional data is available if users ask for it.
