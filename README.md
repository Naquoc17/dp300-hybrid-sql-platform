# dp300-hybrid-sql-platform

Hands-on build project for **DP-300 — Administering Microsoft Azure SQL Solutions**. A small production-like hybrid SQL estate that I build from scratch, one capstone module at a time, as I learn each exam topic.

This repo is the **build layer**. The **learn / track layer** lives in my Obsidian vault — see the plan, the level-by-level Skills Coverage Matrix, and the flagged-practice registry:
- Plan: [`DP-300-HybridSQLPlatform-Project-Plan.md`](../../Documents/mySecondBrain/1%20-%20Source%20Material/AI-Workspaces/ClaudeAI/Programming/Cloud%20Infrastructure/Azure/DP-300%20-%20Administering%20Microsoft%20Azure%20SQL%20Solutions/Notes/DP-300-HybridSQLPlatform-Project-Plan.md)
- Flag registry: `…/DP-300 - Administering Microsoft Azure SQL Solutions/Capstone/Flagged-Practice-Items.md`
- Resource + cost tracker: `…/DP-300-HybridSQLPlatform-Resources-Tracker.md`

## Stack

Administration, not app development: **T-SQL + Bicep + PowerShell/Azure CLI + run-books. No Python.**

## Architecture

```
Resource Group: rg-dp300-capstone
  ├── sql-dp300-cap          (logical server)
  │      ├── sqldb-cap       (Azure SQL DB, serverless, AdventureWorksLT)
  │      │      └── SalesPartitioned (large partitioned table)
  │      └── sqldb-shard-01 / -02 / -03   (shard set + Shard Map Manager)
  └── vm-dp300-sql           (SQL Server on Azure VM, B-series, auto-shutdown)
```

## Modules → exam domains

| Module | Folder | Domain | Levels |
|--------|--------|--------|--------|
| M1 — Deploy & Hybrid | `modules/M1-deploy-hybrid/` | 1 Plan & Implement | L02, L03, L05 |
| M1B — Partition & Shard | `modules/M1B-partition-shard/` | 1 Plan & Implement | L04 |
| M2 — Secure | `modules/M2-secure/` | 2 Secure Environment | L06–L09 |
| M3 — Monitor & Optimize | `modules/M3-monitor-optimize/` | 3 Monitor/Optimize | L10–L13 |
| M4 — Automate | `modules/M4-automate/` | 4 Automation | L14–L16 |
| M5 — HA/DR | `modules/M5-hadr/` | 5 HA/DR | L17–L20 |

## Layout

```
infrastructure/   IaC for the hybrid estate (Bicep)
modules/          T-SQL + run-books, one folder per capstone module
scripts/          cross-cutting helpers (deploy.ps1, connect.ps1)
sample-data/      how to load AdventureWorksLT + build SalesPartitioned
docs/             verification checklists
```

## How I build (incremental, from scratch)

For each level: do the lesson → open the matching `modules/<M>/` folder → author the script one step at a time → run/verify against the live `sqldb-cap` → `git commit` → update the vault trackers and close any flagged-practice item. Nothing is written ahead of the lesson.

Every `.sql` opens with a header:

```sql
-- Module:    <M#>
-- Level:     <L##>
-- Sub-skill: <exam sub-skill>
-- Mode:      HANDS-ON | FLOW-ONLY | HYBRID
-- Teardown:  <how to remove any paid resource, or "none">
```

## Quick start

1. `az login` (use the personal/student Azure account, not a work account).
2. Deploy the estate: `pwsh scripts/deploy.ps1` (wraps the Bicep in `infrastructure/`).
3. Connect: `pwsh scripts/connect.ps1` or SSMS / Azure Data Studio to `sql-dp300-cap.database.windows.net`.

## Cost

Free Azure SQL DB offer + B-series VM with auto-shutdown. Paid items (failover group secondary, SQL-on-VM, shard DBs) are short bursts torn down same session; Managed Instance / Always On AG / FCI stay flow-only (narrated, never provisioned). Log every cost in the vault Cost Tracker.
