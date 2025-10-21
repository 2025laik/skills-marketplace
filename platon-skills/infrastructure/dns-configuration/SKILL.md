---
name: dns-configuration
description: This skill should be used when users need help with DNS configuration for Platon applications, including modifying DNS records for Sikt-owned domains, requesting new domains, and configuring DNS for PaaS applications.
---

# DNS Configuration for Platon Applications

Configure DNS records for applications running in Platon infrastructure.

## Overview

Sikt manages multiple DNS solutions, and the process for modifying DNS records depends on which DNS servers are authoritative for the domain.

## Modifying Existing Sikt-Owned Domains

### Route53 Domains (AWS)

If domain is served by Route53 in an AWS account:
1. Log in to the appropriate AWS account
2. Navigate to Route53
3. Modify DNS records directly

### Unit Legacy Domains

For DNS zones originating from Unit, request web access by emailing hjelp@sikt.no.

**Domains requiring web access request**:

```
0.0.7.5.0.0.7.0.1.0.0.2.ip6.arpa
1.0.7.5.0.0.7.0.1.0.0.2.ip6.arpa
46.156.193.in-addr.arpa
47.156.193.in-addr.arpa
6.156.193.in-addr.arpa
7.156.193.in-addr.arpa
8.156.193.in-addr.arpa
aapenforskning.no
admissio.no
akademikercv.no
bibliometri.no
bibsys.no
ceres.no
cristin.no
fairdata.no
fellesstudentsystem.no
forskningsdata.no
fs-rust.no
fsat.no
fsweb.no
kudaf.no
minutdanning.no
nasjonal-vitnemalsdatabase.no
openaccess.no
openedx.no
openforsking.no
openscience.no
studweb.no
unit.no
vitnemalportalen.no
vitnemalsbanken.no
vitnemalsportalen.no
will.kick.your.as
xn--penforskning-scb.no (åpenforskning.no)
xn--vitnemlportalen-mlb.no (vitnemålportalen.no)
xn--vitnemlsportalen-iob.no (vitnemålsportalen.no)
```

### Other Sikt-Owned Domains

For any other Sikt-owned domain:
1. Email hjelp@sikt.no
2. Specify:
   - Record name (FQDN)
   - Record type (A, AAAA, CNAME, TXT, etc.)
   - Target/value
   - TTL (if specific requirement)

### sikt.no Direct Subdomain

**⚠️ Warning**: Creating DNS record directly under `sikt.no` requires approval.

Process:
1. Get approval from [Kommunikasjon section](https://over.sikt.no/seksjon/798326e8-4aed-4f3d-bce4-7da1a557fbdd)
2. Ensures name doesn't interfere with other applications
3. Email hjelp@sikt.no after approval

## DNS for PaaS Applications

### Standard Configuration

For applications in Kubernetes PaaS cluster:

**Target**: `paas2-ingress.lb.uninett.no`

**Record Type**: CNAME

### Example Request

Email to hjelp@sikt.no:

```
Subject: DNS Record for PaaS Application

Application: My Application
Desired FQDN: my-app.sikt.no
Record Type: CNAME
Target: paas2-ingress.lb.uninett.no
Contact: team-name@sikt.no
```

### GitLab CI/CD Configuration

After DNS record creation, update `.gitlab-ci.yml`:

```yaml
variables:
  KUBE_PROD_DOMAIN: my-app.sikt.no
  KUBE_TEST_ID: my-app
```

**Note**: Staging deployment uses default domain:
```
my-app-staging.sokrates.edupaas.no
```

**Domain Change**: Default changed from `*.paas2.uninett.no` to `*.sokrates.edupaas.no` (Feb 2025).

### SSL/TLS Certificates

PaaS automatically generates certificates via cert-manager and Let's Encrypt.

**Requirement**: DNS must resolve to `paas2-ingress.lb.uninett.no` before certificate issuance.

**Ingress annotation required**:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    kubernetes.io/tls-acme: "true"
```

## Requesting New Domain

### .no Domain

**.no domains are limited** (Sikt has 100-domain limit).

**Process**:
1. Get permission from [Kommunikasjon section](https://over.sikt.no/seksjon/798326e8-4aed-4f3d-bce4-7da1a557fbdd)
2. Requests must be prioritized
3. Email hjelp@sikt.no with:
   - Domain name
   - Purpose
   - Application/service
   - Team/contact information
   - Kommunikasjon approval

### Non-.no Domain

Less restrictive but still requires:
1. Business justification
2. Budget approval (domain registration costs)
3. Email hjelp@sikt.no with request

## Domain Transfer to Sikt

### Prerequisites

1. Permission from [Kommunikasjon section](https://over.sikt.no/seksjon/798326e8-4aed-4f3d-bce4-7da1a557fbdd)
2. Permission from current domain owner
3. Transfer authorization code from current registrar

### Process

1. Obtain current owner's permission
2. Get transfer authorization
3. Get Kommunikasjon approval
4. Email hjelp@sikt.no with:
   - Domain name
   - Current registrar
   - Authorization code
   - Purpose
   - Approvals obtained

## Common DNS Record Types

### A Record
- Maps hostname to IPv4 address
- Example: `app.sikt.no` → `192.168.1.100`

### AAAA Record
- Maps hostname to IPv6 address
- Example: `app.sikt.no` → `2001:700:0:1::100`

### CNAME Record
- Maps hostname to another hostname
- Example: `app.sikt.no` → `paas2-ingress.lb.uninett.no`
- **Cannot coexist with other record types at same name**

### TXT Record
- Stores text data
- Common uses: SPF, DKIM, domain verification

### MX Record
- Mail exchange servers
- Specifies mail servers for domain

## DNS Propagation

### Timing

- Changes typically propagate within **minutes to hours**
- Full global propagation can take up to **48 hours**
- Depends on TTL (Time To Live) values

### Testing DNS Changes

Use the provided DNS propagation checking script:

```bash
scripts/check_dns_propagation.sh <domain> [record-type]
```

This script checks DNS propagation across multiple nameservers, verifies consistency, and shows TTL values.

Manual DNS checks:

```bash
# Query specific nameserver
dig @8.8.8.8 my-app.sikt.no

# Check multiple record types
dig my-app.sikt.no A
dig my-app.sikt.no AAAA
dig my-app.sikt.no CNAME

# Trace DNS resolution
dig +trace my-app.sikt.no
```

Using nslookup:

```bash
nslookup my-app.sikt.no
nslookup my-app.sikt.no 8.8.8.8
```

Online tools:
- https://www.whatsmydns.net/
- https://dnschecker.org/

## Best Practices

### TTL Values

- **Production**: 300-3600 seconds (5 minutes - 1 hour)
- **Pre-change**: Lower TTL 24-48 hours before major changes
- **Post-change**: Raise TTL after successful change

### CNAME vs A/AAAA

- **Use CNAME when**: Target can change IPs
- **Use A/AAAA when**: Need root domain or specific IP

### Documentation

Document DNS configuration:
- Record purpose
- Application/service using record
- Change history
- Contact information

### Monitoring

Monitor DNS resolution:
- Set up alerts for DNS failures
- Regular checks of critical records
- Test from multiple locations

## Troubleshooting

### DNS Not Resolving

**Check**:
1. Wait for propagation (up to 48 hours)
2. Verify record created correctly
3. Check authoritative nameservers
4. Test from multiple DNS servers

```bash
# Check authoritative nameservers
dig ns sikt.no

# Query authoritative server directly
dig @ns1.authority.server my-app.sikt.no
```

### Wrong IP Returned

**Causes**:
- DNS caching (local or ISP)
- Incorrect record configuration
- Propagation not complete

**Solutions**:
- Clear local DNS cache
- Wait for TTL expiration
- Verify record configuration

### Certificate Not Issuing (PaaS)

**Requirements for Let's Encrypt**:
1. DNS must resolve to `paas2-ingress.lb.uninett.no`
2. HTTP01 challenge must succeed
3. Ingress must have `kubernetes.io/tls-acme: "true"` annotation

**Check**:
```bash
# Verify DNS resolution
dig my-app.sikt.no

# Check certificate in Kubernetes
kubectl describe certificate my-app-tls -n <namespace>

# Check cert-manager logs
kubectl logs -n cert-manager deployment/cert-manager
```

## PaaS FAQ Integration

**Q**: How do I get my service on `<service-name>.sikt.no`?

**A**: Create CNAME record pointing to `paas2-ingress.lb.uninett.no`, then update `.gitlab-ci.yml`:

```yaml
variables:
  KUBE_PROD_DOMAIN: my-service.sikt.no
  KUBE_TEST_ID: my-service
```

See [PaaS FAQ](https://platon.sikt.no/paas/faq#how-do-i-get-my-service-on-service-namesiktno) for details.

## Resources

- [PaaS FAQ - DNS](https://platon.sikt.no/paas/faq#how-do-i-get-my-service-on-service-namesiktno)
- [Sikt DNS Services](https://platon.sikt.no/tjenester/dns)
- Contact: hjelp@sikt.no
- Approval: [Kommunikasjon section](https://over.sikt.no/seksjon/798326e8-4aed-4f3d-bce4-7da1a557fbdd)
