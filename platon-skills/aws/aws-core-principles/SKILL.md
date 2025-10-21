---
name: aws-core-principles
description: This skill should be used when users need guidance on Sikt's core principles for running services on AWS, including security best practices, infrastructure as code, regions, and architectural guidelines.
---

# AWS Core Principles for Sikt

Core principles and best practices for running services on AWS within Sikt's organization.

## Fundamental Principle

**If you own the application, you own the security as well**

## Infrastructure as Code (IaC)

### Recommended Tools
- **CloudFormation** (AWS-native)
- **Terraform** (multi-cloud)

### Requirements
- All AWS infrastructure MUST be defined as code
- Manual resource creation via AWS Management Console is restricted to **dev & sandbox accounts only**
- Alternative IaC tools may be used, but team is responsible for maintaining expertise
- Platon support may be limited for non-recommended tools

### Risks of Manual Management
- Lack of reproducibility
- Insufficient documentation
- Higher risk of errors
- No version control

## EC2 Principles

### SSH Access
**DO NOT open port 22**. Use AWS Systems Manager (SSM) Session Manager instead.

Two options for terminal access:
1. **Direct SSM** (without SSH):
   - AWS Web Console: Start session directly
   - CLI: `aws ssm start-session --target i-[instance-number]`

2. **SSM with SSH** (AWS-StartSSHSession):
   - Requires SSH public key in `~/.ssh/authorized_keys` on EC2 instance
   - Or use temporary SSH key via `aws ec2-instance-connect send-ssh-public-key`

### Operating Systems
- Use OS that Platon supports (see Infrastructure documentation)
- Integrate with Puppet for configuration management

## Federation and IAM

### Authentication Requirements
- All management plane access (WebConsole, CLI, API) MUST use federated login via AWS Identity Center
- AWS IAM Users SHALL NOT be used for human access

### IAM Roles
- Use IAM Roles and federation wherever possible
- For external integrations (GitHub/GitLab), use federation
- Alternative options:
  - IAM Roles Anywhere (with Private CA/PKI)
  - Vault-issued temporary Role credentials
- Platon can create IAM Users/Roles for external integrations (e.g., external Jenkins) upon request

## AWS Region Selection

### Preferred Regions
1. **eu-north-1** (Stockholm) - Primary
2. **eu-west-1** (Ireland - Dublin) - Secondary

### Exceptions
- Some global resources only exist in **us-east-1** (N.Virginia)
- Multi-region requirements should be discussed with Platon team

## Public-Facing Services

### Traffic Routing
All internet traffic to AWS services SHOULD route through AWS managed services:
- API Gateway
- CloudFront
- Application Load Balancer (ALB)

### Benefits
- TLS/certificate management
- Automatic HTTP to HTTPS redirection
- Access log storage
- AWS Shield (DDoS protection)
- AWS WAF integration (web application firewall)

### Transport Security
- All internet communication MUST use TLS
- Only standard ports (80/443) should be publicly exposed

## Development Environments

### Security Requirements
- Development environments SHALL NOT be publicly accessible by default
- Avoid exposing incomplete or insecure applications

### External Access
- Use dedicated test/demo accounts for external testing
- External developers/consultants should use VPN to Sikt

## Security Integration

Integrations between AWS accounts or with external services/tools MUST be reviewed with Platon team, especially:
- Integrations granting IAM permissions
- Cross-account access
- External CI/CD integrations

## Resource Deletion

### Special Considerations
When deleting resources, exercise caution with:
- **S3 buckets**: Bucket names are globally unique. Deleting makes name available to others.
- **Domain names** (non-Sikt domains like *.cloud): Can be claimed by others after deletion.

### Recommendations
- Empty S3 buckets have no cost - keep them to retain namespace
- Retain domain names temporarily after service decommission if:
  - External links exist
  - Users expect Sikt content at those URLs
- Only *.sikt.no and *.unit.no domains are safe to delete

## Pre-Production Checklist

Before deploying to production, review with **AWS Well-Architected Tool**.

## Logging and Monitoring

Establish comprehensive logging and monitoring strategy:

### Monitoring
- Define metrics to track
- Configure alarms for critical thresholds
- Monitor external dependencies

### Logs
- Access logs
- Application logs
- Audit logs
- Determine retention periods (balance needs vs GDPR requirements)

## Availability and Resilience

### Service Level Agreements
- Define SLAs for the application
- Determine need for AZ/region failure tolerance
- Plan for multi-AZ or multi-region architecture if needed

### Design for Failure
- Architect for transient errors
- Implement auto-scaling
- Plan resilience to spurious errors
- Expected behavior on Internet and distributed systems

## Backup Strategy

Define comprehensive backup strategy:

### Recovery Objectives
- Recovery Time Objective (RTO)
- Recovery Point Objective (RPO)

### Backup Types
1. **Generational/versioned**: Long-term retention/archival
2. **Point-in-time**: Protection against accidental operations
3. **Hot standby**: Protection against hardware failures

### Backup Coverage
- Databases
- Filesystems
- Secrets and parameters
- Application-specific data (e.g., Cognito users)

**Test backup procedures regularly, especially after changes**

## Deployment Strategy

### Planning Questions
- How will new versions be deployed?
- How will failed deployments be corrected?
- How will bugs be handled (roll forward/backward)?
- How will updates be applied in production?
- How will failures be detected (automated alerting)?

### Deployment Strategies
- Blue/Green (within same account recommended)
- Canary release (gradual traffic shift)
- In-place (all at once)
- Maintenance window (implies downtime)
- Feature flags

**Note**: Don't flip-flop between 2 AWS accounts for blue/green. Use single account.

## Responsibility Definition

Clearly define:
- Ownership throughout application lifecycle
- Monitoring responsibilities
- Operations responsibilities (upgrades, backups)
- Change approval process

## DevOps Practices

Conduct root cause analysis for incidents to:
- Identify actual causes, not just symptoms
- Implement systemic improvements
- Prevent recurrence
