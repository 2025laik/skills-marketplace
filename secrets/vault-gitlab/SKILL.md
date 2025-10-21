---
name: vault-gitlab
description: This skill should be used when users need help integrating Vault secrets into GitLab CI/CD pipelines for Platon PaaS, including reading secrets from Vault, exposing them as environment variables or files, and managing secrets in deployment manifests.
---

# Vault Integration with GitLab CI/CD

Use HashiCorp Vault secrets in GitLab CI/CD pipelines for Platon PaaS deployments.

## Overview

GitLab is integrated with Vault, providing access to secrets in `/secret/gitlab/<group>/<project>` tree by default.

**Note**: Access outside this path requires approval from Platon team.

## Vault Access in GitLab CI/CD

Each GitLab project has automatic access to:

```
/secret/gitlab/<group>/<project>/*
```

Example: Project `platon/my-application` can access:
- `/secret/gitlab/platon/my-application/*`

## Using Secrets in CI/CD Pipeline

### Basic Configuration

Define reusable secrets configuration using GitLab's `extends` feature:

```yaml
.vault-secrets:
  id_tokens:
    VAULT_ID_TOKEN:
      aud: "https://vault.sikt.no:8200"
  secrets:
    MY_DB_PASSWORD:
      token: $VAULT_ID_TOKEN
      vault: "gitlab/my-group/my-project/my-db/password@secret"
      file: false
    MY_SECRET_API_KEY:
      token: $VAULT_ID_TOKEN
      vault: "gitlab/my-group/my-project/my-api/key@secret"
      file: false
```

**Key Elements**:
- `id_tokens`: Generate JWT token for Vault authentication
- `secrets`: Define secrets to fetch from Vault
- `vault`: Path format is `path/to/secret/field@secret` (note: prefix `secret/` is implied)
- `file: false`: Expose as environment variable (default is file)

### Using in Pipeline Stages

Extend `.vault-secrets` in deployment jobs:

```yaml
production:
  extends:
    - .production
    - .vault-secrets
  stage: production
  variables:
    REPLICAS: "2"
  script:
    - deploy deployment.yaml

staging:
  extends:
    - .staging
    - .vault-secrets
  stage: staging
  script:
    - deploy deployment.yaml

review:
  extends:
    - .review
    - .vault-secrets
  stage: review
  script:
    - deploy deployment.yaml
```

## Exposing Secrets in Kubernetes

### Method 1: Environment Variables

Create Kubernetes Secret from CI/CD variables:

#### deployment.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $CI_ENVIRONMENT_SLUG
  namespace: $KUBE_NAMESPACE
spec:
  replicas: $REPLICAS
  selector:
    matchLabels:
      app: $CI_ENVIRONMENT_SLUG
  template:
    metadata:
      labels:
        app: $CI_ENVIRONMENT_SLUG
    spec:
      containers:
      - name: app
        image: $CI_REGISTRY_IMAGE:$CI_REGISTRY_TAG
        env:
        - name: DATABASE_PASSWORD
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: db-password
        - name: API_KEY
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: api-key
```

#### secret.yaml

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secrets
  namespace: $KUBE_NAMESPACE
type: Opaque
stringData:
  db-password: $MY_DB_PASSWORD
  api-key: $MY_SECRET_API_KEY
```

Deploy both manifests:

```yaml
production:
  extends:
    - .production
    - .vault-secrets
  script:
    - deploy secret.yaml
    - deploy deployment.yaml
```

**Important**: Deploy secret before deployment to ensure availability.

### Method 2: Secrets as Files

Mount secrets as files in containers:

#### secret.yaml

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-config
  namespace: $KUBE_NAMESPACE
type: Opaque
stringData:
  database.conf: $DATABASE_CONFIG
  api-credentials.json: $API_CREDENTIALS
```

#### deployment.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $CI_ENVIRONMENT_SLUG
spec:
  template:
    spec:
      containers:
      - name: app
        image: $CI_REGISTRY_IMAGE:$CI_REGISTRY_TAG
        volumeMounts:
        - name: config-volume
          mountPath: /etc/app/config
          readOnly: true
      volumes:
      - name: config-volume
        secret:
          secretName: app-config
```

Secrets available as files:
- `/etc/app/config/database.conf`
- `/etc/app/config/api-credentials.json`

## Reading Secrets from CI/CD Pipeline

### Example: Secret in File

GitLab can write secrets to files during pipeline execution:

#### .gitlab-ci.yml

```yaml
.vault-secrets:
  id_tokens:
    VAULT_ID_TOKEN:
      aud: "https://vault.sikt.no:8200"
  secrets:
    DATABASE_CONFIG:
      token: $VAULT_ID_TOKEN
      vault: "gitlab/my-group/my-project/database/config@secret"
      file: true  # Write to file instead of env var

build:
  extends: .vault-secrets
  script:
    # Secret available in file at $DATABASE_CONFIG
    - cat $DATABASE_CONFIG
    - echo "Config loaded from $(echo $DATABASE_CONFIG)"
```

### Example: Secret in Variable

Fetch secret as environment variable:

```yaml
.vault-secrets:
  secrets:
    API_TOKEN:
      token: $VAULT_ID_TOKEN
      vault: "gitlab/my-group/my-project/api/token@secret"
      file: false

deploy:
  extends: .vault-secrets
  script:
    # Secret available as $API_TOKEN environment variable
    - curl -H "Authorization: Bearer $API_TOKEN" https://api.example.com
```

## Secret Outside GitLab Tree

To access secrets outside `/secret/gitlab/<group>/<project>/`:

1. Contact Platon team with:
   - GitLab project path
   - Required Vault path
   - Justification for access

2. Platon configures Vault policy

3. Access secret using configured path:

```yaml
secrets:
  SHARED_SECRET:
    token: $VAULT_ID_TOKEN
    vault: "shared/infrastructure/api-key@secret"
    file: false
```

## Security Redaction

The `deploy` script (from deploy component) automatically:
- Redacts Secret `data` values from job console output
- Prevents secret exposure in kubectl operations
- Masks sensitive values in logs

**Best Practice**: Always use Kubernetes Secrets as intermediary, not raw CI/CD variables in manifests.

## Managing Kubernetes Secrets

### Creating Secrets from Literals

```bash
kubectl create secret generic app-secrets \
  -n <namespace> \
  --from-literal=db-password=secret123 \
  --from-literal=api-key=abc789
```

### Creating Secrets from Files

```bash
kubectl create secret generic app-config \
  -n <namespace> \
  --from-file=config.yaml=/path/to/config.yaml
```

### Viewing Secrets (Base64 Encoded)

```bash
kubectl get secret app-secrets -n <namespace> -o yaml
```

### Decoding Secret Values

```bash
kubectl get secret app-secrets -n <namespace> -o jsonpath='{.data.db-password}' | base64 -d
```

## Updating Secrets

### Recreating/Replacing Secret

Delete and recreate:

```bash
kubectl delete secret app-secrets -n <namespace>
kubectl create secret generic app-secrets \
  -n <namespace> \
  --from-literal=db-password=newsecret123
```

Or use declarative approach in pipeline (recreates automatically).

### Modifying Existing Secret

```bash
# Get current secret
kubectl get secret app-secrets -n <namespace> -o yaml > secret.yaml

# Edit secret.yaml (update values)
# Note: Values must be base64 encoded

# Apply changes
kubectl apply -f secret.yaml
```

Alternative using kubectl edit:

```bash
kubectl edit secret app-secrets -n <namespace>
```

### When Updates Take Effect

**Important**: Existing pods don't automatically receive updated secrets.

To apply secret updates:
1. Update secret in Kubernetes
2. Restart pods:
   ```bash
   kubectl rollout restart deployment/<deployment-name> -n <namespace>
   ```

Or trigger via CI/CD pipeline redeployment.

## Complete Example

### .gitlab-ci.yml

```yaml
include:
  - component: $CI_SERVER_FQDN/platon/ci-components/docker/docker@2
  - component: $CI_SERVER_FQDN/platon/ci-components/deploy/deploy@1

variables:
  KUBE_PROD_DOMAIN: myapp.sikt.no
  KUBE_TEST_ID: myapp

.vault-secrets:
  id_tokens:
    VAULT_ID_TOKEN:
      aud: "https://vault.sikt.no:8200"
  secrets:
    DB_PASSWORD:
      token: $VAULT_ID_TOKEN
      vault: "gitlab/my-team/myapp/database/password@secret"
      file: false
    API_KEY:
      token: $VAULT_ID_TOKEN
      vault: "gitlab/my-team/myapp/external-api/key@secret"
      file: false

production:
  extends:
    - .production
    - .vault-secrets
  stage: production
  script:
    - deploy secret.yaml
    - deploy deployment.yaml
```

### secret.yaml

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: myapp-secrets
  namespace: $KUBE_NAMESPACE
type: Opaque
stringData:
  database-password: $DB_PASSWORD
  api-key: $API_KEY
```

### deployment.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp-$CI_ENVIRONMENT_SLUG
  namespace: $KUBE_NAMESPACE
spec:
  replicas: $REPLICAS
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: app
        image: $CI_REGISTRY_IMAGE:$CI_REGISTRY_TAG
        env:
        - name: DATABASE_PASSWORD
          valueFrom:
            secretKeyRef:
              name: myapp-secrets
              key: database-password
        - name: EXTERNAL_API_KEY
          valueFrom:
            secretKeyRef:
              name: myapp-secrets
              key: api-key
```

## Best Practices

1. **Use Kubernetes Secrets** as intermediary, not raw CI/CD variables
2. **Minimize secret scope** - only fetch needed secrets
3. **Rotate secrets regularly** and update in Vault
4. **Never log secrets** - rely on automatic redaction
5. **Use descriptive names** for secrets and keys
6. **Document secret locations** for team members
7. **Test secret access** in review environments first
8. **Restart pods** after secret updates
9. **Use file mounts** for large configurations
10. **Request minimal Vault permissions** needed

## Template Assets

### Complete Pipeline with Secrets

Use `assets/vault-secrets-example.gitlab-ci.yml` as complete working example.

Shows:
- Vault authentication
- Multiple secret types
- Secret usage in staging/production/review
- Proper deployment order

### Kubernetes Secret Template

Use `assets/secret-template.yaml` for creating secrets from Vault.

Demonstrates:
- Multiple secret fields
- Connection string construction
- Secret naming conventions

### Deployment with Secrets

Use `assets/deployment-with-secrets.yaml` for consuming secrets.

Shows two methods:
1. Environment variables from secrets
2. File mounts from secrets

Copy and customize these templates for your application.

## Example Projects

- [hello-world](https://gitlab.sikt.no/platon/paas2-examples/hello-world) - Basic secret usage
- [python-django](https://gitlab.sikt.no/platon/paas2-examples/python-django) - Database secrets
- See example projects for complete implementations

## Troubleshooting

### Vault Authentication Failed

Verify `VAULT_ID_TOKEN` configuration and audience URL.

### Secret Not Found

Check:
- Secret path is correct (remember `secret/` prefix is implied)
- Project has access to the path
- Secret exists in Vault

### Secret Not Updating in Pods

Restart deployment after secret update:
```bash
kubectl rollout restart deployment/<name> -n <namespace>
```

## Resources

- [GitLab CI/CD Secrets](https://docs.gitlab.com/ee/ci/secrets/)
- [Kubernetes Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)
- [Vault GitLab Integration](https://www.vaultproject.io/docs/auth/jwt)
- Contact Platon team for access requests
