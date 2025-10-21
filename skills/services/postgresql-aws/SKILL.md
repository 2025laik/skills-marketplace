---
name: postgresql-aws
description: This skill should be used when users need help with PostgreSQL databases on AWS RDS in Platon, including ordering databases, access control, backup, versions, supported use cases, and extensions.
---

# PostgreSQL on AWS RDS for Platon

Shared PostgreSQL database service on AWS RDS managed by Platon.

## Overview

Platon provides a shared RDS instance for teams that don't wish to maintain their own database.

**Current Version**: PostgreSQL v15

## Features Provided

For each database, Platon provides:
- Read/Write user
- Optional Read-Only user
- Default RDS extensions for PostgreSQL version

## SLA

Service Level Agreement details available in Platon documentation. Contact Platon team for specific SLA requirements.

## External Access

**Access Restrictions** (implemented January 22, 2025):

Databases accessible from:
- Internal Sikt office network
- Sikt EduVPN
- Curated list of external IPs (legitimate clients)

**Previously**: All databases were publicly accessible (prior to January 22, 2025).

### Requesting Additional Access

Contact Platon team (#platon) if you require additional client access outside the default allowed networks.

## Backup

### Automatic Backups

- **Frequency**: Daily backup via [storage volume snapshot](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithAutomatedBackups.html)
- **Retention**: Last 30 days
- **Point-in-time restore**: Available within 30-day retention period

### Restore Process

For large databases, [restore process](https://interndocs.sikt.no/docs/platon-ops/db/psql_aws_rds) can take significant time.

**Data Loss**: If entire RDS instance needs restoration to latest backup, up to 5 minutes of data can be lost.

## PostgreSQL Versions and Upgrades

### Current Version

Running PostgreSQL v15.

### Upgrade Policy

Platon upgrades to new major versions following [AWS supported versions](https://docs.aws.amazon.com/AmazonRDS/latest/PostgreSQLReleaseNotes/postgresql-release-calendar.html).

### Upgrade Notifications

- Well in advance of actual upgrade
- Additional downtime notification sent to [database owners list](https://interndocs.sikt.no/docs/platon-ops/db/notification)

## Supported Use Cases

### Suitable For

Shared RDS is meant for teams that:
- Don't want to maintain their own database
- Have moderate database size (under a couple hundred GBs)
- Have standard performance requirements
- Need only standard PostgreSQL extensions
- Can accept Platon's upgrade schedule

### NOT Suitable For

The shared RDS does **NOT** support:

1. **Large Databases**
   - More than a couple of hundred GBs

2. **High Performance Requirements**
   - Need dedicated resources
   - Require performance tuning

3. **Administrative Access**
   - Need access outside database itself
   - Require server-level configuration

4. **Complex User Management**
   - Large number of users/roles
   - Granular/complex access control

5. **Custom Extensions**
   - Only default AWS RDS extensions available
   - Cannot install custom extensions

6. **Version Control**
   - Cannot stay on specific PostgreSQL version
   - Must follow Platon's upgrade schedule

**Alternative**: For these requirements, use a **dedicated AWS RDS instance**.

## PostgreSQL Extensions

### Available Extensions

Only extensions available in AWS RDS by default are provided.

See [Postgres 15 Extensions](https://docs.aws.amazon.com/AmazonRDS/latest/PostgreSQLReleaseNotes/postgresql-extensions.html#postgresql-extensions-15x) for complete list.

### Enabling Extensions

Extensions must be enabled per database.

**Methods**:
1. Specify desired extensions when ordering database
2. Contact Platon to enable after database creation:
   - Email: hjelp@sikt.no
   - Subject: `Platon: Enable extension on an RDS database`
   - Include: Extension name and database name

**Example extensions**:
- `pg_trgm` - Text search
- `uuid-ossp` - UUID generation
- `pgcrypto` - Cryptographic functions
- `hstore` - Key-value store
- `postgis` - Geographic data

## Ordering a Database

### How to Order

Contact Platon via:
- Email: hjelp@sikt.no
- Subject: `Platon: Order PostgreSQL database`

### Information to Provide

1. **Database Name**
   - Preferred database name

2. **Team/Project Information**
   - Team name
   - Project/application name
   - Contact person

3. **Access Requirements**
   - Read/Write user (default)
   - Read-Only user (if needed)
   - External IP addresses (if access from outside Sikt network)

4. **Extensions**
   - List any required PostgreSQL extensions

5. **Backup Requirements**
   - Any specific backup/retention needs beyond standard

## Connection Information

After database creation, Platon provides:

1. **Endpoint** (hostname)
2. **Port** (typically 5432)
3. **Database name**
4. **Username(s)**
5. **Password(s)** (via Vault)

### Example Connection String

```
postgresql://username:password@endpoint:5432/database_name
```

## Connection Testing Script

Use provided script to test database connectivity:

```bash
scripts/test_db_connection.sh <host> <database> <username>
```

The script:
- Verifies psql installation
- Tests connection
- Shows database information
- Lists tables
- Provides troubleshooting hints

Run this after receiving database credentials to verify access.

## Best Practices

### Credentials Management

**Store credentials in Vault**:
- Never hardcode credentials
- Use environment variables or configuration files
- Retrieve from Vault in CI/CD pipelines

### Connection Pooling

For applications with many concurrent connections:
- Implement connection pooling
- Use libraries like `pgbouncer` or application-level pooling
- Reduces connection overhead

### Schema Management

- Use migration tools (e.g., Flyway, Liquibase, Django migrations)
- Version control schema changes
- Test migrations in non-production databases first

### Monitoring

Monitor these metrics:
- Connection count
- Query performance
- Database size
- CPU and memory usage

Contact Platon if consistent performance issues occur.

### Backup Testing

Periodically test restoration process:
- Request test restore from Platon
- Verify data integrity
- Document restore time

## Security

### Network Access

- Database not publicly accessible by default
- Access only from approved networks/IPs
- Use VPN when accessing from external locations

### Credentials

- Use strong, unique passwords
- Rotate credentials periodically
- Store in Vault, not in code repositories

### SSL/TLS

Always use SSL/TLS connections:

```python
# Python psycopg2 example
import psycopg2

conn = psycopg2.connect(
    host="endpoint",
    database="dbname",
    user="username",
    password="password",
    sslmode="require"
)
```

## Troubleshooting

### Connection Refused

**Check**:
1. Correct endpoint and port
2. Your IP is whitelisted (if connecting from outside Sikt)
3. VPN connection active (if required)
4. Database credentials are correct

### Slow Queries

**Actions**:
1. Check query execution plans (`EXPLAIN ANALYZE`)
2. Review indexes on frequently queried columns
3. Monitor connection pool usage
4. Contact Platon if performance issue persists

### Out of Connections

**Solutions**:
1. Implement connection pooling
2. Close connections when done
3. Review application for connection leaks
4. Request connection limit increase from Platon

### Disk Space

**Monitor**:
- Database size growth
- Plan for scaling before reaching limits
- Contact Platon for capacity planning

## Migration to Dedicated RDS

If shared RDS no longer meets needs, migrateto dedicated RDS:

1. **Contact Platon**
   - Discuss requirements
   - Plan migration approach

2. **Create Dedicated RDS**
   - Platon or team creates dedicated instance in AWS account

3. **Migration Options**
   - `pg_dump` / `pg_restore`
   - AWS Database Migration Service (DMS)
   - Logical replication

4. **Testing**
   - Verify data integrity
   - Test application connectivity
   - Performance testing

5. **Cutover**
   - Schedule maintenance window
   - Update application configuration
   - Monitor post-migration

## Resources

- [AWS RDS PostgreSQL Documentation](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html)
- [PostgreSQL 15 Documentation](https://www.postgresql.org/docs/15/)
- [Platon Internal Documentation](https://interndocs.sikt.no/docs/platon-ops/db/)
- Contact: #platon on Slack or hjelp@sikt.no
