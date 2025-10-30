#!/usr/bin/env node

/**
 * Finn.no Search Script
 *
 * A command-line tool to search Finn.no using WebFetch patterns.
 * Supports multiple categories: real estate, jobs, cars, and general items.
 */

const https = require('https');

// Location codes for Norwegian cities
const LOCATIONS = {
  oslo: '0.20001',
  bergen: '0.20061',
  trondheim: '0.20016',
  stavanger: '0.20018',
  drammen: '0.20013',
  kristiansand: '0.20015',
  tromsø: '0.20019',
};

// Search categories and their endpoints
const CATEGORIES = {
  realestate: 'https://www.finn.no/realestate/homes/search.html',
  jobs: 'https://www.finn.no/job/fulltime/search.html',
  cars: 'https://www.finn.no/car/used/search.html',
  items: 'https://www.finn.no/recommerce/search.html',
};

// Sort options
const SORT_OPTIONS = {
  newest: 'PUBLISHED_DESC',
  price_asc: 'PRICE_ASC',
  price_desc: 'PRICE_DESC',
};

/**
 * Build search URL with parameters
 */
function buildSearchURL(category, options = {}) {
  const baseURL = CATEGORIES[category];
  if (!baseURL) {
    throw new Error(`Invalid category: ${category}. Valid options: ${Object.keys(CATEGORIES).join(', ')}`);
  }

  const params = new URLSearchParams();

  // Add search query
  if (options.query) {
    params.append('q', options.query);
  }

  // Add location
  if (options.location) {
    const locationCode = LOCATIONS[options.location.toLowerCase()] || options.location;
    params.append('location', locationCode);
  }

  // Add price filters
  if (options.priceFrom) {
    params.append('price_from', options.priceFrom);
  }
  if (options.priceTo) {
    params.append('price_to', options.priceTo);
  }

  // Add sort order
  if (options.sort) {
    const sortValue = SORT_OPTIONS[options.sort] || options.sort;
    params.append('sort', sortValue);
  }

  // Category-specific parameters
  if (category === 'realestate') {
    if (options.areaFrom) params.append('area_from', options.areaFrom);
    if (options.areaTo) params.append('area_to', options.areaTo);
    if (options.propertyType) params.append('property_type', options.propertyType);
  }

  if (category === 'cars') {
    if (options.yearFrom) params.append('year_from', options.yearFrom);
    if (options.yearTo) params.append('year_to', options.yearTo);
    if (options.mileageTo) params.append('mileage_to', options.mileageTo);
  }

  if (category === 'jobs') {
    if (options.occupation) params.append('occupation', options.occupation);
    if (options.sector) params.append('sector', options.sector);
  }

  const queryString = params.toString();
  return queryString ? `${baseURL}?${queryString}` : baseURL;
}

/**
 * Fetch and parse HTML from URL
 */
function fetchHTML(url) {
  return new Promise((resolve, reject) => {
    https.get(url, (res) => {
      let data = '';

      res.on('data', (chunk) => {
        data += chunk;
      });

      res.on('end', () => {
        resolve(data);
      });
    }).on('error', (err) => {
      reject(err);
    });
  });
}

/**
 * Parse search results from HTML
 */
function parseResults(html, category) {
  const results = [];

  // Extract title
  const titleMatch = html.match(/<title>(.*?)<\/title>/);
  const pageTitle = titleMatch ? titleMatch[1] : 'Finn.no Search Results';

  // Try to find result count from meta description or page content
  const countMatch = html.match(/(\d[\s\d]*)\s+(?:bolig|ledig|treff|annonser|resultater)/i);
  const resultCount = countMatch ? countMatch[1].replace(/\s/g, '') : 'Unknown';

  // Finn.no uses JavaScript-rendered content, so detailed parsing is limited
  // The best approach is to use the URL with WebFetch or visit directly

  return {
    pageTitle,
    resultCount,
    results,
  };
}

/**
 * Main search function
 */
async function search(category, options = {}) {
  try {
    const url = buildSearchURL(category, options);
    console.log(`\nSearching Finn.no: ${url}\n`);

    const html = await fetchHTML(url);
    const parsed = parseResults(html, category);

    console.log(`Category: ${category}`);
    console.log(`Results: ${parsed.resultCount} listings found`);
    console.log(`Page: ${parsed.pageTitle}\n`);

    console.log('Note: Finn.no uses JavaScript-rendered content.');
    console.log('For detailed results with listings, use this URL with:');
    console.log('  - Claude Code\'s WebFetch tool');
    console.log('  - Your web browser');
    console.log('  - Or a headless browser automation tool\n');

    if (parsed.results.length > 0) {
      console.log('Sample Results:\n');
      parsed.results.forEach((result, index) => {
        console.log(`${index + 1}. ${result.title}`);
        console.log(`   Price: ${result.price}`);
        console.log(`   Link: ${result.link}\n`);
      });
    }

    return { url, ...parsed };
  } catch (error) {
    console.error('Error performing search:', error.message);
    process.exit(1);
  }
}

/**
 * CLI Interface
 */
function printUsage() {
  console.log(`
Usage: node search.js <category> [options]

Categories:
  realestate    Search for homes and apartments
  jobs          Search for job listings
  cars          Search for vehicles
  items         Search for general items/goods

Common Options:
  --query <text>        Search query text
  --location <city>     City name or location code (oslo, bergen, trondheim, etc.)
  --price-from <amount> Minimum price in NOK
  --price-to <amount>   Maximum price in NOK
  --sort <option>       Sort by: newest, price_asc, price_desc

Real Estate Options:
  --area-from <m²>      Minimum area in square meters
  --area-to <m²>        Maximum area in square meters

Cars Options:
  --year-from <year>    Minimum year
  --year-to <year>      Maximum year
  --mileage-to <km>     Maximum mileage

Jobs Options:
  --occupation <code>   Occupation category code (e.g., "0.9999" for all)
  --sector <code>       Sector/industry filter code

Examples:
  # Search for houses in Trondheim under 10M NOK
  node search.js realestate --query "Byåsen" --location trondheim --price-to 10000000

  # Search for developer jobs in Oslo
  node search.js jobs --query "developer" --location oslo

  # Search for electric cars under 200k NOK
  node search.js cars --query "electric" --price-to 200000

  # Search for MacBooks in Bergen
  node search.js items --query "macbook" --location bergen --sort price_asc
`);
}

// Parse command line arguments
if (process.argv.length < 3 || process.argv[2] === '--help' || process.argv[2] === '-h') {
  printUsage();
  process.exit(0);
}

const category = process.argv[2];
const options = {};

for (let i = 3; i < process.argv.length; i += 2) {
  const arg = process.argv[i];
  const value = process.argv[i + 1];

  switch (arg) {
    case '--query':
    case '-q':
      options.query = value;
      break;
    case '--location':
    case '-l':
      options.location = value;
      break;
    case '--price-from':
      options.priceFrom = value;
      break;
    case '--price-to':
      options.priceTo = value;
      break;
    case '--sort':
      options.sort = value;
      break;
    case '--area-from':
      options.areaFrom = value;
      break;
    case '--area-to':
      options.areaTo = value;
      break;
    case '--year-from':
      options.yearFrom = value;
      break;
    case '--year-to':
      options.yearTo = value;
      break;
    case '--mileage-to':
      options.mileageTo = value;
      break;
    case '--occupation':
      options.occupation = value;
      break;
    case '--sector':
      options.sector = value;
      break;
  }
}

// Run the search
search(category, options);
