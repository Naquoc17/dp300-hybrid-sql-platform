# scripts

Cross-cutting helpers (authored when first needed):

| Script | Purpose | Built in |
|--------|---------|----------|
| `deploy.ps1` | Wrap `az deployment group create` over `infrastructure/main.bicep` | M1 |
| `connect.ps1` | sqlcmd / connection helper to `sql-dp300-cap` | M1 |
| `deploy.azcli` | Azure CLI equivalent of the Bicep deploy | M4 (L15) |

No secrets in scripts — Entra ID auth (`az login`) or Key Vault for any password.
