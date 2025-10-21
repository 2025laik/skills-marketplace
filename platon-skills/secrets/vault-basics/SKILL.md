---
name: vault-basics
description: This skill should be used when users need help with Vault for secret management in Platon, including authentication, basic operations (list, get, put), reading server root passwords, writing certificates, and using Vault CLI.
---

# Vault Basics for Platon

HashiCorp Vault for secrets management in Platon infrastructure.

## What is Vault?

Vault is a secrets management system providing:
- Secure secret storage
- Dynamic secrets
- Data encryption
- Leasing and renewal
- Revocation

## Authentication

Multiple authentication methods available:
- LDAP (for users)
- Token
- AppRole (for applications)
- Kubernetes (for PaaS applications)
- GitLab CI/CD

## Installation

### Manual Installation

Download from [Vault releases](https://www.vaultproject.io/downloads) and install appropriate binary for your platform.

### Puppet Installation

For Puppet-managed servers:

```yaml
# In Hiera
classes:
  - profile::vault::client
```

## Login Methods

### Vault CLI via SSH

SSH to a server with Vault CLI installed:

```bash
vault login -method=ldap username=<your-username>
```

Enter LDAP password when prompted.

### Local Vault CLI

Set Vault address:

```bash
export VAULT_ADDR=https://vault.sikt.no:8200
```

Login:

```bash
vault login -method=ldap username=<your-username>
```

### Web UI

Access: https://vault.sikt.no:8200/ui

Select LDAP authentication method and provide credentials.

## Basic Usage

### LIST: Listing Content

List secrets at a path:

```bash
vault list secret/path/to/secrets
```

Example - list servers:

```bash
$ vault list secret/servers/
Keys
----
server1.example.com/
server2.example.com/
```

List contents of specific server:

```bash
$ vault list secret/servers/server1.example.com/
Keys
----
root_password
ssh_host_keys/
```

### GET: Reading Secrets

Read secret value:

```bash
vault read secret/path/to/secret
```

Example - read root password:

```bash
$ vault read secret/servers/server1.example.com/root_password
Key                 Value
---                 -----
refresh_interval    768h
password            SuperSecretPassword123
```

Read specific field:

```bash
vault read -field=password secret/servers/server1.example.com/root_password
```

Output: `SuperSecretPassword123`

### PUT: Writing Secrets

Write secret:

```bash
vault write secret/path/to/secret key=value
```

Example - write simple secret:

```bash
vault write secret/myapp/config api_key=abc123 db_password=xyz789
```

Write multiple fields:

```bash
vault write secret/myapp/database \
  host=db.example.com \
  port=5432 \
  username=appuser \
  password=secret123
```

## Common Use Cases

### Reading Stored Root Password

Servers managed by Puppet typically store root passwords in Vault.

```bash
vault read -field=password secret/servers/$(hostname -f)/root_password
```

Example:

```bash
$ vault read -field=password secret/servers/web01.sikt.no/root_password
MyRootPassword123
```

### Updating Stored Root Password

After changing a root password, update Vault:

```bash
# Read current password (for reference)
vault read secret/servers/$(hostname -f)/root_password

# Update with new password
vault write secret/servers/$(hostname -f)/root_password password=NewPassword456
```

### Writing a Certificate

Store certificate with private key:

```bash
vault write secret/certificates/myapp.sikt.no \
  certificate=@/path/to/cert.pem \
  private_key=@/path/to/key.pem \
  chain=@/path/to/chain.pem
```

Using `@` prefix reads file contents.

Read certificate later:

```bash
# Read entire certificate secret
vault read secret/certificates/myapp.sikt.no

# Extract just the certificate
vault read -field=certificate secret/certificates/myapp.sikt.no

# Extract private key
vault read -field=private_key secret/certificates/myapp.sikt.no
```

## Vault Path Structure

### Common Paths

- `secret/servers/<hostname>/` - Server-specific secrets
- `secret/gitlab/<group>/<project>/` - GitLab project secrets
- `secret/certificates/` - SSL/TLS certificates
- `secret/applications/<appname>/` - Application secrets

### Path Conventions

Paths typically follow organizational structure:
- Use fully qualified domain names for servers
- Mirror GitLab group/project structure
- Use descriptive names for applications

## Creating Token for Puppet Node

Generate token for Puppet-managed node (requires appropriate permissions):

```bash
vault token create \
  -policy=puppet-node \
  -display-name="node-$(hostname -f)" \
  -period=72h
```

Token stored in `/etc/vault/token` on Puppet-managed nodes.

## Security Considerations

### Token Storage

- Never commit tokens to git repositories
- Don't share tokens between users/systems
- Use shortest possible TTL for tokens
- Revoke tokens when no longer needed

### Secret Access

- Follow principle of least privilege
- Request specific paths, not broad access
- Audit secret access regularly
- Rotate secrets periodically

### Password Management

- Use strong, unique passwords
- Rotate credentials regularly
- Don't reuse passwords across systems
- Store recovery keys separately from Vault

## Vault Policies

Policies define access control. Typical policy structure:

```hcl
# Read access to specific path
path "secret/myapp/*" {
  capabilities = ["read", "list"]
}

# Write access to specific path
path "secret/myapp/config" {
  capabilities = ["create", "update", "delete"]
}
```

Common capabilities:
- `read` - Read data
- `list` - List keys
- `create` - Create new data
- `update` - Modify existing data
- `delete` - Delete data

## Troubleshooting

### Permission Denied

Check your token's policies:

```bash
vault token lookup
```

Request additional access from Platon team if needed.

### Token Expired

Re-authenticate:

```bash
vault login -method=ldap username=<your-username>
```

### Connection Issues

Verify Vault address:

```bash
echo $VAULT_ADDR
```

Should be: `https://vault.sikt.no:8200`

Test connectivity:

```bash
curl -k $VAULT_ADDR/v1/sys/health
```

## Web UI Features

Access Vault Web UI at: https://vault.sikt.no:8200/ui

Features:
- Browse secrets hierarchically
- Create/edit secrets via forms
- View secret history
- Manage policies (with permissions)
- Monitor authentication methods

## Best Practices

1. **Use environment variables** for Vault address and token
2. **Leverage field extraction** with `-field` flag for scripting
3. **Organize secrets hierarchically** following conventions
4. **Document secret locations** for team members
5. **Implement secret rotation** for sensitive credentials
6. **Use descriptive names** for secrets and paths
7. **Regular audits** of secret access and policies
8. **Backup strategy** for critical secrets
9. **Test secret retrieval** in automation before production
10. **Revoke unused tokens** to minimize security surface

## Resources

- [Vault Documentation](https://www.vaultproject.io/docs)
- [Vault CLI Reference](https://www.vaultproject.io/docs/commands)
- Internal Platon Vault documentation
- Contact Platon team for access requests or questions
