#!/bin/bash
# Script to check DNS propagation for Platon applications
# Usage: ./check_dns_propagation.sh <domain> [expected_target]

DOMAIN=$1
EXPECTED_TARGET=$2

if [ -z "$DOMAIN" ]; then
    echo "Usage: $0 <domain> [expected_target]"
    echo ""
    echo "Examples:"
    echo "  $0 myapp.sikt.no"
    echo "  $0 myapp.sikt.no paas2-ingress.lb.uninett.no"
    exit 1
fi

echo "=== DNS Propagation Check ==="
echo ""
echo "Domain: $DOMAIN"
if [ -n "$EXPECTED_TARGET" ]; then
    echo "Expected Target: $EXPECTED_TARGET"
fi
echo ""

# DNS servers to check
DNS_SERVERS=(
    "8.8.8.8:Google DNS"
    "1.1.1.1:Cloudflare DNS"
    "208.67.222.222:OpenDNS"
)

# Check A and CNAME records
check_record() {
    local server=$1
    local name=$2
    local record_type=$3

    result=$(dig +short @$server $DOMAIN $record_type 2>/dev/null | head -1)
    echo "$result"
}

echo "=== Checking DNS Servers ==="
echo ""

all_match=true
first_result=""

for entry in "${DNS_SERVERS[@]}"; do
    IFS=':' read -r server label <<< "$entry"

    echo "[$label] ($server)"

    # Check CNAME first
    cname=$(check_record $server $DOMAIN CNAME)

    if [ -n "$cname" ]; then
        echo "  CNAME: $cname"

        if [ -z "$first_result" ]; then
            first_result=$cname
        elif [ "$cname" != "$first_result" ]; then
            all_match=false
        fi

        if [ -n "$EXPECTED_TARGET" ]; then
            if [ "$cname" = "$EXPECTED_TARGET" ] || [ "$cname" = "${EXPECTED_TARGET}." ]; then
                echo "  ✓ Matches expected target"
            else
                echo "  ✗ Does not match expected target"
                all_match=false
            fi
        fi
    else
        # Check A record
        a_record=$(check_record $server $DOMAIN A)

        if [ -n "$a_record" ]; then
            echo "  A: $a_record"

            if [ -z "$first_result" ]; then
                first_result=$a_record
            elif [ "$a_record" != "$first_result" ]; then
                all_match=false
            fi
        else
            echo "  No DNS record found"
            all_match=false
        fi
    fi

    echo ""
done

# Check TTL
echo "=== TTL Information ==="
ttl=$(dig +nocmd $DOMAIN any +noall +answer | awk '{print $2}' | head -1)
if [ -n "$ttl" ]; then
    echo "Current TTL: ${ttl} seconds"

    hours=$((ttl / 3600))
    minutes=$(((ttl % 3600) / 60))

    if [ $hours -gt 0 ]; then
        echo "           = ${hours}h ${minutes}m"
    else
        echo "           = ${minutes}m"
    fi
else
    echo "Could not determine TTL"
fi

echo ""

# Summary
echo "=== Summary ==="
echo ""

if $all_match && [ -n "$first_result" ]; then
    echo "✓ DNS is consistently propagated"
    echo "  All servers return: $first_result"

    if [ -n "$EXPECTED_TARGET" ]; then
        if [ "$first_result" = "$EXPECTED_TARGET" ] || [ "$first_result" = "${EXPECTED_TARGET}." ]; then
            echo "✓ Matches expected target"
        else
            echo "✗ Does not match expected target"
            echo "  Expected: $EXPECTED_TARGET"
            echo "  Got: $first_result"
        fi
    fi
else
    echo "⚠️  DNS propagation inconsistent or incomplete"
    echo "   Wait for TTL to expire and check again"
fi

echo ""

# Check if resolvable via PaaS ingress
if [ -n "$EXPECTED_TARGET" ] && [[ "$EXPECTED_TARGET" == *"paas"* ]]; then
    echo "=== PaaS Ingress Check ==="
    echo ""

    # Resolve the expected target
    target_ip=$(dig +short $EXPECTED_TARGET | grep -E '^[0-9.]+$' | head -1)

    if [ -n "$target_ip" ]; then
        echo "PaaS Ingress IP: $target_ip"

        # Check if domain resolves to this IP
        domain_ip=$(dig +short $DOMAIN | grep -E '^[0-9.]+$' | head -1)

        if [ "$domain_ip" = "$target_ip" ]; then
            echo "✓ Domain resolves to PaaS ingress"
            echo "  Ready for cert-manager to issue certificate"
        elif [ -n "$domain_ip" ]; then
            echo "✗ Domain resolves to different IP: $domain_ip"
        else
            echo "⚠️  Domain does not resolve to an IP"
        fi
    fi
fi

echo ""
echo "For real-time global propagation check, visit:"
echo "  https://www.whatsmydns.net/#CNAME/$DOMAIN"
