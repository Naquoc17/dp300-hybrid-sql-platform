# M1 — Deploy & Hybrid (Domain 1: L02, L03, L05)

🔄 In Progress

---

## Planned Tasks

| Task | Level | Artifact | Mode |
|------|-------|----------|------|
| M1.1 Offering decision | L02 | `runbook-offering-decision.md` | FLOW-ONLY |
| M1.2–M1.4 Deploy DB + VM | L02 | `../../infrastructure/main.bicep` + modules | HANDS-ON |
| M1.5 Patch + Arc/Fabric | L02 | `runbook-arc-fabric.md` | FLOW-ONLY |
| M1.6 Scale + auto-pause | L03 | `scale-config.sql` | HANDS-ON |
| M1.7 ROW/PAGE compression | L03 | `data-compression.sql` | HANDS-ON |
| M1.8 Migration DMA/DMS | L05 | `runbook-migration-DMA-DMS.md` | FLOW-ONLY |

---

## Script Inventory

| File | Status | What it demonstrates | How to run | Expected output |
|------|--------|---------------------|------------|----------------|
| `runbook-offering-decision.md` | ⏳ Planned | SQL DB vs MI vs SQL on VM decision tree | Read-only | Decision flowchart with signal words from DP-300 exam |
| `../../infrastructure/main.bicep` | ⏳ Planned | Idempotent Bicep deploy of full estate | `pwsh ../../scripts/deploy.ps1` | Resource group + logical server + sqldb-cap created |
| `runbook-arc-fabric.md` | ⏳ Planned | Azure Arc-enabled SQL + Fabric integration narration | Read-only | Step-by-step Arc agent install flow |
| `scale-config.sql` | ⏳ Planned | Scale vCores up/down + verify serverless auto-pause | Run in SSMS against sqldb-cap | `sys.database_service_objectives` shows new SLO |
| `data-compression.sql` | ⏳ Planned | ROW vs PAGE compression + before/after verification | Run in SSMS against sqldb-cap | `sys.partitions.data_compression_desc` changes from NONE → PAGE |
| `runbook-migration-DMA-DMS.md` | ⏳ Planned | DMA assess → DMS offline/online migrate flow | Read-only | End-to-end migration checklist |

---

Verification closes when: `sys.partitions` shows compression applied; `sys.database_service_objectives` reflects new SLO; Bicep deploys idempotently.
