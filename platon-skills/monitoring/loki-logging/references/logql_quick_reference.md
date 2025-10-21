# LogQL Quick Reference

Fast reference for LogQL syntax and common patterns.

## Basic Query Structure

```logql
{label_selectors} | line_filters | parser | label_filters | aggregation
```

## Label Selectors

```logql
# Single label
{app="nginx"}

# Multiple labels (AND)
{app="nginx", namespace="prod"}

# Label regex match
{app=~"nginx|apache"}

# Label not equal
{app!="nginx"}

# Label regex not match
{app!~"test.*"}
```

## Line Filters

```logql
# Contains (exact string)
|= "error"

# Does not contain
!= "error"

# Regex match
|~ "error|fail"

# Regex not match
!~ "success|ok"

# Case-insensitive (use (?i) flag)
|~ "(?i)error"
```

## Parsers

```logql
# JSON parser
| json

# JSON parser (specific fields)
| json level, message, user_id

# Logfmt parser
| logfmt

# Pattern parser
| pattern `<timestamp> <level> <message>`

# Regexp parser
| regexp `(?P<level>\\w+)`

# Unpack (for nested JSON)
| json | line_format "{{.field}}" | json
```

## Label Filters (Post-Parsing)

```logql
# Filter on parsed label
| level="error"

# Numeric comparison
| status_code >= 500

# Duration comparison
| response_time > 1s

# IP address filter
| ip_address=ip("192.168.0.0/16")
```

## Line Formatting

```logql
# Extract fields
| line_format "{{.field1}} {{.field2}}"

# Conditional formatting
| line_format "{{if .error}}ERROR{{else}}OK{{end}}"

# JSON output
| line_format `{{toJson .}}`
```

## Label Formatting

```logql
# Keep specific labels
| label_format foo=bar

# Rename label
| label_format new_name=old_name

# Remove label
| label_format old_name=""
```

## Aggregations

### Log Range Aggregations

```logql
# Count logs over time
count_over_time({app="nginx"}[5m])

# Rate (logs per second)
rate({app="nginx"}[5m])

# Count logs by level
sum by(level) (count_over_time({app="nginx"}[5m]))

# Bytes processed
bytes_over_time({app="nginx"}[5m])

# Bytes rate
bytes_rate({app="nginx"}[5m])
```

### Metric Aggregations

```logql
# Sum
sum(rate({app="nginx"}[5m]))

# Average
avg(rate({app="nginx"}[5m]))

# Min/Max
min(rate({app="nginx"}[5m]))
max(rate({app="nginx"}[5m]))

# Count
count(count_over_time({app="nginx"}[5m]))

# Topk (top N)
topk(10, sum by(path) (rate({app="nginx"}[5m])))

# Bottomk (bottom N)
bottomk(5, avg(rate({app="nginx"}[5m])))
```

## Unwrap (Extract Metrics from Logs)

```logql
# Extract numeric value
sum(rate({app="nginx"} | json | unwrap duration [5m]))

# Quantile on unwrapped values
quantile_over_time(0.99, {app="nginx"} | json | unwrap response_time [5m])

# Avg on unwrapped values
avg_over_time({app="nginx"} | json | unwrap bytes [5m])
```

## Common Patterns

### Error Rate

```logql
sum(rate({app="myapp"} |= "error" [5m]))
```

### HTTP Status Codes

```logql
sum by(status) (
  count_over_time({app="nginx"} | json | status >= 200 [5m])
)
```

### Top Error Messages

```logql
topk(10,
  sum by(message) (
    count_over_time({app="myapp"} |= "error" | json [1h])
  )
)
```

### Average Response Time

```logql
avg(
  rate({app="api"} | json | unwrap response_time [5m])
)
```

### P95 Response Time

```logql
quantile_over_time(0.95,
  {app="api"} | json | unwrap response_time [5m]
)
```

### Failed Requests per Endpoint

```logql
sum by(path) (
  rate({app="api"} | json | status >= 500 [5m])
)
```

### Log Volume by Level

```logql
sum by(level) (
  count_over_time({app="myapp"} | json [5m])
)
```

## Time Ranges

```logql
[5s]   # 5 seconds
[1m]   # 1 minute
[5m]   # 5 minutes
[1h]   # 1 hour
[24h]  # 24 hours
[7d]   # 7 days
```

## Performance Tips

### ✓ Fast Queries

```logql
# Good: Label selector + filter before parsing
{app="nginx", env="prod"} |= "error" | json

# Good: Simple string match
{app="nginx"} |= "404"

# Good: Aggregate after filtering
sum(rate({app="nginx"} |= "error" [5m]))
```

### ✗ Slow Queries

```logql
# Bad: Empty label selector
{} |= "error"

# Bad: Parse before filtering
{app="nginx"} | json | message=~"error"

# Bad: Unnecessary regex
{app="nginx"} |~ "404"  # Use |= instead

# Bad: Large time window
rate({app="nginx"}[24h])  # Start with [5m]
```

## Operators

### Arithmetic

```logql
+ - * / % ^
```

### Comparison

```logql
== != > < >= <=
```

### Logical

```logql
and or unless
```

## Functions

### Mathematical

```logql
abs()   - Absolute value
ceil()  - Round up
floor() - Round down
round() - Round
sqrt()  - Square root
```

### Time

```logql
minute()
hour()
day_of_week()
day_of_month()
month()
year()
```

## Multi-line Queries

```logql
sum by(status) (
  rate(
    {app="nginx", env="prod"}
    |= "GET"
    | json
    | status >= 200
    [5m]
  )
)
```

## Query Examples by Use Case

### Debugging

```logql
# Last 100 errors
{app="myapp"} |= "error" | json

# Errors from specific user
{app="myapp"} | json | user_id="12345" | level="error"

# Stack traces
{app="myapp"} |= "Traceback" or |= "Exception"
```

### Monitoring

```logql
# Error rate
rate({app="myapp"} |= "error" [5m])

# Request latency
avg(rate({app="api"} | json | unwrap latency [5m]))

# Failed logins
sum(count_over_time({app="auth"} |= "login failed" [5m]))
```

### Alerting

```logql
# High error rate (>10 errors/sec)
sum(rate({app="myapp"} |= "error" [5m])) > 10

# No logs for 5 minutes
absent_over_time({app="myapp"}[5m])

# High 5xx rate
sum(rate({app="api"} | json | status >= 500 [5m])) > 5
```

## Resources

- [Loki Documentation](https://grafana.com/docs/loki/latest/)
- [LogQL Syntax](https://grafana.com/docs/loki/latest/logql/)
- [Grafana Platon](https://grafana.platon.sikt.no)
