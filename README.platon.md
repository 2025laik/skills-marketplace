# Platon Skills for Claude

Comprehensive set of Claude skills for working with Sikt's Platon platform, covering AWS, Kubernetes/PaaS, CI/CD, monitoring, secrets management, and infrastructure services.

## Skill Organization

The skills are organized by functional area to provide focused, domain-specific expertise.

### AWS Skills

**aws/aws-cli-access**
- Configure AWS CLI for Sikt's AWS accounts
- SSO session setup and management
- Profile creation and authentication
- Credential management and best practices

**aws/aws-core-principles**
- Core security principles for AWS in Sikt
- Infrastructure as Code requirements
- Region selection and best practices
- Resource management and deletion policies
- Deployment strategies and backup planning

### PaaS/Kubernetes Skills

**paas/kubectl-basics**
- kubectl installation and configuration
- Connecting to Platon PaaS cluster
- Viewing and examining resources
- Getting logs and shell access
- Port forwarding and debugging

### CI/CD Skills

**ci-cd/gitlab-ci-basics**
- GitLab CI/CD pipeline configuration
- CI/CD components usage
- Pipeline stages and jobs
- Deployment workflows (review, staging, production)
- Migration from gitlab-ci-helpers

### Monitoring Skills

**monitoring/loki-logging**
- Grafana Loki logging service
- Accessing logs via Grafana
- LogQL query best practices
- Performance optimization for queries
- Role-based access control

### Secrets Management Skills

**secrets/vault-basics**
- HashiCorp Vault fundamentals
- Authentication methods
- Basic operations (list, get, put)
- Common use cases (passwords, certificates)
- Security best practices

**secrets/vault-gitlab**
- Vault integration with GitLab CI/CD
- Reading secrets in pipelines
- Exposing secrets as environment variables or files
- Kubernetes secret management
- Secret rotation and updates

### Infrastructure Skills

**infrastructure/dns-configuration**
- DNS record management for Sikt domains
- PaaS application DNS setup
- Domain registration and transfer
- DNS propagation and troubleshooting
- SSL certificate requirements

### Service Skills

**services/postgresql-aws**
- PostgreSQL on AWS RDS
- Database ordering and configuration
- Access control and external connectivity
- Backup and restore procedures
- Extension management

**services/email-sending**
- Email from PaaS Kubernetes
- Email from AWS (SES)
- Email from Puppet-managed servers
- Sender address requirements
- SMTP configuration examples

## Usage

Each skill contains:
- Clear description of when to use the skill
- Step-by-step procedures
- Configuration examples
- Best practices
- Troubleshooting guidance
- Links to relevant documentation

## Skill Format

All skills follow the Claude skill format with:
- YAML frontmatter (name, description)
- Structured markdown content
- Imperative/infinitive writing style
- Code examples where applicable
- Reference links

## Coverage

These skills cover the core Platon documentation areas:

1. **AWS** - Access, principles, and account management
2. **PaaS** - Kubernetes cluster access and operations
3. **CI/CD** - GitLab pipeline configuration and deployment
4. **Monitoring** - Logging with Loki and Grafana
5. **Secrets** - Vault for secret management
6. **Infrastructure** - DNS configuration
7. **Services** - PostgreSQL databases and email sending

## Additional Topics

The Platon documentation also covers these areas not yet included as skills:
- Certbot/SSL certificate management
- Puppet and Hiera configuration management
- Prometheus and Grafana monitoring
- Zabbix and Argus alerting
- Container registries (ECR, Artifactory)
- Backup with Restic
- Dependency Track for security scanning
- Horizontal Pod Autoscaling

These can be added as additional skills as needed.

## Contributing

When creating new skills or updating existing ones:
1. Follow the skill template structure
2. Use imperative/infinitive writing style
3. Include practical examples
4. Reference official documentation
5. Keep skills focused and modular
6. Test instructions for accuracy

## Resources

- [Platon Documentation](https://platon.sikt.no/)
- [Creating Custom Skills](https://support.claude.com/en/articles/12512198-creating-custom-skills)
- [Platon Support](https://platon.sikt.no/support)

## Contact

For questions about these skills or Platon:
- **Slack**: #platon
- **Email**: hjelp@sikt.no
