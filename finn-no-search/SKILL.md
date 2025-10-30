---
name: finn-no-search
description: This skill should be used when users need to search or query Finn.no, Norway's largest online marketplace. Use when users ask to find items for sale, search for jobs, browse real estate listings, look for cars, or query any category on Finn.no. Handles constructing search URLs and retrieving results since Finn.no has no public API.
---

# Finn.no Search

## Overview

This skill enables searching and querying Finn.no, Norway's largest online marketplace and classified ads platform. Finn.no is used by Norwegians to buy and sell second-hand goods, search for jobs, find housing, purchase cars, and access various services. Since Finn.no does not provide a public API, this skill provides guidance on constructing search URLs and using WebFetch to retrieve and parse results.

## When to Use This Skill

Use this skill when users request to:
- Search for items on Finn.no
- Find job listings in Norway
- Browse real estate or housing listings
- Look for cars or vehicles
- Query any category on Finn.no (electronics, furniture, services, etc.)
- Get information about specific Finn.no listings

## Core Search Categories

Finn.no organizes content into several main categories, each with its own search endpoint:

### 1. General Items (Torget)
**Endpoint:** `https://www.finn.no/recommerce/search.html`

Used for general second-hand items including furniture, electronics, clothing, sports equipment, etc.

**Common parameters:**
- `q` - Search query term
- `location` - Location code (e.g., `0.20001` for Oslo)
- `sort` - Sort order (`PUBLISHED_DESC`, `PRICE_ASC`, `PRICE_DESC`)
- `price_from` - Minimum price
- `price_to` - Maximum price

**Example URL:**
```
https://www.finn.no/recommerce/search.html?q=macbook&location=0.20001&sort=PRICE_ASC
```

### 2. Jobs
**Endpoint:** `https://www.finn.no/job/fulltime/search.html`

Used for job listings and employment opportunities.

**Common parameters:**
- `q` - Search query/job title
- `location` - Location code
- `occupation` - Occupation category code (e.g., `0.9999` for all)
- `sector` - Sector/industry filter

**Example URL:**
```
https://www.finn.no/job/fulltime/search.html?q=developer&location=0.20001&occupation=0.9999
```

### 3. Real Estate (Eiendom)
**Endpoint:** `https://www.finn.no/realestate/homes/search.html`

Used for housing, apartments, and property listings.

**Common parameters:**
- `location` - Location code
- `price_from` - Minimum price
- `price_to` - Maximum price
- `area_from` - Minimum square meters
- `area_to` - Maximum square meters
- `property_type` - Property type filter

**Example URL:**
```
https://www.finn.no/realestate/homes/search.html?location=0.20001&price_to=5000000
```

### 4. Cars (Bil)
**Endpoint:** `https://www.finn.no/car/used/search.html`

Used for car and vehicle listings.

**Common parameters:**
- `make` - Car manufacturer code
- `model` - Car model code
- `year_from` - Minimum year
- `year_to` - Maximum year
- `price_from` - Minimum price
- `price_to` - Maximum price
- `mileage_to` - Maximum mileage

**Example URL:**
```
https://www.finn.no/car/used/search.html?make=0.817&year_from=2018&price_to=300000
```

## Search Workflow

### Step 1: Understand the User Request

Identify:
1. What category to search (jobs, real estate, cars, general items)
2. Search terms or filters requested
3. Location preference (if specified)
4. Any price, date, or other constraints

### Step 2: Construct the Search URL

Based on the category and filters:
1. Select the appropriate endpoint
2. Build query parameters
3. URL-encode search terms and special characters
4. Combine into a complete search URL

**Important notes:**
- Use `+` or `%20` for spaces in query parameters
- Location codes: `0.20001` (Oslo), `0.20061` (Bergen), `0.20016` (Trondheim)
- Sort options: `PUBLISHED_DESC` (newest first), `PRICE_ASC` (lowest price), `PRICE_DESC` (highest price)

### Step 3: Fetch and Parse Results

Use WebFetch to retrieve the search results:

```
WebFetch:
  url: [constructed search URL]
  prompt: "Extract and summarize the search results. For each listing, include: title, price, location, and a brief description. Also extract the direct link to each listing if available."
```

### Step 4: Present Results

Format the results clearly for the user:
- List each item with key details (title, price, location)
- Include direct links to listings when available
- Summarize the number of results found
- Suggest refinements if too many/few results

## Common Location Codes

Norwegian cities and regions have numeric location codes:

- **Oslo:** `0.20001`
- **Bergen:** `0.20061`
- **Trondheim:** `0.20016`
- **Stavanger:** `0.20018`
- **Drammen:** `0.20013`
- **Kristiansand:** `0.20015`
- **Tromsø:** `0.20019`

To search nationwide, omit the location parameter or use broader region codes.

## Example Queries

### Example 1: Search for a Laptop
**User:** "Find me a used MacBook in Oslo under 10,000 NOK"

**Action:**
1. Category: General items (Torget)
2. URL: `https://www.finn.no/recommerce/search.html?q=macbook&location=0.20001&price_to=10000&sort=PRICE_ASC`
3. Use WebFetch to retrieve results
4. Present listings with prices and links

### Example 2: Find Developer Jobs
**User:** "Show me developer jobs in Bergen"

**Action:**
1. Category: Jobs
2. URL: `https://www.finn.no/job/fulltime/search.html?q=developer&location=0.20061`
3. Use WebFetch to retrieve job listings
4. Present jobs with titles, companies, and links

### Example 3: Search for Apartments
**User:** "Find apartments in Trondheim under 4 million NOK"

**Action:**
1. Category: Real estate
2. URL: `https://www.finn.no/realestate/homes/search.html?location=0.20016&price_to=4000000`
3. Use WebFetch to retrieve property listings
4. Present properties with prices, sizes, and links

### Example 4: Look for Used Cars
**User:** "Find electric cars in Norway under 200,000 NOK"

**Action:**
1. Category: Cars
2. URL: `https://www.finn.no/car/used/search.html?q=electric&price_to=200000`
3. Use WebFetch to retrieve car listings
4. Present cars with year, mileage, price, and links

## Command-Line Search Script

This skill includes a Node.js script for performing Finn.no searches directly from the command line. The script is located in [scripts/search.js](scripts/search.js).

### Running the Script

```bash
# Basic syntax
node scripts/search.js <category> [options]

# Real estate search example (Byåsen, Trondheim under 10M NOK)
node scripts/search.js realestate --query "Byåsen" --location trondheim --price-to 10000000

# Job search example
node scripts/search.js jobs --query "developer" --location oslo

# Car search example
node scripts/search.js cars --query "electric" --price-to 200000 --sort price_asc

# General items search
node scripts/search.js items --query "macbook" --location bergen --sort price_asc
```

### Script Options

**Categories:**
- `realestate` - Homes and apartments
- `jobs` - Job listings
- `cars` - Vehicles
- `items` - General goods

**Common Options:**
- `--query <text>` - Search query text
- `--location <city>` - City name (oslo, bergen, trondheim, etc.)
- `--price-from <amount>` - Minimum price in NOK
- `--price-to <amount>` - Maximum price in NOK
- `--sort <option>` - Sort by: newest, price_asc, price_desc

**Real Estate Options:**
- `--area-from <m²>` - Minimum area in square meters
- `--area-to <m²>` - Maximum area in square meters

**Car Options:**
- `--year-from <year>` - Minimum year
- `--year-to <year>` - Maximum year
- `--mileage-to <km>` - Maximum mileage

### Script Output

The script outputs:
- Search URL used
- Number of results found
- Top 10 listings with titles, prices, and direct links
- Parsed data that can be used programmatically

## Important Considerations

### Limitations
- Finn.no has no official public API, so all queries rely on web scraping via WebFetch
- Search results may be limited or summarized by WebFetch
- Some detailed filters or advanced search options may not be accessible
- Finn.no may change their URL structure or parameters over time

### Best Practices
- Start with broader searches and refine if needed
- Use location filters to narrow results to relevant geographic areas
- Apply price filters to help users find items within their budget
- Sort by newest first (`PUBLISHED_DESC`) to show fresh listings
- Provide direct links to listings so users can view full details on Finn.no

### Respect and Ethics
- Finn.no is a Norwegian service; respect their terms of service
- Do not overwhelm the service with excessive requests
- Inform users this is web scraping, not an official API integration
- Encourage users to visit Finn.no directly for complete information and to contact sellers
