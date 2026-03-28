# Security Checklist

Use this checklist before committing any changes to this repository.

---

## Code & Secrets

- [ ] No credentials, tokens, API keys, or passwords in any file
- [ ] No hardcoded cloud account IDs, project IDs, or subscription IDs
- [ ] No hardcoded cluster names, namespace names, or internal hostnames
- [ ] No `.env` files committed
- [ ] `.gitignore` covers common secret file patterns (`.env`, `*.pem`, `*.key`, `*credentials*`)

---

## Scripts

- [ ] All scripts use `set -e` to fail fast on errors
- [ ] All external URLs in scripts point to official, verified sources only
- [ ] No `curl | bash` patterns without pinned versions or checksum verification
- [ ] Scripts do not store sensitive output in log files
- [ ] No hardcoded paths that are specific to a single machine or user

---

## Brewfile & Tools

- [ ] All tools are installed from official Homebrew taps only
- [ ] No unofficial or unverified third-party taps added without review
- [ ] Tool versions are not pinned to known vulnerable versions

---

## Dependencies

- [ ] Homebrew is up to date before running `brew bundle`
- [ ] All installed tools are from the latest stable release
- [ ] No deprecated or unmaintained tools in the Brewfile

---

## Documentation

- [ ] README does not contain any sensitive information
- [ ] `cloud-setup.md` does not contain real cluster names, project IDs, or account numbers
- [ ] Screenshots in `docs/screenshots/` do not expose sensitive data, account IDs, or internal URLs

---

## GitHub Repository Settings

- [ ] Repository visibility is set correctly (public or private)
- [ ] Branch protection enabled on `main`
- [ ] No secrets stored in GitHub Actions secrets that are not needed
- [ ] Dependabot alerts enabled
- [ ] Secret scanning enabled
