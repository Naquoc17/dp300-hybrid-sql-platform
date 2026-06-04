# infrastructure/modules

Reusable Bicep modules, authored during M1 (and reused in M4 automation):

| File | Resource | Built in |
|------|----------|----------|
| `sql-logical-server.bicep` | Logical server `sql-dp300-cap` + Entra admin | M1 |
| `sql-database.bicep` | Azure SQL DB `sqldb-cap` (serverless, Free offer) | M1 |
| `sql-vm.bicep` | SQL Server on Azure VM `vm-dp300-sql` (B-series, auto-shutdown) | M1 |
| `firewall-rules.bicep` | Server-level firewall rules | M1 / M2 |

Not pre-written — authored step by step at the lesson.
