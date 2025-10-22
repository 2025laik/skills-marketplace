#!/bin/bash
# Script to verify kubectl access to Platon PaaS cluster
# Usage: ./check_paas_access.sh [namespace]

set -e

NAMESPACE=${1}

echo "=== Platon PaaS Access Verification ==="
echo ""

# Check if kubectl is installed
if ! command -v kubectl &> /dev/null; then
    echo "❌ kubectl is not installed"
    echo "Install from: https://kubernetes.io/docs/tasks/tools/install-kubectl/"
    exit 1
fi

echo "✓ kubectl is installed"
KUBECTL_VERSION=$(kubectl version --client --short 2>/dev/null | grep "Client Version" || kubectl version --client 2>&1 | head -1)
echo "  $KUBECTL_VERSION"
echo ""

# Check if context is configured
CURRENT_CONTEXT=$(kubectl config current-context 2>/dev/null || echo "none")
if [ "$CURRENT_CONTEXT" = "none" ]; then
    echo "❌ No kubectl context configured"
    echo "Configure using: https://console.paas.sikt.no/"
    exit 1
fi

echo "✓ Current context: $CURRENT_CONTEXT"
echo ""

# Test cluster connectivity
echo "Testing cluster connectivity..."
if kubectl cluster-info &> /dev/null; then
    echo "✓ Connected to cluster"
    kubectl cluster-info | grep -E "Kubernetes|running"
else
    echo "❌ Cannot connect to cluster"
    echo ""
    echo "Possible issues:"
    echo "  - Not on Sikt network (VPN required)"
    echo "  - Token expired (get new token from console)"
    echo "  - Network issues"
    exit 1
fi

echo ""

# Check server version
echo "Checking server version..."
SERVER_VERSION=$(kubectl version --short 2>/dev/null | grep "Server Version" || kubectl version 2>&1 | grep "Server Version")
echo "✓ $SERVER_VERSION"
echo ""

# If namespace provided, check access to it
if [ -n "$NAMESPACE" ]; then
    echo "Checking access to namespace: $NAMESPACE"

    if kubectl get namespace "$NAMESPACE" &> /dev/null; then
        echo "✓ Namespace exists"

        # Try to list pods
        if kubectl get pods -n "$NAMESPACE" &> /dev/null; then
            echo "✓ Can list pods in namespace"

            POD_COUNT=$(kubectl get pods -n "$NAMESPACE" --no-headers 2>/dev/null | wc -l | tr -d ' ')
            echo "  Pods in namespace: $POD_COUNT"

            # Show pod status summary
            if [ "$POD_COUNT" -gt 0 ]; then
                echo ""
                echo "Pod status summary:"
                kubectl get pods -n "$NAMESPACE" --no-headers 2>/dev/null | awk '{print $3}' | sort | uniq -c | awk '{print "  " $2 ": " $1}'
            fi
        else
            echo "⚠️  Cannot list pods (may lack permissions)"
        fi

        # Check for deployments
        if kubectl get deployments -n "$NAMESPACE" &> /dev/null; then
            DEPLOY_COUNT=$(kubectl get deployments -n "$NAMESPACE" --no-headers 2>/dev/null | wc -l | tr -d ' ')
            echo "  Deployments in namespace: $DEPLOY_COUNT"
        fi

        # Check for services
        if kubectl get services -n "$NAMESPACE" &> /dev/null; then
            SVC_COUNT=$(kubectl get services -n "$NAMESPACE" --no-headers 2>/dev/null | wc -l | tr -d ' ')
            echo "  Services in namespace: $SVC_COUNT"
        fi

        # Check for ingresses
        if kubectl get ingresses -n "$NAMESPACE" &> /dev/null; then
            ING_COUNT=$(kubectl get ingresses -n "$NAMESPACE" --no-headers 2>/dev/null | wc -l | tr -d ' ')
            echo "  Ingresses in namespace: $ING_COUNT"

            if [ "$ING_COUNT" -gt 0 ]; then
                echo ""
                echo "Ingress hosts:"
                kubectl get ingresses -n "$NAMESPACE" -o jsonpath='{range .items[*]}{"  https://"}{.spec.rules[0].host}{"\n"}{end}' 2>/dev/null
            fi
        fi

    else
        echo "❌ Cannot access namespace '$NAMESPACE'"
        echo ""
        echo "Possible issues:"
        echo "  - Namespace does not exist"
        echo "  - No permissions for this namespace"
        echo "  - Need to update access from console.paas.sikt.no"
    fi
else
    echo "Listing accessible namespaces..."
    ACCESSIBLE_NS=$(kubectl get namespaces --no-headers 2>/dev/null | wc -l | tr -d ' ')

    if [ "$ACCESSIBLE_NS" -gt 0 ]; then
        echo "✓ Can access $ACCESSIBLE_NS namespace(s)"
        echo ""
        echo "Your namespaces:"
        kubectl get namespaces --no-headers 2>/dev/null | grep -v "^kube-\|^default\|^cert-manager\|^ingress-nginx" | awk '{print "  - " $1}' | head -10

        if [ "$ACCESSIBLE_NS" -gt 10 ]; then
            echo "  ... and $(($ACCESSIBLE_NS - 10)) more"
        fi
    else
        echo "⚠️  No accessible namespaces found"
        echo "Check your permissions at https://console.paas.sikt.no/"
    fi
fi

echo ""
echo "=== Access Check Complete ==="
echo ""
echo "To find your namespace, visit: https://console.paas.sikt.no/"
echo "For new projects, click 'update pipeline configuration' to sync access"
