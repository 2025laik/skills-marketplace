#!/bin/bash
# Script to retrieve pod logs with common filtering options
# Usage: ./get_pod_logs.sh <namespace> [pod-name-pattern] [options]

NAMESPACE=$1
POD_PATTERN=$2
TAIL_LINES=${3:-100}
FOLLOW=${4:-false}

if [ -z "$NAMESPACE" ]; then
    echo "Usage: $0 <namespace> [pod-pattern] [tail-lines] [follow]"
    echo ""
    echo "Examples:"
    echo "  $0 my-namespace                    # List pods in namespace"
    echo "  $0 my-namespace production         # Logs from pods matching 'production'"
    echo "  $0 my-namespace production 50      # Last 50 lines"
    echo "  $0 my-namespace production 100 true # Follow logs"
    exit 1
fi

# Check if namespace exists and is accessible
if ! kubectl get namespace "$NAMESPACE" &> /dev/null; then
    echo "Error: Cannot access namespace '$NAMESPACE'"
    exit 1
fi

# If no pod pattern provided, list pods
if [ -z "$POD_PATTERN" ]; then
    echo "Pods in namespace '$NAMESPACE':"
    kubectl get pods -n "$NAMESPACE"
    exit 0
fi

# Find pods matching pattern
PODS=$(kubectl get pods -n "$NAMESPACE" --no-headers 2>/dev/null | grep "$POD_PATTERN" | awk '{print $1}')

if [ -z "$PODS" ]; then
    echo "No pods found matching pattern '$POD_PATTERN' in namespace '$NAMESPACE'"
    echo ""
    echo "Available pods:"
    kubectl get pods -n "$NAMESPACE" --no-headers | awk '{print "  " $1}'
    exit 1
fi

POD_COUNT=$(echo "$PODS" | wc -l | tr -d ' ')

echo "Found $POD_COUNT pod(s) matching '$POD_PATTERN'"
echo ""

# Get logs from each matching pod
for POD in $PODS; do
    echo "=== Logs from $POD ==="

    # Check if pod has multiple containers
    CONTAINER_COUNT=$(kubectl get pod "$POD" -n "$NAMESPACE" -o jsonpath='{.spec.containers[*].name}' 2>/dev/null | wc -w | tr -d ' ')

    if [ "$CONTAINER_COUNT" -gt 1 ]; then
        echo "Pod has $CONTAINER_COUNT containers:"
        kubectl get pod "$POD" -n "$NAMESPACE" -o jsonpath='{.spec.containers[*].name}' | tr ' ' '\n' | sed 's/^/  - /'
        echo ""

        # Get logs from each container
        for CONTAINER in $(kubectl get pod "$POD" -n "$NAMESPACE" -o jsonpath='{.spec.containers[*].name}'); do
            echo "--- Container: $CONTAINER ---"

            if [ "$FOLLOW" = "true" ]; then
                kubectl logs "$POD" -n "$NAMESPACE" -c "$CONTAINER" --tail="$TAIL_LINES" -f
            else
                kubectl logs "$POD" -n "$NAMESPACE" -c "$CONTAINER" --tail="$TAIL_LINES"
            fi
            echo ""
        done
    else
        # Single container pod
        if [ "$FOLLOW" = "true" ]; then
            kubectl logs "$POD" -n "$NAMESPACE" --tail="$TAIL_LINES" -f
        else
            kubectl logs "$POD" -n "$NAMESPACE" --tail="$TAIL_LINES"
        fi
        echo ""
    fi

    echo ""
done

# Show pod status
echo "=== Pod Status ==="
kubectl get pods -n "$NAMESPACE" | grep -E "NAME|$POD_PATTERN"
