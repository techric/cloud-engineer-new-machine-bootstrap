# cloud-engineer-new-machine-bootstrap

> ⚠️ **macOS only** — This toolchain is designed and tested for macOS. Linux and Windows are not supported.

Personal engineering toolchain setup and upgrade scripts for cloud engineers on macOS.
Supports AWS, GCP, and Azure — cloud agnostic by design.

---

## 1. What This Project Shows

- **Problem:** Setting up a new machine as a cloud engineer requires installing and configuring dozens of tools manually — a slow, error-prone process that varies between engineers.
- **Solution:** A single bootstrap command installs the full Kubernetes and cloud engineering toolchain via Homebrew, configures shell completions, and verifies every tool — pulled directly from this GitHub repo.
- **Impact:** New machine setup goes from hours of manual work to a single command. All tools upgrade with one command. Consistent tooling across every machine and every engineer.

---

## 2. How to Use

### New Machine Setup

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/techric/cloud-engineer-new-machine-bootstrap/main/bootstrap.sh)"
```

### Upgrade All Tools

Run this any time — after a vacation, after onboarding, or on a schedule:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/techric/cloud-engineer-new-machine-bootstrap/main/upgrade.sh)"
```

### After Setup

See [cloud-setup.md](cloud-setup.md) for post-install steps to connect to your cluster on GCP, AWS, or Azure.

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

| Tool | Category | Purpose |
|---|---|---|
| K9s | Kubernetes | Live cluster dashboard |
| Helm | Kubernetes | Package manager |
| Skaffold | Kubernetes | Build-push-deploy automation |
| Kubectx + Kubens | Kubernetes | Fast cluster and namespace switching |
| ArgoCD | Kubernetes | GitOps CLI |
| Stern | Kubernetes | Multi-pod log tailing |
| Taskfile | Automation | Modern Makefile replacement |
| Terraform | IaC | Infrastructure as Code (all clouds) |
| Vault CLI | Secrets | Secrets management |
| AWS CLI | Cloud | Amazon Web Services |
| Google Cloud SDK | Cloud | Google Cloud Platform |
| Azure CLI | Cloud | Microsoft Azure |
| git | Essentials | Version control |
| jq | Essentials | JSON parsing |
| yq | Essentials | YAML parsing |
| curl | Essentials | HTTP requests |
| wget | Essentials | File downloads |
| openssl | Essentials | Certificate management |
| Trivy | Security | Container and repo scanning |
| pre-commit | Security | Git hooks for commit checks |
| Lens | GUI | Kubernetes desktop UI |

---

## 5. Screenshots (Proof of Work)

*Add screenshots after running bootstrap on a new machine:*

- **a.** Terminal output — `bootstrap.sh` running and verifying all tools
- **b.** K9s dashboard — live Kubernetes cluster view after setup
- **c.** `kubectx` / `kubens` — switching between clusters and namespaces

---

## 6. Cost Note

All tools installed by this bootstrap are free and open source. No cloud resources are provisioned by this repo — it is a local machine setup tool only. No infrastructure charges apply.

**Security:** [Security Policy](SECURITY.md) • [Security Checklist](docs/security-checklist.md)

---

## 7. Repo Structure

```
/
├── bootstrap.sh            # New machine setup script
├── upgrade.sh              # Upgrade all tools script
├── Brewfile                # Source of truth — all tool definitions
├── cloud-setup.md          # Post-install cloud connection guide (AWS, GCP, Azure)
├── README.md               # Project description
├── SECURITY.md             # Security policy
└── docs/
    └── security-checklist.md  # Pre-commit security checklist
```

---

## About Me

Created by [Techric](https://github.com/techric) — a Cloud & DevSecOps Engineer dedicated to building secure, automated, and observable systems on AWS, GCP, and Azure.

Each project reflects my goal of turning technical exploration into clear, reproducible knowledge others can build upon. This repository documents real-world tooling from my professional experience, showcasing practical problem-solving, infrastructure mastery, and a commitment to continuous learning.
