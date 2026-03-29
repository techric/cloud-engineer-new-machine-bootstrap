#!/bin/bash
# New machine setup — installs the cloud engineering toolchain via Homebrew.
# Designed for macOS only. Won't work on Linux or Windows.
#
# Run it:
#   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/techric/cloud-engineer-new-machine-bootstrap/main/bootstrap.sh)"

set -e

[[ "$(uname)" != "Darwin" ]] && echo "macOS only. Exiting." && exit 1

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RESET='\033[0m'

ok()   { echo -e "${GREEN}✓${RESET} $1"; }
warn() { echo -e "${YELLOW}!${RESET} $1"; }

echo ""
echo "==> Cloud Engineer Toolchain — New Machine Setup"
echo ""

# Install Homebrew if it's not there
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Apple Silicon needs this to put brew on PATH before we can use it
  if [[ $(uname -m) == "arm64" ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  echo "Homebrew found — updating..."
  brew update
fi

# Pull the Brewfile from GitHub and install everything in it
BREWFILE=$(mktemp)
curl -fsSL "https://raw.githubusercontent.com/techric/cloud-engineer-new-machine-bootstrap/main/Brewfile" -o "$BREWFILE"
echo ""
echo "==> Installing tools from Brewfile (this takes a few minutes)..."
brew bundle --file="$BREWFILE"
rm -f "$BREWFILE"

# Shell completions — tab-complete for kubectl, helm, skaffold, argocd
# Only adds to .zshrc if not already there
ZSHRC="$HOME/.zshrc"
for tool in kubectl helm skaffold argocd; do
  if command -v "$tool" &>/dev/null && ! grep -q "${tool} completion" "$ZSHRC" 2>/dev/null; then
    echo "source <(${tool} completion zsh)" >> "$ZSHRC"
    ok "$tool completion added"
  fi
done

# Skaffold phones home by default — turn that off
command -v skaffold &>/dev/null && skaffold config set --global collect-metrics false

echo ""
echo "==> Verifying installs..."
echo ""

TOOLS=(k9s helm skaffold kubectx kubens task terraform vault argocd stern aws gcloud az git jq yq trivy pre-commit)
MISSING=()

for t in "${TOOLS[@]}"; do
  if command -v "$t" &>/dev/null; then
    ok "$t"
  else
    warn "$t — not found"
    MISSING+=("$t")
  fi
done

echo ""
if [[ ${#MISSING[@]} -eq 0 ]]; then
  echo "All tools installed. You're good to go."
else
  echo "Setup done but some tools are missing: ${MISSING[*]}"
  echo "Try running: brew bundle"
fi

echo ""
echo "Next steps:"
echo "  source ~/.zshrc"
echo ""
echo "  GCP:   gcloud auth login && gcloud container clusters get-credentials <cluster> --region <region> --project <project>"
echo "  AWS:   aws configure && aws eks update-kubeconfig --name <cluster> --region <region>"
echo "  Azure: az login && az aks get-credentials --resource-group <rg> --name <cluster>"
echo ""
echo "  Then: kubectx <cluster>  →  kubens <namespace>  →  k9s"
echo ""
