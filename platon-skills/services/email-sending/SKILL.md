---
name: email-sending
description: This skill should be used when users need help sending email from applications in Platon infrastructure, including PaaS, AWS, Puppet-managed servers, and understanding sender address requirements and email infrastructure.
---

# Sending Email from Platon Applications

Configure applications to send email properly from Platon infrastructure.

## Overview

Sending email requires proper configuration to avoid spam filters and delivery issues. Consider:

1. **From address** - What email address sending from
2. **To address(es)** - Recipients
3. **Sending system** - IP address and system identity

Improper configuration results in:
- Blocked emails
- Delivery to spam/junk folders
- Silent deletion (blackholing)

## Sender Address Considerations

### Reply and Bounce Handling

**No replies expected**:
- Use noreply address: `noreply@sikt.no`

**Replies expected, bounces ignored**:
- Set `Reply-To:` header to reply address
- Set `From:` and `Return-Path:` to `noreply@sikt.no`

### Sender Domain Requirements

Mail system must be authorized to send from the sender domain, otherwise:
- Emails bounced
- Delivered to junk folder
- Quarantined
- Blackholed

## Email from PaaS Kubernetes

### SMTP Configuration

**SMTP Server**: `outbound-mta.it.sikt.no:587`

**Authentication**: None required (PaaS workers whitelisted)

**Port**: 587

### Sender Address Requirements

**⚠️ Important**: Sender address in both `From:` and `Return-Path:` headers must end with:
- `@feide.no`
- `@sigma2.no`
- `@sikt.no`

**If not**: Addresses transformed to `@srs.it.sikt.no`:
- Works functionally
- May confuse recipients
- Can break inbox filters
- Not aesthetically pleasing

### Configuration Examples

**Python (using smtplib)**:

```python
import smtplib
from email.message import EmailMessage

msg = EmailMessage()
msg['From'] = 'myapp@sikt.no'
msg['To'] = 'recipient@example.com'
msg['Subject'] = 'Test Email'
msg.set_content('This is a test email.')

with smtplib.SMTP('outbound-mta.it.sikt.no', 587) as smtp:
    smtp.send_message(msg)
```

**Django settings.py**:

```python
EMAIL_HOST = 'outbound-mta.it.sikt.no'
EMAIL_PORT = 587
EMAIL_USE_TLS = False
EMAIL_USE_SSL = False
DEFAULT_FROM_EMAIL = 'myapp@sikt.no'
```

**Node.js (nodemailer)**:

```javascript
const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
  host: 'outbound-mta.it.sikt.no',
  port: 587,
  secure: false,
  tls: {
    rejectUnauthorized: false
  }
});

const mailOptions = {
  from: 'myapp@sikt.no',
  to: 'recipient@example.com',
  subject: 'Test Email',
  text: 'This is a test email.'
};

transporter.sendMail(mailOptions);
```

### Custom Sender Address

For custom sender addresses, use [AWS SES](#email-from-aws).

## Email from AWS

### Amazon Simple Email Service (SES)

**Recommended** for AWS applications.

### Initial Limitations (Sandbox Mode)

New AWS accounts start in sandbox with:
- **200 emails per day** (24-hour limit)
- **Only verified recipient addresses** can receive emails

### Sender Verification Requirements

Must verify sender address or domain:
- Individual addresses
- Entire domain (allows any address on domain)

**⚠️ Cannot use @sikt.no**: Incompatible with DMARC, DKIM, and SPF.

**Alternative**: Use subdomain of sikt.no (requires setup).

### SMTP Credentials

Requires IAM user creation (Platon admin only).

### Platon Blueprint

Platon provides [CloudFormation template for SES](https://gitlab.sikt.no/platon/aws-blueprints/-/tree/master/simple-email-service).

**Prerequisites**:
- Route53 hosted zone in account
- Used [hosted zone blueprint](https://gitlab.sikt.no/platon/aws-blueprints/-/tree/master/hostedzone)

**Deploy**:

```bash
aws cloudformation deploy \
  --stack-name ses-configuration \
  --template-file ses-configuration.yaml \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides HostedZoneStack=<hostedzone-stack-name>
```

**Creates**:
- Default configuration set
- Email identity (based on hosted zone domain)
- IAM user with access key
- Access key ID (SSM Parameter Store)
- Access key secret (Secrets Manager)

**Post-deployment**:
1. Go to Amazon SES in AWS Console
2. Find created identity
3. Click "Publish DNS records to Route53"
4. Verifies DKIM for domain

### SMTP Configuration

**Server**: `email-smtp.REGION.amazonaws.com` (replace REGION)

**Username**: From stack output or SSM Parameter `/sikt/SES/SMTPusername`

**Password**: Generate from AWS secret access key:
1. Get secret from AWS Secrets Manager: `SMTP_IAMUSER_secret_access_key`
2. Use Python script from [blueprint repo](https://gitlab.sikt.no/platon/aws-blueprints/-/tree/master/simple-email-service)
3. Script generates SMTP password from secret access key

### Testing

Add recipient addresses to **Identities** page while in sandbox.

### Production Access

To send to any address, [request production access](https://docs.aws.amazon.com/ses/latest/dg/request-production-access.html).

### Sending Methods

- [SMTP interface](https://docs.aws.amazon.com/ses/latest/dg/send-email-smtp.html)
- [SES API](https://docs.aws.amazon.com/ses/latest/dg/send-email-api.html)

## Email from Puppet-Managed Servers

### Configuration

**Pre-configured** if server has `pmodule_postfix` module loaded.

**Send via**:
- Local sendmail command
- Any local mail command
- SMTP to `localhost`

### Verification

Check configuration:

```bash
/usr/sbin/postconf relayhost
```

**Expected response**:
```
relayhost = [outbound-mta.it.sikt.no]:587
```

## Email from Non-Puppet Servers/VMs

### Requirements

Server must have:
- **Stable IPv4 and/or IPv6 address** (IPv6 preferred)
- Regular security patches
- Sufficient monitoring

### Whitelisting Request

Email hjelp@sikt.no with subject "Email sending: whitelist server".

**Provide**:
- Server FQDN (fully-qualified domain name)
- Server purpose
- IPv4 address
- IPv6 address
- Owning team name
- Contact information (email/Teams/Slack)

**After whitelisting**: Configure MTA to use `[outbound-mta.it.sikt.no]:587` as relay host.

### Example Postfix Configuration

```
relayhost = [outbound-mta.it.sikt.no]:587
```

## Email from Custom Applications

### Puppet-Controlled Server

Configure application to send email locally:
- Use programming language's email functions
- Or configure SMTP server as `localhost`

### Non-Puppet Server with Stable IP

**Requirements**:
- Stable IPv4/IPv6 address
- Regular patches
- Monitoring for suspicious activity

**Process**:
1. Email hjelp@sikt.no ("Email sending: whitelist server")
2. Provide server details (see [Non-Puppet Servers](#email-from-non-puppet-servers-vms))
3. After whitelisting, use `outbound-mta.it.sikt.no` as SMTP server

### Cloud/SaaS Applications

**Not supported** with credentials (username/password).

Contact InternIT: hjelp@sikt.no for assistance.

## Best Practices

### Sender Addresses

1. Use `noreply@sikt.no` if no replies expected
2. Set `Reply-To` header for reply handling
3. Ensure sender domain matches authorized sending system
4. Use approved domains (@sikt.no, @feide.no, @sigma2.no)

### Bounce Handling

1. Monitor bounce messages
2. Remove invalid addresses
3. Investigate persistent bounces
4. Set up dedicated bounce handling if high volume

### Rate Limiting

1. Implement sending rate limits
2. Queue emails for large batches
3. Monitor for spam indicators
4. Follow AWS SES limits if using SES

### Testing

1. Test with small recipient list first
2. Verify delivery to various email providers
3. Check spam scores (e.g., mail-tester.com)
4. Monitor bounce rates

### Monitoring

Monitor:
- Delivery success rates
- Bounce rates
- Spam complaints
- Queue sizes
- Sending limits

## Testing Script

Use provided script to test SMTP configuration:

```bash
scripts/test_smtp.py <from_addr> <to_addr> [smtp_server] [smtp_port]
```

Examples:
```bash
scripts/test_smtp.py myapp@sikt.no recipient@example.com
scripts/test_smtp.py noreply@feide.no admin@sikt.no
```

The script:
- Tests SMTP connectivity
- Validates sender address domain
- Sends test email
- Provides detailed error messages

Run this before deploying email functionality to production.

## Troubleshooting

### Emails Rejected

**Check**:
1. Sender address uses approved domain
2. Sending system is whitelisted
3. Headers properly configured
4. Not exceeding rate limits

### Emails in Spam

**Possible causes**:
- Sender not authorized for domain
- Missing SPF/DKIM records
- Content triggers spam filters
- Sending from new IP without warmup

**Solutions**:
1. Verify DNS records (SPF, DKIM, DMARC)
2. Use authorized sending systems
3. Improve email content
4. Gradual volume increase for new senders

### AWS SES Sandbox Limits

**Symptoms**:
- Only verified recipients receive emails
- 200 emails/day limit reached

**Solution**:
[Request production access](https://docs.aws.amazon.com/ses/latest/dg/request-production-access.html)

### Connection Refused

**Check**:
1. Correct SMTP server and port
2. Network connectivity
3. Firewall rules
4. Server whitelisted (if required)

## Resources

- [Sikt Email Documentation](https://platon.sikt.no/tjenester/email/)
- [AWS SES Documentation](https://docs.aws.amazon.com/ses/)
- [Platon AWS Blueprints](https://gitlab.sikt.no/platon/aws-blueprints)
- Contact: hjelp@sikt.no or #platon on Slack
