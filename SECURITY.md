# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability in this repository, please do not open a public GitHub issue.

Instead, report it directly via GitHub's private vulnerability reporting:
1. Go to the **Security** tab of this repository
2. Click **Report a vulnerability**
3. Provide as much detail as possible

I will respond within **72 hours** and work to address the issue promptly.

---

## Security Principles

This repository follows these security principles:

- **No secrets in code** — credentials, tokens, API keys, and passwords are never committed to this repository
- **No hardcoded cloud account IDs** — all account-specific values are parameterized
- **Least privilege** — all IAM roles and service accounts follow least-privilege principles
- **Open source tools only** — all tools installed by this bootstrap are from verified, widely-adopted open source projects
- **Verified sources** — all tools are installed via Homebrew from official taps only

---

## Supported Versions

This repository is maintained as a single `main` branch. Always use the latest version from `main`.

| Version | Supported |
|---|---|
| main | ✓ |
| Older commits | ✗ |

---

## Dependencies

All tools are installed via Homebrew. Security updates for individual tools are handled by running:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/techric/cloud-engineer-new-machine-bootstrap/main/upgrade.sh)"
```

This pulls the latest versions of all tools defined in the `Brewfile`.
