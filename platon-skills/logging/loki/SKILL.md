---
name: loki-logging
description: This skill should be used when users need help with Loki logging in Platon, including accessing Grafana, configuring log shipping from PaaS, writing efficient LogQL queries, and understanding best practices for log querying and performance optimization.
---

# Loki Logging for Platon

Grafana Loki logging service for Sikt, replacing Humio.

## Overview

Platon provides centralized logging using Grafana Loki for services running on PaaS and selected external services.

## Getting Started

### For PaaS Applications

To collect logs from PaaS cluster applications:

1. **Identify namespace** for your application/service

2. **Contact Platon team** (#platon on Slack) with:
   - Namespace name
   - Tenant/team name for the tenant
   - Microsoft EntraID group defining access permissions

3. **Platon configures**:
   - Vector updated to route logs by namespace
   - Loki configured with tenant separation

**Best Practice**: Use one Tenant ID per product/service for:
- Clear log ownership
- Cost tracking
- Access control

### Accessing Logs

🔗 **Grafana URL**: https://grafana.platon.sikt.no

- Authentication via Entra ID
- Organizations correspond to Sikt product areas

## Role-Based Access Control

### Creating Role Groups

Role groups in Sikt define responsibilities and needs related to employee work.

**Key Principles**:
- Independent of specific systems
- Assign access based on roles, not individuals
- Owned by product area or section
- May include individuals across entire organization

### Example Role Groups

| Group Name | Description |
|-----------|-------------|
| ROLE_Platon Ops | Full operational access for infrastructure management |
| ROLE_Platon Shared Resources Insight | Read-only access to ingress logs and shared data |

Configure role groups via team-admin.

## Non-PaaS Services

For applications not running on PaaS, contact Platon team (#platon) for setup and guidance.

## LogQL Best Practices

### Understanding Performance

**Bloom Filters**: Loki uses bloom filters for query acceleration - a quick index showing which data chunks might contain searched content.

**Key Concepts**:
- **Stream labels**: Labels in curly braces `{app="nginx", namespace="prod"}`
- **Structured metadata**: Additional data filtered with pipes `| key="value"`

### Essential Best Practices

#### 1. Start Small, Then Expand

Always test queries on small time ranges first:
- Start with 5 minutes or 1 hour
- Verify query works correctly
- Expand to larger ranges
- Prevents accidental resource overuse

#### 2. Use Labels to Filter First

Loki indexes labels, not log content. Always start with label filters.

**✅ Fast:**
```logql
{app="myapp", namespace="prod"} |= "error"
```

**❌ Very slow:**
```logql
{} |= "error"
```
Second query scans ALL logs in the system!

#### 3. Filter Before Parsing

Order matters for bloom filter acceleration.

**✅ Fast:**
```logql
{app="nginx"}
| detected_level="error"    # Filter first
| json                       # Parse second
```

**❌ Slow:**
```logql
{app="nginx"}
| json                       # Parse first (slow!)
| detected_level="error"    # Filter second
```

#### 4. Use Simple String Matching

`|=` (exact match) is faster than `|~` (regex).

**✅ Fast:**
```logql
{app="nginx"} |= "404"
```

**❌ Slower:**
```logql
{app="nginx"} |~ "40[0-9]"
```

Only use regex when pattern matching is truly needed.

#### 5. Parse Only What You Need

JSON and logfmt parsing are expensive. Parse selectively.

**✅ Efficient:**
```logql
{app="api"}
|= "orderId"           # Filter to relevant logs
| json orderId         # Parse only needed field
| orderId="12345"
```

**❌ Inefficient:**
```logql
{app="api"}
| json                 # Parses all fields in every log!
| orderId="12345"
```

### Metrics and Aggregations

#### 6. Aggregate After Filtering

Filter data before aggregation functions.

**✅ Efficient:**
```logql
{app="nginx"}
|= "error"                    # Filter first
| count_over_time[5m]         # Then count
```

**❌ Inefficient:**
```logql
count_over_time({app="nginx"}[5m])  # Counts everything
```

#### 7. Use Small Time Windows

Use smallest window providing needed resolution.

**✅ Good:**
```logql
sum(rate({app="payment"} |= "error" [5m]))
```

**❌ Resource-intensive:**
```logql
sum(rate({app="payment"} |= "error" [1h]))
```

### Advanced Tips

#### 8. Avoid High-Cardinality Labels

Don't use labels with millions of unique values as stream labels:
- ❌ `trace_id`
- ❌ `user_id`
- ❌ `session_id`

Keep these in structured metadata instead.

#### 9. Structure Complex Queries in Stages

Think in three stages:
1. **Narrow down**: Use stream labels and simple filters
2. **Parse**: Extract only needed fields
3. **Aggregate**: Summarize results

**Example:**
```logql
{app="payment", namespace="prod"}  # 1. Narrow with labels
|= "timeout"                        # 1. Further narrow
| json status                       # 2. Parse only status
| status="500"                      # 2. Filter parsed data
| count_over_time[5m]              # 3. Aggregate
```

#### 10. Watch Stream Count

Each unique label combination creates a "stream". Queries matching 50,000+ streams will be slow regardless of other optimizations.

**Check stream count:**
```logql
count(count_over_time({app="myapp"}[1m])) by (labels)
```

## Quick Reference

| Do ✅ | Don't ❌ |
|-------|----------|
| Start with label selectors | Use `{}` without labels |
| Filter before parsing | Parse before filtering |
| Use `\|=` for exact matches | Use `\|~` unnecessarily |
| Test on small time ranges | Start with 30-day queries |
| Aggregate after filtering | Aggregate raw data |
| Keep high-cardinality in structured metadata | Use high-cardinality stream labels |

## Additional Performance Tips

### 11. Avoid Peak Hours

For deep scans across days or multiple services:
- Run during off-peak hours
- Reduces throttling risk
- Minimizes impact on other users

### 12. Query Cost Awareness

**Dashboards vs Logs**:
- Use metrics for high-frequency monitoring
- Reserve logs for debugging or audit trails
- Use Explore for ad hoc queries
- Use Dashboards for focused, repeating queries

**⚠️ Warning**: Dashboard queries auto-refresh frequently! Avoid expensive queries in dashboards.

## Common Query Patterns

### Find Errors in Last Hour
```logql
{app="myapp", namespace="prod"}
|= "error"
| json
| status>=500
```

### Count Errors Per Minute
```logql
sum(count_over_time({app="myapp"} |= "error" [1m])) by (namespace)
```

### Filter by Structured Metadata
```logql
{app="myapp"}
| json
| http_method="POST"
| response_time > 1000
```

### Parse and Extract Specific Fields
```logql
{app="api"}
|= "user_id"
| json user_id, request_id, status
| status="200"
```

## Helper Scripts

### Query Performance Testing

Use `scripts/test_logql_query.sh` to analyze query structure:

```bash
scripts/test_logql_query.sh "<logql-query>" [time-range]
```

Provides:
- Query structure analysis
- Performance optimization suggestions
- Best practices checklist
- Performance rating

### LogQL Quick Reference

See `references/logql_quick_reference.md` for:
- Complete syntax reference
- Common query patterns
- Performance tips
- Use case examples
- Function reference

Load this reference when writing complex queries or need syntax reminders.

## Getting Help

- Review [Getting Started Guide](./getting_started.md)
- Contact Platon team (#platon) for query optimization assistance
- Check Grafana documentation for advanced LogQL features
