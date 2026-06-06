# M3 — Monitor & Optimize (Domain 3: L10–L13)

🔄 In Progress

---

## Tasks

| Task | Level | Artifact | Mode |
|------|-------|----------|------|
| M3.1 Baseline metrics capture | L10 | `baseline-metrics.sql` | HANDS-ON |
| M3.2 Database Watcher run-book | L10 | `runbook-database-watcher.md` | FLOW-ONLY |
| M3.3 Extended Events session | L10 | `xevents-session.sql` | HANDS-ON |
| M3.4 Query Store analysis | L11 | `query-store.sql` | HANDS-ON |
| M3.5 Blocking + DMV diagnosis | L11 | `blocking-dmvs.sql` | HANDS-ON |
| M3.6 Index + query rewrite | L11 | `index-and-rewrite.sql` | HANDS-ON |
| M3.7 Index + stats maintenance | L12 | `index-stats-maintenance.sql` | HANDS-ON |
| M3.8 DBCC integrity checks | L12 | `dbcc-integrity.sql` | HANDS-ON |
| M3.9 Auto-tuning + IQP config | L12 | `auto-tuning-iqp.sql` | HANDS-ON |
| M3.10 Resource Governor | L12 | `runbook-resource-governor.md` | FLOW-ONLY (IaaS only) |
| M3.11 Perf consolidation | L13 | `verify-perf-consolidation.sql` | HANDS-ON |
| Cleanup | — | `cleanup-xe-sessions.sql` | Utility |

---

## Script Inventory

| File | Status | What it demonstrates | How to run | Expected output |
|------|--------|---------------------|------------|----------------|
| `baseline-metrics.sql` | ✅ Complete | `sys.dm_db_resource_stats` (15-sec snapshots) + `sys.dm_exec_requests` (live sessions) | Run in SSMS against sqldb-cap | Two result sets: resource history + current sessions with query text |
| `cleanup-xe-sessions.sql` | ✅ Complete | Safe teardown of Extended Events sessions | Run in SSMS — idempotent | Any open XE sessions on the database are stopped and dropped |
| `xevents-session.sql` | ⏳ Planned | XE session: `sql_statement_completed` with duration > 500ms filter; ring_buffer target | Run in SSMS; start session; run test queries; read via GUI | SSMS Object Explorer → Extended Events → Sessions → View Target Data shows captured events |
| `runbook-database-watcher.md` | ⏳ Planned | Database Watcher setup: create watcher → add sqldb-cap → managed-identity grant → ADX/Fabric backing | Read-only | Full click-path + exam signal: multi-DB, long retention, no DMV query needed |
| `query-store.sql` | ⏳ Planned | Enable Query Store; find top resource consumers; compare plan regressions | Run in SSMS against sqldb-cap | `sys.query_store_query_text` + SSMS "Regressed Queries" GUI shows plan change |
| `blocking-dmvs.sql` | ⏳ Planned | Find current blocker + blocked sessions; identify wait types | Run in SSMS during simulated block | `sys.dm_exec_requests.blocking_session_id` > 0; `sys.dm_os_waiting_tasks` shows wait type |
| `index-and-rewrite.sql` | ⏳ Planned | Find missing indexes via DMV; create index; verify cost drops | Run in SSMS | `sys.dm_db_missing_index_details`; execution plan changes from Scan → Seek |
| `index-stats-maintenance.sql` | ⏳ Planned | Detect fragmentation; rebuild/reorganize based on threshold | Run in SSMS | `sys.dm_db_index_physical_stats` shows fragmentation; REBUILD/REORGANIZE per threshold |
| `dbcc-integrity.sql` | ⏳ Planned | DBCC CHECKDB (PHYSICAL_ONLY) + DBCC CHECKALLOC | Run in SSMS | No errors reported; messages show pages checked |
| `auto-tuning-iqp.sql` | ⏳ Planned | Enable FORCE_LAST_GOOD_PLAN auto-tuning; view recommendations | Run in SSMS | `sys.dm_db_tuning_recommendations` shows any recommendations applied |
| `runbook-resource-governor.md` | ⏳ Planned | Classifier function + resource pool + workload group (SQL on VM only) | Read-only (IaaS only) | Resource Governor limits ETL pool to 20% CPU, protecting OLTP |
| `verify-perf-consolidation.sql` | ⏳ Planned | Post-M3 audit: Query Store on, indexes healthy, auto-tuning active | Run in SSMS | All optimizations confirmed via sys catalog queries |

---

Flags closed when: `baseline-metrics.sql` returns data from live database (PI-03); database watcher run-book narrates full setup chain with correct exam signal (PI-04).
