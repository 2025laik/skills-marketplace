# AWS SSO Troubleshooting Guide

Detailed troubleshooting for AWS SSO authentication issues with Sikt's AWS accounts.

## Common Issues

### Issue: "Error loading SSO Token"

**Symptoms:**
```
Error loading SSO Token: Token for https://d-c3670fd13e.awsapps.com/start does not exist
```

**Cause:** SSO token has expired (8-hour lifetime) or was never created.

**Solution:**
```bash
aws sso login --profile <profile-name>
```

### Issue: Browser Does Not Open

**Symptoms:**
- `aws configure sso` or `aws sso login` doesn't open browser
- Running on remote server without X11 forwarding

**Solution:**
1. Copy the URL shown in terminal
2. Open URL manually in browser on local machine
3. Enter the device code shown in terminal
4. Complete authentication flow

**Example:**
```
$ aws sso login
Attempting to automatically open the SSO authorization page...
If the browser does not open, open the following URL:

https://device.sso.eu-north-1.amazonaws.com/

Then enter the code: GMSC-WDBL
```

### Issue: "An error occurred (UnauthorizedException)"

**Symptoms:**
```
An error occurred (UnauthorizedException) when calling the GetCallerIdentity operation
```

**Causes:**
1. Token expired
2. Incorrect profile selected
3. SSO session not configured

**Solutions:**
1. Re-authenticate: `aws sso login --profile <profile>`
2. Verify profile: `echo $AWS_PROFILE`
3. Check profile exists: `aws configure list-profiles`

### Issue: Multiple Accounts, Wrong Account Selected

**Symptoms:**
- Have access to multiple AWS accounts
- Commands execute against wrong account

**Solution:**
Use separate terminal sessions with different AWS_PROFILE:

```bash
# Terminal 1 - Production account
export AWS_PROFILE=production
aws sso login
aws sts get-caller-identity

# Terminal 2 - Development account
export AWS_PROFILE=development
aws sso login
aws sts get-caller-identity
```

### Issue: "No AWS profile specified"

**Symptoms:**
```
Unable to locate credentials
```

**Solutions:**

**Option 1 - Set AWS_PROFILE:**
```bash
export AWS_PROFILE=my-profile
```

**Option 2 - Use --profile flag:**
```bash
aws s3 ls --profile my-profile
```

**Option 3 - Set default profile:**
```bash
aws configure set default.profile my-profile
```

### Issue: Config File Corruption

**Symptoms:**
- Unexpected errors
- Cannot parse config file

**Solution:**
Check and fix `~/.aws/config`:

```bash
cat ~/.aws/config
```

Proper format:
```ini
[profile my-profile]
sso_session = sikt
sso_account_id = 123456789012
sso_role_name = LimitedAdmin
region = eu-north-1
output = json

[sso-session sikt]
sso_start_url = https://d-c3670fd13e.awsapps.com/start
sso_region = eu-north-1
sso_registration_scopes = sso:account:access
```

### Issue: Permission Denied Operations

**Symptoms:**
```
An error occurred (AccessDenied) when calling the <operation>
```

**Solutions:**
1. Verify correct role selected during SSO configuration
2. Check if operation is allowed for your role
3. Confirm account ID is correct: `aws sts get-caller-identity`
4. Contact Platon team if permissions needed

### Issue: Region Errors

**Symptoms:**
```
Could not connect to the endpoint URL
```

**Cause:** Incorrect region configuration

**Solution:**
Set correct region:
```bash
aws configure set region eu-north-1 --profile my-profile
```

Or specify in commands:
```bash
aws s3 ls --region eu-north-1
```

## Diagnostic Commands

### Check Current Configuration
```bash
# List all profiles
aws configure list-profiles

# Show configuration for specific profile
aws configure list --profile my-profile

# Show all config values
aws configure list --profile my-profile | grep -v "not set"
```

### Verify Authentication
```bash
# Get current identity
aws sts get-caller-identity --profile my-profile

# Decode identity ARN
aws sts get-caller-identity --profile my-profile --query Arn --output text
```

### Check SSO Session
```bash
# List cached SSO tokens
ls -la ~/.aws/sso/cache/

# Show SSO session details
grep -A 10 "\[sso-session" ~/.aws/config
```

### Test Specific Service Access
```bash
# Test S3 access
aws s3 ls --profile my-profile

# Test EC2 access
aws ec2 describe-regions --profile my-profile

# Test IAM read access
aws iam get-user --profile my-profile
```

## Configuration Files

### ~/.aws/config
Contains profile configurations and SSO sessions.

Location: `~/.aws/config`

### ~/.aws/credentials
Should be empty or minimal when using SSO (credentials are temporary).

Location: `~/.aws/credentials`

### SSO Cache
Stores temporary SSO tokens.

Location: `~/.aws/sso/cache/`

**Note:** Tokens expire after 8 hours.

## Advanced Troubleshooting

### Enable Debug Logging
```bash
aws s3 ls --debug --profile my-profile 2>&1 | less
```

### Check Network Connectivity
```bash
# Test HTTPS connectivity to SSO endpoint
curl -I https://d-c3670fd13e.awsapps.com/start

# Test AWS STS endpoint
curl -I https://sts.eu-north-1.amazonaws.com
```

### Clear SSO Cache
```bash
# Remove all cached tokens
rm -rf ~/.aws/sso/cache/*

# Re-authenticate
aws sso login --profile my-profile
```

### Verify AWS CLI Installation
```bash
# Check AWS CLI installation
which aws
aws --version

# Check Python version (AWS CLI v2 has bundled Python)
python3 --version
```

## Getting Help

If issues persist:

1. **Collect diagnostic information:**
   ```bash
   aws --version
   aws configure list --profile my-profile
   aws sts get-caller-identity --profile my-profile 2>&1
   ```

2. **Contact Platon team:**
   - Slack: #platon
   - Email: hjelp@sikt.no
   - Provide: Profile name, error messages, diagnostic output

3. **Check Platon documentation:**
   - https://platon.sikt.no/aws/account-access

## Preventive Measures

### Regular Maintenance
```bash
# Weekly: Clear old SSO tokens
find ~/.aws/sso/cache/ -type f -mtime +7 -delete

# Monthly: Review and clean unused profiles
aws configure list-profiles
```

### Best Practices
1. Use descriptive profile names
2. Set AWS_PROFILE per terminal session
3. Re-authenticate before long operations
4. Document custom configurations
5. Keep AWS CLI updated

### Automation-Friendly Authentication
For scripts requiring AWS access:

```bash
#!/bin/bash
# Ensure fresh authentication
PROFILE="my-profile"

# Check if authenticated
if ! aws sts get-caller-identity --profile $PROFILE &>/dev/null; then
    echo "Not authenticated. Running: aws sso login --profile $PROFILE"
    aws sso login --profile $PROFILE
fi

# Run your AWS commands
aws s3 ls --profile $PROFILE
```
