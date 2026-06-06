# M5 — HA/DR (Domain 5: L17–L20)

⏳ Planned

> ⚠️ COST: failover group secondary and geo-replication secondary are billed like a primary. Provision only during a dedicated lab session and tear down immediately. Managed Instance, Always On AG (multi-node), and FCI stay FLOW-ONLY (never provisioned).

---

## Planned Tasks

| Task | Level | Artifact | Mode |
|------|-------|----------|------|
| M5.1 RPO/RTO decision matrix | L17 | `runbook-hadr-decision.md` | FLOW-ONLY |
| M5.2 DR test procedure | L17 | `runbook-dr-test-procedure.md` | FLOW-ONLY |
| M5.3 PITR restore | L18 | `pitr-restore.md` | FLOW-ONLY (portal-only in Azure SQL DB) |
| M5.4 LTR policy | L18 | `ltr-policy.md` | FLOW-ONLY |
| M5.5 Backup to URL | L18 | `backup-to-url.sql` | HANDS-ON (on vm-dp300-sql) |
| M5.6 Failover group | L19 | `failover-group.md` | FLOW-ONLY (paid burst if run hands-on) |
| M5.7 Geo-replication | L19 | `geo-replication.md` | FLOW-ONLY (paid burst if run hands-on) |
| M5.8 Log shipping | L19 | `log-shipping.sql` | HANDS-ON (on vm-dp300-sql) |
| M5.9 Always On AG + FCI | L19 | `runbook-ag-fci-flowonly.md` | FLOW-ONLY |
| M5.10 HA/DR monitoring | L20 | `hadr-monitoring.sql` | HANDS-ON |
| M5.10 HA/DR troubleshoot | L20 | `runbook-hadr-troubleshoot.md` | FLOW-ONLY |

---

## Script Inventory

| File | Status | What it demonstrates | How to run | Expected output |
|------|--------|---------------------|------------|----------------|
| `runbook-hadr-decision.md` | ⏳ Planned | RPO/RTO decision matrix: AG vs failover group vs geo-rep vs log shipping | Read-only | Decision table with exam signal words → answer mapping |
| `runbook-dr-test-procedure.md` | ⏳ Planned | Step-by-step DR test: initiate failover → verify app → fail back → document RTO | Read-only | Reusable test runbook for compliance evidence |
| `pitr-restore.md` | ⏳ Planned | Point-in-time restore via Azure Portal (automatic backups, 7–35 day retention) | Read-only | Portal click-path: SQL Database → Restore → select timestamp |
| `ltr-policy.md` | ⏳ Planned | Configure Long-Term Retention: weekly/monthly/yearly backup copies to Blob | Read-only | Portal: Backups blade → Long-term retention policy settings |
| `backup-to-url.sql` | ⏳ Planned | `BACKUP DATABASE ... TO URL` with SAS credential on vm-dp300-sql | Run in SSMS against vm-dp300-sql | Backup file appears in Azure Blob Storage container |
| `failover-group.md` | ⏳ Planned | Create failover group (manual failover demo); single listener endpoint | Read-only | Listener DNS name stays constant after failover — app reconnects automatically |
| `geo-replication.md` | ⏳ Planned | Add readable secondary to sqldb-cap in a different region | Read-only | `sys.geo_replication_links` shows active replication; readable replica accepts SELECT |
| `log-shipping.sql` | ⏳ Planned | Configure log shipping on vm-dp300-sql: backup job → copy job → restore job | Run in SSMS against vm-dp300-sql | Secondary DB in STANDBY/NORECOVERY; log restores confirm replication |
| `runbook-ag-fci-flowonly.md` | ⏳ Planned | Always On AG (sync-commit, intra-region) + FCI (shared-disk cluster) narration | Read-only | Architecture diagram + exam signal words for AG vs FCI vs failover group |
| `hadr-monitoring.sql` | ⏳ Planned | DMV queries: geo-replication lag, AG replica health, failover group status | Run in SSMS | `sys.dm_geo_replication_link_status` shows replication lag; replica state confirmed |
| `runbook-hadr-troubleshoot.md` | ⏳ Planned | Diagnose replication lag, failover group not syncing, AG secondary not readable | Read-only | Troubleshooting decision tree with DMV queries per scenario |

---

Verification closes when: `backup-to-url.sql` runs successfully on VM; `hadr-monitoring.sql` returns valid replication status; all runbooks narrate the correct exam-day decision path.
