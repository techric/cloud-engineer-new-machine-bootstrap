# cloud-engineer-new-machine-bootstrap

> ⚠️ **macOS only** — This toolchain is designed and tested for macOS. Linux and Windows are not supported.

Personal engineering toolchain setup and upgrade scripts for cloud engineers on macOS.
Supports AWS, GCP, and Azure — cloud agnostic by design.

---

## 1. What This Project Shows

* **Problem:** Setting up a new machine as a cloud engineer requires installing and configuring dozens of tools manually — a slow, error-prone process that varies between engineers.
* **Solution:** A single bootstrap command installs the full Kubernetes and cloud engineering toolchain via Homebrew, configures shell completions, and verifies every tool — pulled directly from this GitHub repo.
* **Impact:** New machine setup goes from hours of manual work to a single command. All tools upgrade with one command. Consistent tooling across every machine and every engineer.

---

## 2. How to Use

### New Machine Setup

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/techric/cloud-engineer-new-machine-bootstrap/main/bootstrap.sh)"
```

### Upgrade All Tools

Run this any time — after a vacation, after onboarding, or on a schedule:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/techric/cloud-engineer-new-machine-bootstrap/main/upgrade.sh)"
```

### After Setup

See [cloud-setup.md](https://github.com/techric/cloud-engineer-new-machine-bootstrap/blob/main/cloud-setup.md) for post-install steps to connect to your cluster on GCP, AWS, or Azure.

---

## 3. Architecture

```
GitHub Repo (source of truth)
        |
        v
bootstrap.sh / upgrade.sh
        |
        v
Brewfile (tool definitions)
        |
        v
Homebrew (package manager)
        |
   _____|________________________________________
  |           |           |           |          |
  v           v           v           v          v
K8s Tools   IaC        Cloud CLIs  Security   GUI
K9s         Vault      AWS CLI     Trivy      Lens
Helm        Terraform  GCP SDK     pre-commit
Skaffold    Taskfile   Azure CLI
Kubectx
ArgoCD
Stern
```

---

## 4. Tools Included

| Tool | Category | Purpose | Docs |
| --- | --- | --- | --- |
| K9s | Kubernetes | Live cluster dashboard | [k9scli.io](https://k9scli.io) |
| Helm | Kubernetes | Package manager | [helm.sh](https://helm.sh) |
| Skaffold | Kubernetes | Build-push-deploy automation | [skaffold.dev](https://skaffold.dev) |
| Kubectx + Kubens | Kubernetes | Fast cluster and namespace switching | [github.com/ahmetb/kubectx](https://github.com/ahmetb/kubectx) |
| ArgoCD | Kubernetes | GitOps CLI | [argo-cd.readthedocs.io](https://argo-cd.readthedocs.io) |
| Stern | Kubernetes | Multi-pod log tailing | [github.com/stern/stern](https://github.com/stern/stern) |
| Taskfile | Automation | Modern Makefile replacement | [taskfile.dev](https://taskfile.dev) |
| Terraform | IaC | Infrastructure as Code (all clouds) | [terraform.io](https://www.terraform.io) |
| Vault CLI | Secrets | Secrets management | [vaultproject.io](https://www.vaultproject.io) |
| AWS CLI | Cloud | Amazon Web Services | [aws.amazon.com/cli](https://aws.amazon.com/cli) |
| Google Cloud SDK | Cloud | Google Cloud Platform (includes GCP CLI and other related tools) | [cloud.google.com/sdk](https://cloud.google.com/sdk) |
| Azure CLI | Cloud | Microsoft Azure | [learn.microsoft.com/cli/azure](https://learn.microsoft.com/en-us/cli/azure) |
| git | Essentials | Version control | [git-scm.com](https://git-scm.com) |
| jq | Essentials | JSON parsing | [jqlang.github.io/jq](https://jqlang.github.io/jq) |
| yq | Essentials | YAML parsing | [github.com/mikefarah/yq](https://github.com/mikefarah/yq) |
| curl | Essentials | HTTP requests | [curl.se](https://curl.se) |
| wget | Essentials | File downloads | [gnu.org/software/wget](https://www.gnu.org/software/wget) |
| openssl | Essentials | Certificate management | [openssl.org](https://www.openssl.org) |
| Trivy | Security | Container and repo scanning | [aquasecurity.github.io/trivy](https://aquasecurity.github.io/trivy) |
| pre-commit | Security | Git hooks for commit checks | [pre-commit.com](https://pre-commit.com) |
| Lens | GUI | Kubernetes desktop UI | [k8slens.dev](https://k8slens.dev) |

---

## 5. Screenshots (Proof of Work)

*Add screenshots after running bootstrap on a new machine:*

* **a.** Terminal output — `bootstrap.sh` running and verifying all tools
* **b.** K9s dashboard — live Kubernetes cluster view after setup
* **c.** `kubectx` / `kubens` — switching between clusters and namespaces

---

## 6. Cost Note

All tools installed by this bootstrap are free and open source. No cloud resources are provisioned by this repo — it is a local machine setup tool only. No infrastructure charges apply.

**Security:** [Security Policy](https://github.com/techric/cloud-engineer-new-machine-bootstrap/blob/main/SECURITY.md) • [Security Checklist](https://github.com/techric/cloud-engineer-new-machine-bootstrap/blob/main/security-checklist.md)

---

## 7. Repo Structure

```
/
├── bootstrap.sh          # New machine setup script
├── upgrade.sh            # Upgrade all tools script
├── Brewfile              # Source of truth — all tool definitions
├── cloud-setup.md        # Post-install cloud connection guide (AWS, GCP, Azure)
├── security-checklist.md # Pre-commit security checklist
├── README.md             # Project description
└── SECURITY.md           # Security policy
```

---

## About Me

Created by [Techric](https://github.com/techric) — a Cloud Engineer dedicated to building secure, automated, and observable systems on AWS, GCP, and Azure.

Each project reflects my goal of turning technical exploration into clear, reproducible knowledge others can build upon. This repository documents real-world tooling from my professional experience, showcasing practical problem-solving, infrastructure mastery, and a commitment to continuous learning.
