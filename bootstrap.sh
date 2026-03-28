#!/bin/bash
# bootstrap.sh — Cloud Engineer Toolchain — New Machine Setup
# Usage: /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/techric/cloud-engineer-new-machine-bootstrap/main/bootstrap.sh)"
#
# ⚠️  macOS ONLY — This script requires Homebrew and is designed for macOS.
#     Linux and Windows are not supported.
#
# What this script does:
#   1. Installs Homebrew if not present
#   2. Installs all tools defined in the Brewfile
#   3. Configures shell completions for installed tools
#   4. Verifies all tools are working

set -e  # Exit immediately on any error

# ── Colors ─────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

# ── Helpers ────────────────────────────────────────────────────────────────
info()    { echo -e "${BLUE}[INFO]${RESET}  $1"; }
success() { echo -e "${GREEN}[OK]${RESET}    $1"; }
warn()    { echo -e "${YELLOW}[WARN]${RESET}  $1"; }
error()   { echo -e "${RED}[ERROR]${RESET} $1"; exit 1; }
header()  { echo -e "\n${BOLD}── $1 ──────────────────────────────────────${RESET}"; }

# ── macOS Check ────────────────────────────────────────────────────────────
if [[ "$(uname)" != "Darwin" ]]; then
  error "This script is designed for macOS only. Linux and Windows are not supported."
fi

# ── Banner ─────────────────────────────────────────────────────────────────
echo ""
echo -e "${BOLD}╔══════════════════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}║   Cloud Engineer Toolchain — New Machine Setup       ║${RESET}"
echo -e "${BOLD}║   github.com/techric/cloud-engineer-new-machine-bootstrap ║${RESET}"
echo -e "${BOLD}║   ⚠️  macOS only                                      ║${RESET}"
echo -e "${BOLD}╚══════════════════════════════════════════════════════╝${RESET}"
echo ""

# ── Step 1: Homebrew ───────────────────────────────────────────────────────
header "Step 1: Homebrew"

if command -v brew &>/dev/null; then
  success "Homebrew already installed — $(brew --version | head -1)"
  info "Updating Homebrew..."
  brew update
else
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add Homebrew to PATH for Apple Silicon Macs
  if [[ $(uname -m) == "arm64" ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  success "Homebrew installed successfully"
fi

# ── Step 2: Download Brewfile ──────────────────────────────────────────────
header "Step 2: Brewfile"

BREWFILE_URL="https://raw.githubusercontent.com/techric/cloud-engineer-new-machine-bootstrap/main/Brewfile"
BREWFILE_PATH="$(mktemp)"

info "Downloading Brewfile from GitHub..."
curl -fsSL "$BREWFILE_URL" -o "$BREWFILE_PATH" || error "Failed to download Brewfile"
success "Brewfile downloaded"

# ── Step 3: Install Tools ──────────────────────────────────────────────────
header "Step 3: Installing Tools"

info "Running brew bundle — this may take a few minutes..."
brew bundle --file="$BREWFILE_PATH"
success "All tools installed"

# ── Step 4: Shell Completions ──────────────────────────────────────────────
header "Step 4: Shell Completions"

SHELL_RC="$HOME/.zshrc"

# kubectl completion
if command -v kubectl &>/dev/null; then
  if ! grep -q "kubectl completion" "$SHELL_RC" 2>/dev/null; then
    echo 'source <(kubectl completion zsh)' >> "$SHELL_RC"
    success "kubectl completion added to $SHELL_RC"
  else
    success "kubectl completion already configured"
  fi
fi

# helm completion
if command -v helm &>/dev/null; then
  if ! grep -q "helm completion" "$SHELL_RC" 2>/dev/null; then
    echo 'source <(helm completion zsh)' >> "$SHELL_RC"
    success "helm completion added to $SHELL_RC"
  else
    success "helm completion already configured"
  fi
fi

# skaffold completion
if command -v skaffold &>/dev/null; then
  if ! grep -q "skaffold completion" "$SHELL_RC" 2>/dev/null; then
    echo 'source <(skaffold completion zsh)' >> "$SHELL_RC"
    success "skaffold completion added to $SHELL_RC"
  else
    success "skaffold completion already configured"
  fi
fi

# argocd completion
if command -v argocd &>/dev/null; then
  if ! grep -q "argocd completion" "$SHELL_RC" 2>/dev/null; then
    echo 'source <(argocd completion zsh)' >> "$SHELL_RC"
    success "argocd completion added to $SHELL_RC"
  else
    success "argocd completion already configured"
  fi
fi

# ── Step 5: Skaffold Telemetry ─────────────────────────────────────────────
header "Step 5: Skaffold Configuration"

if command -v skaffold &>/dev/null; then
  skaffold config set --global collect-metrics false
  success "Skaffold telemetry disabled"
fi

# ── Step 6: Verify Installations ──────────────────────────────────────────
header "Step 6: Verification"

declare -A TOOLS=(
  ["k9s"]="k9s version"
  ["helm"]="helm version --short"
  ["skaffold"]="skaffold version"
  ["kubectx"]="kubectx --version"
  ["kubens"]="kubens --version"
  ["task"]="task --version"
  ["terraform"]="terraform version"
  ["vault"]="vault --version"
  ["argocd"]="argocd version --client"
  ["stern"]="stern --version"
  ["aws"]="aws --version"
  ["gcloud"]="gcloud --version"
  ["az"]="az --version"
  ["git"]="git --version"
  ["jq"]="jq --version"
  ["yq"]="yq --version"
  ["trivy"]="trivy --version"
  ["pre-commit"]="pre-commit --version"
)

ALL_OK=true
for tool in "${!TOOLS[@]}"; do
  if command -v "$tool" &>/dev/null; then
    version=$(${TOOLS[$tool]} 2>/dev/null | head -1)
    success "$tool — $version"
  else
    warn "$tool — NOT FOUND"
    ALL_OK=false
  fi
done

# ── Done ───────────────────────────────────────────────────────────────────
echo ""
if [ "$ALL_OK" = true ]; then
  echo -e "${BOLD}${GREEN}╔══════════════════════════════════════════════╗${RESET}"
  echo -e "${BOLD}${GREEN}║   All tools installed successfully!          ║${RESET}"
  echo -e "${BOLD}${GREEN}╚══════════════════════════════════════════════╝${RESET}"
else
  echo -e "${BOLD}${YELLOW}╔══════════════════════════════════════════════╗${RESET}"
  echo -e "${BOLD}${YELLOW}║   Setup complete with warnings — check above ║${RESET}"
  echo -e "${BOLD}${YELLOW}╚══════════════════════════════════════════════╝${RESET}"
fi

echo ""
echo -e "${BOLD}Next steps:${RESET}"
echo "  1. Restart your terminal or run:  source ~/.zshrc"
echo ""
echo -e "${BOLD}  GCP:${RESET}"
echo "     gcloud auth login"
echo "     gcloud auth configure-docker"
echo "     gcloud container clusters get-credentials <cluster> --region <region> --project <project>"
echo ""
echo -e "${BOLD}  AWS:${RESET}"
echo "     aws configure"
echo "     aws eks update-kubeconfig --name <cluster> --region <region>"
echo ""
echo -e "${BOLD}  Azure:${RESET}"
echo "     az login"
echo "     az aks get-credentials --resource-group <rg> --name <cluster>"
echo ""
echo -e "${BOLD}  Then for all clouds:${RESET}"
echo "     kubectx <your-cluster-context>"
echo "     kubens <your-namespace>"
echo "     k9s"
echo ""

# Cleanup
rm -f "$BREWFILE_PATH"
