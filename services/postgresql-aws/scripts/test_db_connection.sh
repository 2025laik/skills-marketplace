#!/bin/bash
# Script to test PostgreSQL database connectivity
# Usage: ./test_db_connection.sh <host> <database> <username>

HOST=$1
DATABASE=$2
USERNAME=$3

if [ -z "$HOST" ] || [ -z "$DATABASE" ] || [ -z "$USERNAME" ]; then
    echo "Usage: $0 <host> <database> <username>"
    echo ""
    echo "Example:"
    echo "  $0 mydb.abc123.eu-north-1.rds.amazonaws.com myapp myapp_user"
    echo ""
    echo "You will be prompted for the password."
    exit 1
fi

echo "=== PostgreSQL Connection Test ==="
echo ""
echo "Host: $HOST"
echo "Database: $DATABASE"
echo "Username: $USERNAME"
echo ""

# Check if psql is installed
if ! command -v psql &> /dev/null; then
    echo "❌ psql is not installed"
    echo ""
    echo "Install PostgreSQL client:"
    echo "  Ubuntu/Debian: apt-get install postgresql-client"
    echo "  macOS: brew install postgresql"
    echo "  RHEL/CentOS: yum install postgresql"
    exit 1
fi

echo "✓ psql is installed"
PSQL_VERSION=$(psql --version | awk '{print $3}')
echo "  Version: $PSQL_VERSION"
echo ""

# Test connection
echo "Testing connection (you will be prompted for password)..."
echo ""

if PGPASSWORD="" psql -h "$HOST" -U "$USERNAME" -d "$DATABASE" -c "SELECT version();" 2>/dev/null; then
    echo ""
    echo "✓ Connection successful"

    # Get database info
    echo ""
    echo "=== Database Information ==="
    psql -h "$HOST" -U "$USERNAME" -d "$DATABASE" << EOF
SELECT
    current_database() as database,
    current_user as user,
    inet_server_addr() as server_address,
    inet_server_port() as server_port,
    version() as postgres_version;

\dt
EOF
else
    echo ""
    echo "❌ Connection failed"
    echo ""
    echo "Possible issues:"
    echo "  - Incorrect credentials"
    echo "  - Network not allowed (check IP whitelist)"
    echo "  - Not on Sikt network/VPN"
    echo "  - Host or database name incorrect"
    echo "  - Database not yet created"
fi
