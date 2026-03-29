#!/bin/bash
# Upgrades all tools in the Brewfile to their latest versions.
# Run this after a vacation, before a big project, or whenever things feel stale.
#
# Run it:
#   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/techric/cloud-engineer-new-machine-bootstrap/main/upgrade.sh)"
#   or just: ./upgrade.sh

set -e

[[ "$(uname)" != "Darwin" ]] && echo "macOS only. Exiting." && exit 1

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RESET='\033[0m'

ok()   { echo -e "${GREEN}✓${RESET} $1"; }
warn() { echo -e "${YELLOW}!${RESET} $1"; }

TOOLS=(k9s helm skaffold kubectx task terraform vault argocd stern aws az gcloud git jq yq trivy pre-commit)

echo ""
echo "==> Cloud Engineer Toolchain — Upgrade"
echo ""

# Snapshot versions before we change anything so we can show a diff at the end
declare -A BEFORE
for t in "${TOOLS[@]}"; do
  if command -v "$t" &>/dev/null; then
    BEFORE[$t]=$("$t" --version 2>/dev/null | head -1 || "$t" version 2>/dev/null | head -1 || echo "unknown")
  else
    BEFORE[$t]="not installed"
  fi
done

echo "==> Updating Homebrew..."
brew update

# Pull the latest Brewfile and run bundle upgrade
BREWFILE=$(mktemp)
curl -fsSL "https://raw.githubusercontent.com/techric/cloud-engineer-new-machine-bootstrap/main/Brewfile" -o "$BREWFILE"
echo "==> Upgrading tools..."
brew bundle --file="$BREWFILE" --upgrade
rm -f "$BREWFILE"

echo "==> Cleaning up old versions..."
brew cleanup

# Show what actually changed
echo ""
echo "==> Summary"
echo ""
CHANGED=0
for t in "${TOOLS[@]}"; do
  if command -v "$t" &>/dev/null; then
    AFTER=$("$t" --version 2>/dev/null | head -1 || "$t" version 2>/dev/null | head -1 || echo "unknown")
    if [[ "${BEFORE[$t]}" != "$AFTER" ]]; then
      echo -e "  ${GREEN}↑ $t${RESET}"
      echo "      before: ${BEFORE[$t]}"
      echo "      after:  $AFTER"
      CHANGED=$((CHANGED + 1))
    else
      ok "$t — up to date"
    fi
  else
    warn "$t — still not found (check Brewfile)"
  fi
done

echo ""
[[ $CHANGED -gt 0 ]] && echo "$CHANGED tool(s) upgraded." || echo "Everything already up to date."
echo ""
