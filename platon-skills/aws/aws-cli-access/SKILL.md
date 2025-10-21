---
name: aws-cli-access
description: This skill should be used when users need help accessing Sikt's AWS accounts via CLI, configuring AWS SSO sessions, or managing AWS CLI profiles for different accounts and roles.
---

# AWS CLI Access for Sikt

Configure and access Sikt's AWS accounts via the AWS Command Line Interface (CLI) using AWS IAM Identity Center (SSO).

## Prerequisites

AWS CLI v2.9 or higher must be installed. Verify installation with `aws --version`.

## Initial SSO Session Configuration

Create a generic SSO session configuration:

```bash
aws configure sso-session
```

Use these settings:
- Session name: **sikt** (recommended)
- Start URL: **https://d-c3670fd13e.awsapps.com/start**
- Region: **eu-north-1**
- Registration scopes: Accept default (press Enter)

Example:
```
SSO session name: sikt
SSO start URL [None]: https://d-c3670fd13e.awsapps.com/start
SSO region [None]: eu-north-1
SSO registration scopes [sso:account:access]:
Completed configuring SSO session: sikt
```

## Creating Profile for an Account

Configure access to a specific AWS account:

```bash
aws configure sso
```

The CLI will:
1. Ask for session name (use "sikt" from above)
2. Launch browser for authentication (or provide URL/code for manual auth)
3. Redirect to Microsoft for authentication if needed
4. Show available accounts - select the desired one
5. Show available roles - select the appropriate role
6. Ask for default region (typically **eu-north-1** or **eu-west-1**)
7. Ask for output format (default: **json**)
8. Ask for profile name (suggest using account name or "default")

## Reauthenticating

Credentials expire after 8 hours. To reauthenticate:

```bash
aws sso login --profile <profilename>
```

**Pro tip**: Set the `AWS_PROFILE` environment variable to avoid specifying `--profile` on every command:

```bash
export AWS_PROFILE=<profilename>
aws sso login  # No --profile needed
```

Use separate terminal windows with different `AWS_PROFILE` values to work with multiple accounts simultaneously.

## Verifying Identity

Check current AWS identity and account:

```bash
aws sts get-caller-identity
```

Example output:
```json
{
    "UserId": "AROAYGDRDXTORZANK6KCH:fornavn.etternavn@sikt.no",
    "Account": "087521752123",
    "Arn": "arn:aws:sts::087521752123:assumed-role/AWSReservedSSO_<role>_<hexnumber>/fornavn.etternavn@sikt.no"
}
```

## Access Portal

Web-based access portal: [aws.sikt.no](https://beta.aws.sikt.no)

Use this portal to:
- View available accounts
- Access AWS Management Console via browser
- Select roles for each account

## Common Issues

### Browser Not Opening
If browser fails to open during `aws configure sso`, manually copy the URL and code shown in the terminal and complete authentication in a browser.

### Profile Not Found
Ensure the profile name matches what was configured. List available profiles with:
```bash
aws configure list-profiles
```

### Expired Credentials
Re-run `aws sso login --profile <profilename>` to refresh credentials.

## Verification Script

Use the provided verification script to check AWS CLI configuration:

```bash
scripts/verify_aws_config.sh [profile_name]
```

This script checks:
- AWS CLI installation and version
- Profile configuration
- SSO session setup
- Authentication status

## Troubleshooting Reference

For detailed troubleshooting guidance, see `references/sso_troubleshooting.md` which covers:
- Common SSO authentication issues
- Configuration file problems
- Network connectivity issues
- Permission errors
- Diagnostic commands

## Best Practices

1. Use descriptive profile names (e.g., "prod", "dev", "sandbox")
2. Set `AWS_PROFILE` environment variable per terminal session
3. Use **eu-north-1** (Stockholm) or **eu-west-1** (Ireland) regions for proximity to Norway
4. Enable MFA for enhanced security
