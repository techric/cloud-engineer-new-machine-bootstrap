# Brewfile — Cloud Engineer Toolchain
# Source of truth for all tools.
# Used by bootstrap.sh (new machine setup) and upgrade.sh (upgrades).
#
# ⚠️  macOS ONLY — This Brewfile requires Homebrew and is designed for macOS.
#     Linux and Windows are not supported by this bootstrap.
#
# To install manually: brew bundle
# To upgrade manually: brew bundle --upgrade

# ── Core Kubernetes Tools ──────────────────────────────────────────────────
brew "k9s"                      # Kubernetes live dashboard (terminal UI)
brew "helm"                     # Kubernetes package manager
brew "skaffold"                 # Build-push-deploy automation for K8s
brew "kubectx"                  # Fast cluster and namespace switching (includes kubens)
brew "argocd"                   # GitOps CLI — deploy and manage ArgoCD applications
brew "stern"                    # Multi-pod log tailing for Kubernetes

# ── Infrastructure & Automation ───────────────────────────────────────────
brew "go-task/tap/go-task"      # Taskfile — modern Makefile replacement
brew "hashicorp/tap/terraform"  # Infrastructure as Code (AWS, GCP, Azure)
brew "hashicorp/tap/vault"      # Secrets management CLI

# ── Cloud Provider CLIs ───────────────────────────────────────────────────
cask "google-cloud-sdk"         # GCP — gcloud, gsutil, kubectl
brew "awscli"                   # AWS — aws CLI
brew "azure-cli"                # Azure — az CLI

# ── Universal CLI Essentials ──────────────────────────────────────────────
brew "git"                      # Version control
brew "curl"                     # HTTP requests and script reliability
brew "wget"                     # File downloads
brew "jq"                       # JSON parsing — essential for cloud CLI output
brew "yq"                       # YAML parsing — essential for K8s manifests
brew "openssl"                  # Certificate and key management
brew "pre-commit"               # Git hooks — runs checks before every commit
brew "trivy"                    # Security scanning for containers and repos

# ── GUI Tools ─────────────────────────────────────────────────────────────
cask "lens"                     # Kubernetes desktop GUI
