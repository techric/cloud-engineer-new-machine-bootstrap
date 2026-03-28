#!/bin/bash
# upgrade.sh — Cloud Engineer Toolchain — Upgrade All Tools
# Usage: /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/techric/cloud-engineer-new-machine-bootstrap/main/upgrade.sh)"
# Or if already cloned: ./upgrade.sh
#
# ⚠️  macOS ONLY — This script requires Homebrew and is designed for macOS.
#     Linux and Windows are not supported.
#
# What this script does:
#   1. Updates Homebrew
#   2. Upgrades all tools defined in the Brewfile to latest versions
#   3. Cleans up old versions
#   4. Reports what changed

set -e

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
echo -e "${BOLD}║   Cloud Engineer Toolchain — Upgrade All Tools       ║${RESET}"
echo -e "${BOLD}║   github.com/techric/cloud-engineer-new-machine-bootstrap ║${RESET}"
echo -e "${BOLD}║   ⚠️  macOS only                                      ║${RESET}"
echo -e "${BOLD}╚══════════════════════════════════════════════════════╝${RESET}"
echo ""

# ── Capture versions before upgrade ───────────────────────────────────────
declare -A BEFORE
TOOLS=("k9s" "helm" "skaffold" "kubectx" "task" "terraform" "vault" "argocd" "stern" "aws" "az" "gcloud" "git" "jq" "yq" "trivy" "pre-commit")

header "Current Versions"
for tool in "${TOOLS[@]}"; do
  if command -v "$tool" &>/dev/null; then
    BEFORE[$tool]=$(${tool} --version 2>/dev/null | head -1 || ${tool} version 2>/dev/null | head -1 || echo "unknown")
    info "$tool — ${BEFORE[$tool]}"
  else
    BEFORE[$tool]="not installed"
    warn "$tool — not installed (will be installed)"
  fi
done

# ── Step 1: Update Homebrew ────────────────────────────────────────────────
header "Step 1: Updating Homebrew"
brew update
success "Homebrew updated"

# ── Step 2: Download latest Brewfile ──────────────────────────────────────
header "Step 2: Fetching Latest Brewfile"

BREWFILE_URL="https://raw.githubusercontent.com/techric/cloud-engineer-new-machine-bootstrap/main/Brewfile"
BREWFILE_PATH="$(mktemp)"

info "Downloading latest Brewfile from GitHub..."
curl -fsSL "$BREWFILE_URL" -o "$BREWFILE_PATH" || error "Failed to download Brewfile"
success "Brewfile downloaded"

# ── Step 3: Upgrade All Tools ─────────────────────────────────────────────
header "Step 3: Upgrading Tools"

info "Running brew bundle upgrade — this may take a few minutes..."
brew bundle --file="$BREWFILE_PATH" --upgrade
success "All tools upgraded"

# ── Step 4: Cleanup ────────────────────────────────────────────────────────
header "Step 4: Cleanup"

info "Removing old versions..."
brew cleanup
success "Cleanup complete"

# ── Step 5: Report Changes ─────────────────────────────────────────────────
header "Step 5: Upgrade Summary"

CHANGED=false
for tool in "${TOOLS[@]}"; do
  if command -v "$tool" &>/dev/null; then
    AFTER=$(${tool} --version 2>/dev/null | head -1 || ${tool} version 2>/dev/null | head -1 || echo "unknown")
    if [ "${BEFORE[$tool]}" != "$AFTER" ]; then
      echo -e "  ${GREEN}↑ $tool${RESET}"
      echo -e "    Before: ${BEFORE[$tool]}"
      echo -e "    After:  $AFTER"
      CHANGED=true
    else
      success "$tool — already up to date (${AFTER})"
    fi
  fi
done

# ── Done ───────────────────────────────────────────────────────────────────
echo ""
if [ "$CHANGED" = true ]; then
  echo -e "${BOLD}${GREEN}╔══════════════════════════════════════════════╗${RESET}"
  echo -e "${BOLD}${GREEN}║   Upgrade complete — tools updated!          ║${RESET}"
  echo -e "${BOLD}${GREEN}╚══════════════════════════════════════════════╝${RESET}"
else
  echo -e "${BOLD}${GREEN}╔══════════════════════════════════════════════╗${RESET}"
  echo -e "${BOLD}${GREEN}║   All tools already up to date!              ║${RESET}"
  echo -e "${BOLD}${GREEN}╚══════════════════════════════════════════════╝${RESET}"
fi
echo ""

# Cleanup
rm -f "$BREWFILE_PATH"
