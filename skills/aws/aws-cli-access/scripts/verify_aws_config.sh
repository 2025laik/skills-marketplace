#!/bin/bash
# Script to verify AWS CLI configuration for Sikt
# Usage: ./verify_aws_config.sh [profile_name]

set -e

PROFILE=${1:-default}

echo "=== AWS CLI Configuration Verification for Sikt ==="
echo ""

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI is not installed"
    echo "Install from: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html"
    exit 1
fi

echo "✓ AWS CLI is installed"

# Check AWS CLI version
AWS_VERSION=$(aws --version 2>&1 | cut -d' ' -f1 | cut -d'/' -f2)
echo "  Version: $AWS_VERSION"

# Check if version is >= 2.9
MAJOR=$(echo $AWS_VERSION | cut -d'.' -f1)
MINOR=$(echo $AWS_VERSION | cut -d'.' -f2)

if [ "$MAJOR" -lt 2 ] || ([ "$MAJOR" -eq 2 ] && [ "$MINOR" -lt 9 ]); then
    echo "⚠️  Warning: AWS CLI version should be >= 2.9"
fi

echo ""

# Check if SSO session is configured
if aws configure list-profiles | grep -q "$PROFILE"; then
    echo "✓ Profile '$PROFILE' exists"
else
    echo "❌ Profile '$PROFILE' not found"
    echo "Run: aws configure sso"
    exit 1
fi

echo ""

# Check SSO session configuration
echo "Checking SSO session configuration..."
if grep -q "sso_start_url" ~/.aws/config 2>/dev/null; then
    SSO_URL=$(grep "sso_start_url" ~/.aws/config | head -1 | awk '{print $3}')
    if [ "$SSO_URL" = "https://d-c3670fd13e.awsapps.com/start" ]; then
        echo "✓ SSO start URL is correctly configured"
    else
        echo "⚠️  SSO start URL: $SSO_URL"
        echo "   Expected: https://d-c3670fd13e.awsapps.com/start"
    fi
else
    echo "⚠️  No SSO session configured"
fi

echo ""

# Test authentication
echo "Testing authentication with profile '$PROFILE'..."
if aws sts get-caller-identity --profile "$PROFILE" &> /dev/null; then
    echo "✓ Authentication successful"
    echo ""
    echo "Identity information:"
    aws sts get-caller-identity --profile "$PROFILE"
else
    echo "❌ Authentication failed"
    echo "Run: aws sso login --profile $PROFILE"
    exit 1
fi

echo ""
echo "=== Configuration OK ==="
