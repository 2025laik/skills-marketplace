#!/bin/bash
# Script to test and measure LogQL query performance
# Usage: ./test_logql_query.sh "<logql-query>" [time-range]

QUERY="$1"
TIME_RANGE="${2:-5m}"

if [ -z "$QUERY" ]; then
    echo "Usage: $0 \"<logql-query>\" [time-range]"
    echo ""
    echo "Examples:"
    echo "  $0 '{app=\"myapp\"}' '1h'"
    echo "  $0 '{app=\"myapp\"} |= \"error\"' '5m'"
    echo "  $0 'rate({app=\"myapp\"}[5m])' '1h'"
    exit 1
fi

echo "=== LogQL Query Performance Test ==="
echo ""
echo "Query: $QUERY"
echo "Time Range: $TIME_RANGE"
echo ""

# Measure query execution time
echo "Executing query..."
START_TIME=$(date +%s%3N)

# Note: This is a mock execution - actual implementation would use Grafana API
# grafana.platon.sikt.no/api/datasources/proxy/1/loki/api/v1/query_range
echo "⚠️  Note: This script demonstrates query testing structure."
echo "   For actual queries, use Grafana UI at https://grafana.platon.sikt.no"

END_TIME=$(date +%s%3N)
DURATION=$((END_TIME - START_TIME))

echo ""
echo "Query completed in: ${DURATION}ms"
echo ""

# Query optimization suggestions based on pattern analysis
echo "=== Query Optimization Suggestions ==="
echo ""

# Check if query starts with label selector
if [[ ! "$QUERY" =~ ^\{.*\} ]]; then
    echo "❌ Query does not start with label selector"
    echo "   Add label selectors: {app=\"myapp\", namespace=\"prod\"}"
fi

# Check for parsing before filtering
if [[ "$QUERY" =~ \|[[:space:]]*json.*\|= ]] || [[ "$QUERY" =~ \|[[:space:]]*logfmt.*\|= ]]; then
    echo "⚠️  Query parses before filtering"
    echo "   Move filters before parsing for better performance"
fi

# Check for empty label selector
if [[ "$QUERY" =~ ^\{\} ]]; then
    echo "❌ Empty label selector {} - scans all logs!"
    echo "   Add specific labels to narrow scope"
fi

# Check for regex when simple match could work
if [[ "$QUERY" =~ \|\~ && ! "$QUERY" =~ [\[\]\.\*\+\?\|\(\)] ]]; then
    echo "⚠️  Using regex |~ for simple pattern"
    echo "   Consider using exact match |= instead"
fi

# Check aggregation without filtering
if [[ "$QUERY" =~ (count_over_time|rate|sum) && ! "$QUERY" =~ \|= ]]; then
    echo "⚠️  Aggregation without filtering"
    echo "   Add filters before aggregation"
fi

echo ""
echo "=== Query Best Practices Checklist ==="
echo ""

checks=0
passed=0

# Check 1: Has label selector
if [[ "$QUERY" =~ ^\{.+\} ]]; then
    echo "✓ Uses label selector"
    ((passed++))
else
    echo "✗ Missing label selector"
fi
((checks++))

# Check 2: Filters before parsing
if [[ ! "$QUERY" =~ \|[[:space:]]*(json|logfmt).*\|= ]]; then
    echo "✓ Filters correctly ordered"
    ((passed++))
else
    echo "✗ Parsing before filtering"
fi
((checks++))

# Check 3: Not using empty selector
if [[ ! "$QUERY" =~ ^\{\} ]]; then
    echo "✓ Not using empty selector"
    ((passed++))
else
    echo "✗ Using empty selector {}"
fi
((checks++))

# Check 4: Reasonable time range
case "$TIME_RANGE" in
    *s|*m|1h|2h)
        echo "✓ Reasonable time range"
        ((passed++))
        ;;
    *)
        echo "⚠️  Large time range - consider starting smaller"
        ;;
esac
((checks++))

echo ""
echo "Passed: $passed/$checks checks"

# Performance rating
SCORE=$((passed * 100 / checks))
if [ $SCORE -ge 75 ]; then
    echo "Rating: ✓ Good query structure"
elif [ $SCORE -ge 50 ]; then
    echo "Rating: ⚠️  Could be optimized"
else
    echo "Rating: ❌ Needs optimization"
fi

echo ""
echo "For actual query execution, use Grafana: https://grafana.platon.sikt.no"
