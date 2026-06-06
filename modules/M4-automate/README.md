# M4 — Automate (Domain 4: L14–L16)

⏳ Planned

---

## Planned Tasks

| Task | Level | Artifact | Mode |
|------|-------|----------|------|
| M4.1 SQL Agent job + alerts | L14 | `agent-maintenance-job.sql`, `agent-alerts.sql` | HANDS-ON (on vm-dp300-sql) |
| M4.2 Bicep + PowerShell deploy | L15 | reuse `../../infrastructure/`, `deploy.ps1` | HANDS-ON |
| M4.3 Azure CLI deploy | L15 | `deploy.azcli` | HANDS-ON |
| M4.4 Elastic job across shards | L16 | `elastic-job-setup.sql`, `elastic-job-target-shards.sql` | HANDS-ON |
| M4.5 Automation troubleshoot | L16 | `runbook-automation-troubleshoot.md` | FLOW-ONLY |

---

## Script Inventory

| File | Status | What it demonstrates | How to run | Expected output |
|------|--------|---------------------|------------|----------------|
| `agent-maintenance-job.sql` | ⏳ Planned | Create SQL Server Agent job: nightly index rebuild on vm-dp300-sql | Run in SSMS against vm-dp300-sql | Job appears in SQL Server Agent → Jobs; manual start completes successfully |
| `agent-alerts.sql` | ⏳ Planned | Job failure alert + operator notification via Database Mail | Run in SSMS against vm-dp300-sql | Alert fires on simulated job failure; operator configured |
| `../../scripts/deploy.ps1` | ⏳ Planned | Full Bicep estate deployment via PowerShell | `pwsh scripts/deploy.ps1` | Resource group + server + sqldb-cap deployed idempotently |
| `../../scripts/deploy.azcli` | ⏳ Planned | Same deployment via Azure CLI (cross-platform) | `bash scripts/deploy.azcli` or `pwsh` | Identical outcome to deploy.ps1 — shows both automation paths |
| `elastic-job-setup.sql` | ⏳ Planned | Create elastic job agent + job database; define nightly stats job | Run in SSMS against sqldb-cap | Job agent appears in Portal; `jobs.jobs` table shows the job definition |
| `elastic-job-target-shards.sql` | ⏳ Planned | Add shard databases to elastic job target group | Run in SSMS | Job runs against all three shards; `jobs.job_executions` shows per-shard results |
| `runbook-automation-troubleshoot.md` | ⏳ Planned | Diagnose elastic job / SQL Agent failures; check execution history | Read-only | Query patterns against `jobs.job_executions` + SQL Agent error log |

---

Note: SQL Agent lives on `vm-dp300-sql` (IaaS). Elastic Jobs cover `sqldb-cap` + shard set (PaaS) — the Azure SQL DB equivalent of SQL Agent.
