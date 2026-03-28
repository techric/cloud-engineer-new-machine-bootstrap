# Cloud Setup Guide

> ⚠️ **macOS only** — This guide assumes you have run `bootstrap.sh` on a Mac.

Post-install steps for connecting to your Kubernetes cluster.
Follow the section for your cloud provider — or all three if you work across multiple clouds.

---

## GCP — Google Cloud Platform

### Authenticate
```bash
gcloud auth login
gcloud auth configure-docker
```

### Set your project
```bash
gcloud config set project <your-gcp-project-id>
```

### Connect to your GKE cluster
```bash
gcloud container clusters get-credentials <cluster-name> \
  --region <region> \
  --project <project-id>
```

### Verify
```bash
kubectl get nodes
```

---

## AWS — Amazon Web Services

### Authenticate
```bash
aws configure
```
You will be prompted for:
- AWS Access Key ID
- AWS Secret Access Key
- Default region (e.g. `us-east-1`)
- Default output format (`json`)

### Connect to your EKS cluster
```bash
aws eks update-kubeconfig \
  --name <cluster-name> \
  --region <region>
```

### Verify
```bash
kubectl get nodes
```

---

## Azure — Microsoft Azure

### Authenticate
```bash
az login
```

### Set your subscription
```bash
az account set --subscription <subscription-id>
```

### Connect to your AKS cluster
```bash
az aks get-credentials \
  --resource-group <resource-group> \
  --name <cluster-name>
```

### Verify
```bash
kubectl get nodes
```

---

## All Clouds — After Connecting

Once connected to any cluster, the workflow is identical regardless of cloud provider:

```bash
# List available clusters
kubectx

# Switch to your cluster
kubectx <your-cluster-context>

# List available namespaces
kubens

# Switch to your namespace
kubens <your-namespace>

# Open K9s
k9s
```

---

## Working Across Multiple Clouds

All three cloud provider contexts are stored in `~/.kube/config` automatically. Use `kubectx` to switch between them instantly:

```bash
kubectx                        # list all available contexts
kubectx my-gke-cluster         # switch to GCP
kubectx my-eks-cluster         # switch to AWS
kubectx my-aks-cluster         # switch to Azure
kubectx -                      # switch back to previous context
```

`kubectl`, `helm`, `skaffold`, and `k9s` all follow the active context automatically — no other changes needed.
