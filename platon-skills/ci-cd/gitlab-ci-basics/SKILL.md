---
name: gitlab-ci-basics
description: This skill should be used when users need help with GitLab CI/CD pipeline configuration for Platon PaaS, including .gitlab-ci.yml structure, stages, variables, CI/CD components, and deployment workflows for review, staging, and production environments.
---

# GitLab CI/CD Basics for Platon PaaS

Configure GitLab CI/CD pipelines to build and deploy applications to Platon PaaS.

## Pipeline Overview

Pipelines are defined in `.gitlab-ci.yml` file in the repository root. This YAML file provides instructions to GitLab CI/CD defining:
- Structure and order of jobs
- Conditionals for job execution
- Commands to execute

**Important**: If any job fails (exit status != 0), the entire pipeline fails and subsequent jobs (like deployment) won't execute.

## Using CI/CD Components

**Recommended**: Use CI/CD components from [CI/CD Catalog](https://gitlab.sikt.no/explore/catalog) maintained by Platon.

### Components vs gitlab-ci-helpers

CI/CD components replace legacy `gitlab-ci-helpers`:
- Versioned with semantic versioning
- Safer and easier updates
- Better discovery via CI/CD Catalog
- Same variables as gitlab-ci-helpers (except `only/except` → `rules`)

## Basic .gitlab-ci.yml Structure

### 1. Include Components

Import reusable CI/CD components:

```yaml
include:
  - component: $CI_SERVER_FQDN/platon/ci-components/docker/docker@2
  - component: $CI_SERVER_FQDN/platon/ci-components/imagescan/imagescan@2
  - component: $CI_SERVER_FQDN/platon/ci-components/deploy/deploy@1
```

`$CI_SERVER_FQDN` is the GitLab instance hostname. Components can only reference same GitLab instance.

### 2. Define Variables

Set crucial environment variables:

```yaml
variables:
  KUBE_PROD_DOMAIN: hello.sikt.no
  KUBE_TEST_ID: hello
  HTTP_PORT: '80'
  REPLICAS: '1'
```

**Variable Descriptions**:
- `KUBE_PROD_DOMAIN`: FQDN for production application
- `KUBE_TEST_ID`: Used to generate test instance URLs
  - Staging: `$KUBE_TEST_ID-staging.sokrates.edupaas.no`
  - Review: `$KUBE_TEST_ID-review-<auto-string>.sokrates.edupaas.no`
- `HTTP_PORT`: Port for load balancer routing (TLS terminated by Ingress controller)
- `REPLICAS`: Number of replicas (typically 1 for testing, override to 2 for production)

**⚠️ Domain Change**: Default domain changed from `*.paas2.uninett.no` to `*.sokrates.edupaas.no` (Feb 2025). Use `sikt.no` domain for production services.

### 3. Define Stages

Set execution order for pipeline jobs:

```yaml
stages:
  - build
  - test
  - review
  - staging
  - production
```

**Execution Rules**:
- Jobs in a stage run in parallel
- All jobs in a stage must complete before next stage starts

## Pipeline Jobs

### Build Stage

Build Docker container:

```yaml
build:
  extends: .platon-docker-build
  stage: build
```

Extends `.platon-docker-build` from [docker component](https://gitlab.sikt.no/explore/catalog/platon/ci-components/docker). Runs on every commit to any branch.

### Test Stage

Scan container for vulnerabilities:

```yaml
imagescan:
  extends: .platon-imagescan
  stage: test
```

Extends [imagescan component](https://gitlab.sikt.no/explore/catalog/platon/ci-components/imagescan). Runs on every commit.

### Staging Stage

Deploy to staging environment:

```yaml
staging:
  extends: .staging
  stage: staging
  rules:
    - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH
  script:
    - deploy deployment.yaml
```

- Extends `.staging` from [deploy component](https://gitlab.sikt.no/explore/catalog/platon/ci-components/deploy)
- Runs only on default branch (main/master)
- Continuous deployment when all previous stages pass
- Uses `deploy` script from [kubernetes-deploy](https://gitlab.sikt.no/asm/kubernetes-deploy)

### Production Stage

Deploy to production:

```yaml
production:
  extends: .production
  stage: production
  variables:
    REPLICAS: "2"
  rules:
    - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH
  script:
    - deploy deployment.yaml
```

- Extends `.production` from deploy component
- Runs only on default branch
- Requires manual intervention (no continuous deployment)
- Overrides REPLICAS to 2 for high availability

### Review Stage

Deploy review environments for feature branches:

```yaml
review:
  extends: .review
  stage: review
  script:
    - deploy deployment.yaml
  rules:
    - if: $CI_COMMIT_BRANCH != $CI_DEFAULT_BRANCH
```

- Runs on non-default branches
- Continuous deployment for branches
- Allows testing changes without affecting staging/production
- URL: `$KUBE_TEST_ID-review-$CI_ENVIRONMENT_SLUG.sokrates.edupaas.no`

### Stop Review

Manually delete review environments:

```yaml
stop_review:
  extends: .stop_review
  stage: review
```

- Manual job to delete review deployments
- Automatically triggered when branch is deleted (e.g., after merge)

## Additional Configuration

### Manual Destroy for Staging/Production

Add manual destruction jobs (not enabled by default to prevent accidents):

```yaml
stop_staging:
  extends: .stop_staging
  stage: staging

stop_production:
  extends: .stop_production
  stage: production
```

Use for:
- Application removal/decommissioning
- Superseded applications
- Critical security vulnerabilities requiring immediate removal

## Component Versioning

Pin components to major version:

```yaml
include:
  - component: $CI_SERVER_FQDN/platon/ci-components/deploy/deploy@1
```

This imports latest version with major version 1. Can also pin to minor or patch versions.

See [Semantic Version Ranges](https://docs.gitlab.com/ee/ci/components/#semantic-version-ranges) for details.

## Component Inputs

Configure components with inputs:

```yaml
include:
  - component: https://gitlab.sikt.no/platon/ci-components/imagescan/imagescan@2
    inputs:
      image: myimage
      image_tag: mytag
```

Or use variables:

```yaml
imagescan:
  extends: .platon-imagescan
  variables:
    CI_REGISTRY_TAG: mytag
```

### Multiple Jobs from Same Component

Cannot import same component multiple times with different inputs. Instead:

**Option 1 - Multiple jobs**:
```yaml
imagescan-frontend:
  extends: .platon-imagescan
  variables:
    CI_REGISTRY_TAG: frontend

imagescan-backend:
  extends: .platon-imagescan
  variables:
    CI_REGISTRY_TAG: backend
```

**Option 2 - Parallel matrix**:
```yaml
imagescan:
  extends: .platon-imagescan
  parallel:
    matrix:
      - CI_REGISTRY_TAG:
        - frontend
        - backend
```

## Rules vs only/except

Components use `rules` instead of deprecated `only/except`.

**Migration Example**:

```yaml
# Old (only/except)
only:
  - branches
except:
  - master
  - main

# New (rules)
rules:
  - if: $CI_COMMIT_BRANCH != $CI_DEFAULT_BRANCH
```

**Preventing merge request pipelines**:

```yaml
rules:
  - if: $CI_COMMIT_BRANCH != $CI_DEFAULT_BRANCH && $CI_PIPELINE_SOURCE != "merge_request_event"
```

## Migrating from gitlab-ci-helpers

Replace this:

```yaml
include:
  - project: 'asm/gitlab-ci-helpers'
    file: '/gitlab-ci-helpers.yml'
```

With this:

```yaml
include:
  - component: $CI_SERVER_FQDN/platon/ci-components/docker/docker@2
  - component: $CI_SERVER_FQDN/platon/ci-components/imagescan/imagescan@2
  - component: $CI_SERVER_FQDN/platon/ci-components/deploy/deploy@1
```

Update job template names:

```yaml
# Old
build:
  extends: .docker-build

# New
build:
  extends: .platon-docker-build
```

## Template Assets

### Minimal Pipeline Template

Use `assets/minimal-paas-deployment.gitlab-ci.yml` as starting point for new projects.

Includes:
- Docker build
- Image scanning
- Staging deployment
- Production deployment (manual)
- Review environments

### Kubernetes Deployment Template

Use `assets/deployment-template.yaml` for application deployments.

Includes:
- Health checks (liveness/readiness)
- Resource limits
- Environment variable examples
- Standard labels

Copy these templates and customize for your application.

## Example Projects

- [hello-world](https://gitlab.sikt.no/platon/paas2-examples/hello-world) - Minimal example
- [hello-world-cicd-components](https://gitlab.sikt.no/platon/paas2-examples/hello-world-cicd-components) - CI/CD components example
- [python-hello](https://gitlab.sikt.no/platon/paas2-examples/python-hello) - Python application
- [python-django](https://gitlab.sikt.no/platon/paas2-examples/python-django) - Django application

## GitLab Runners

Three shared GitLab CI/CD runners available with docker-in-docker (dind) capability.

For large workloads or high security requirements, consider dedicated runner for specific projects.

## References

- [GitLab CI/CD Quick Start](https://docs.gitlab.com/ee/ci/quick_start/index.html)
- [YAML Keyword Reference](https://docs.gitlab.com/ee/ci/yaml/)
- [GitLab CI Examples](https://docs.gitlab.com/ee/ci/examples/index.html)
- [Platon CI/CD Components](https://docs.gitlab.com/ee/ci/components/)
