# Brewfile — source of truth for the cloud engineering toolchain.
#
# Note: Brewfile syntax is Ruby-based — that's just how Homebrew's bundle
# format works. There's no custom Ruby code here; these are standard
# Homebrew declarations. See: https://github.com/Homebrew/homebrew-bundle
#
# Install everything: brew bundle
# Upgrade everything: brew bundle --upgrade

# Kubernetes
brew "k9s"
brew "helm"
brew "skaffold"
brew "kubectx"           # also installs kubens
brew "argocd"
brew "stern"

# IaC / secrets
brew "go-task/tap/go-task"
brew "hashicorp/tap/terraform"
brew "hashicorp/tap/vault"

# Cloud CLIs
cask "google-cloud-sdk"  # includes gcloud, gsutil, kubectl
brew "awscli"
brew "azure-cli"

# General tools every cloud engineer needs
brew "git"
brew "curl"
brew "wget"
brew "jq"
brew "yq"
brew "openssl"
brew "pre-commit"
brew "trivy"

# GUI
cask "lens"
