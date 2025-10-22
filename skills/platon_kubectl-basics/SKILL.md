---
name: kubectl-basics
description: This skill should be used when users need help with kubectl commands for Platon PaaS, including configuration, viewing resources, examining deployments, pods, and retrieving logs from Kubernetes clusters.
---

# kubectl Basics for Platon PaaS

Command-line access and basic operations for Platon PaaS Kubernetes cluster using kubectl.

## Prerequisites

Access to the PaaS Kubernetes API with `kubectl` requires connection to a [Sikt network](https://isikt.sharepoint.com/sites/it-stotte/SitePages/IP-adresser-i-Sikts-lokalnett.aspx).

## Installing kubectl

Follow [Kubernetes official documentation](https://kubernetes.io/docs/tasks/tools/install-kubectl/) for installation instructions.

Verify installation:
```bash
kubectl
# Should display usage instructions
```

## Configuring kubectl

### Getting Configuration

1. Go to [Platon PaaS console](https://console.paas.sikt.no/)
2. Click "Log in" (top right)
3. Click "Kube config" button
4. Copy commands from "Shell config" section

### Applying Configuration

Run the provided commands:
```bash
kubectl config set-cluster paas2 --server=https://38B1D1609274C2E9AB111FAB92F8B185.gr7.eu-north-1.eks.amazonaws.com
kubectl config set clusters.paas2.certificate-authority-data LS0tLS1CRUdJTiBDRVJUSU[...]
kubectl config set-credentials username --token=eyJ0eXA[...]
kubectl config set-context paas2-username --user=username --cluster=paas2
kubectl config use-context paas2-username
```

### Verifying Connection

```bash
kubectl version
# Should show both Client and Server versions
```

If "Server Version" appears, connection is successful.

### Refreshing Token

**Important**: Fetch new token when accessing new projects or groups created after current token was issued.

## Locating Your Project

Each GitLab project has its own Kubernetes namespace.

### Finding Namespace

1. Go to [Platon PaaS console](https://console.paas.sikt.no/)
2. Search for your project
3. Click project to see details
4. Note the "Kubernetes Namespace" value

Example: `platon-kurs-username-website`

### Using Namespace

Provide namespace to kubectl with `-n` option:
```bash
kubectl -n <namespace> <command>
```

Example:
```bash
kubectl -n platon-kurs-username-website get all
```

## Viewing Resources

### List All Resources

```bash
kubectl -n <namespace> get all
```

**Note**: Despite the name, `get all` only shows a subset of resources. It excludes:
- Secrets (cannot be listed for security)
- Ingresses (not listed by default)

### List Specific Resource Types

```bash
# Pods
kubectl -n <namespace> get pods

# Deployments
kubectl -n <namespace> get deployments

# Services
kubectl -n <namespace> get services

# Ingresses
kubectl -n <namespace> get ingresses

# Secrets (requires permissions)
kubectl -n <namespace> get secrets
```

## Examining Resources

### Two Main Commands

1. **kubectl get [type]**: List resources
2. **kubectl describe [type] [name]**: Show detailed information

### Examples

List deployments:
```bash
kubectl -n <namespace> get deployments
```

Describe specific deployment:
```bash
kubectl -n <namespace> describe deployment production
```

View resource in YAML format:
```bash
kubectl -n <namespace> get deployment production -o yaml
```

View resource in JSON format:
```bash
kubectl -n <namespace> get deployment production -o json
```

## Key Resource Types

### Deployment
Tells Kubernetes to run a set of container images. Manages pod creation and updates.

### Pod
Runs actual container images. Consists of one or more containers. Created automatically by deployments.

### Service
Exposes pods internally within cluster or externally.

### Ingress
Manages external access to services, typically HTTP/HTTPS routing.

## Viewing Logs

### Get Pod Name

```bash
kubectl -n <namespace> get pods
```

### View Logs

```bash
kubectl -n <namespace> logs <pod-name>
```

### Useful Options

```bash
# Follow logs (like tail -f)
kubectl -n <namespace> logs <pod-name> -f

# Last N lines
kubectl -n <namespace> logs <pod-name> --tail=100

# Previous container instance (after crash)
kubectl -n <namespace> logs <pod-name> --previous

# Specific container in multi-container pod
kubectl -n <namespace> logs <pod-name> -c <container-name>

# Logs since time duration
kubectl -n <namespace> logs <pod-name> --since=1h
```

## Getting Shell Access

Execute shell inside running container:

```bash
kubectl -n <namespace> exec -it <pod-name> -- /bin/bash
```

Or for Alpine-based containers (using sh):
```bash
kubectl -n <namespace> exec -it <pod-name> -- /bin/sh
```

For multi-container pods, specify container:
```bash
kubectl -n <namespace> exec -it <pod-name> -c <container-name> -- /bin/bash
```

## Kubectl Debug

Debug running pods or create debug containers:

```bash
# Debug a pod
kubectl -n <namespace> debug <pod-name> -it --image=busybox

# Debug with different image
kubectl -n <namespace> debug <pod-name> -it --image=ubuntu --target=<container-name>
```

## Port Forwarding

Forward local port to pod:

```bash
kubectl -n <namespace> port-forward <pod-name> <local-port>:<pod-port>
```

Example - forward local 8080 to pod's 80:
```bash
kubectl -n <namespace> port-forward pod/production-dfb888cd-h85nx 8080:80
```

Access via http://localhost:8080

Forward to service instead of specific pod:
```bash
kubectl -n <namespace> port-forward service/production 8080:80
```

## Common Troubleshooting Commands

### Check pod status and events
```bash
kubectl -n <namespace> describe pod <pod-name>
```

### View recent events in namespace
```bash
kubectl -n <namespace> get events --sort-by='.lastTimestamp'
```

### Check resource usage
```bash
kubectl -n <namespace> top pods
kubectl -n <namespace> top nodes
```

### View all resources including custom resources
```bash
kubectl -n <namespace> get all,ingress,secrets,configmaps
```

## Helper Scripts

### Verify PaaS Access

Use the provided script to check cluster connectivity:

```bash
scripts/check_paas_access.sh [namespace]
```

Checks:
- kubectl installation
- Cluster connectivity
- Namespace access
- Pod, deployment, service counts
- Ingress hosts

### Get Pod Logs

Simplified log retrieval script:

```bash
scripts/get_pod_logs.sh <namespace> [pod-pattern] [tail-lines] [follow]
```

Features:
- Pattern matching for pod names
- Multi-container support
- Automatic log tailing
- Status summary

## Pro Tips

1. Use `-o wide` for more detailed output:
   ```bash
   kubectl -n <namespace> get pods -o wide
   ```

2. Watch resources update in real-time:
   ```bash
   kubectl -n <namespace> get pods --watch
   ```

3. Use `-o yaml` or `-o json` to see complete resource definition

4. Set default namespace to avoid -n every time:
   ```bash
   kubectl config set-context --current --namespace=<namespace>
   ```

5. Use labels to filter resources:
   ```bash
   kubectl -n <namespace> get pods -l app=production
   ```
