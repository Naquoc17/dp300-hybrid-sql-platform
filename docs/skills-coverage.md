# Skills Coverage — DP-300 Script-to-Skill Map

Every artifact in this repo maps to at least one DP-300 exam sub-skill and one real-world DBA scenario.
Use this document to walk an interviewer through the project.

Status key: ✅ Complete · 🔄 In Progress · ⏳ Planned

---

## M1 — Deploy & Hybrid (Domain 1)

| Artifact | Status | DP-300 Sub-skill | Real-world Scenario | Interview Talking Point |
|----------|--------|-----------------|---------------------|------------------------|
| `runbook-offering-decision.md` | ⏳ | Recommend a database offering for given requirements | Customer asks: "SQL DB or Managed Instance?" | Walk through the decision tree: SQL Agent / CLR / cross-DB queries → MI; everything else → SQL DB |
| `infrastructure/main.bicep` | ⏳ | Identify and implement an automated deployment method | Repeatable, version-controlled infra deploy for every environment | "I can redeploy the entire estate from one Bicep file — no manual portal clicks" |
| `scale-config.sql` | ⏳ | Configure Azure SQL Database for scale and performance | Production DB hitting vCore ceiling during peak load | Scale up vCores with no app code change; verify via `sys.database_service_objectives` |
| `data-compression.sql` | ⏳ | Configure data compression | Large historical table consuming excessive storage | ROW vs PAGE tradeoff: PAGE saves more space at slight CPU cost; verify via `sys.partitions` |
| `runbook-migration-DMA-DMS.md` | ⏳ | Evaluate and implement migration strategy | On-prem SQL Server → Azure SQL DB with minimal downtime | DMA assess first, fix issues, then DMS online migration for near-zero-downtime cutover |

---

## M1B — Partition & Shard (Domain 1)

| Artifact | Status | DP-300 Sub-skill | Real-world Scenario | Interview Talking Point |
|----------|--------|-----------------|---------------------|------------------------|
| `01-build-large-table.sql` | ⏳ | Plan for table partitioning | Staging environment for partitioning lab | Build a 5–10M row SalesPartitioned table that realistically demonstrates elimination |
| `02-partition-function.sql` | ⏳ | Configure table partitioning | Partition a multi-year sales table by SaleYear | Partition function defines boundary values only — RANGE RIGHT means boundary is the start of the right partition |
| `03-partition-scheme.sql` | ⏳ | Configure table partitioning | Map partitions to filegroups/storage | One function can back multiple schemes — shows layered design |
| `04-partitioned-table.sql` | ⏳ | Configure table partitioning | Create the final partitioned table | Table references the scheme, not the function directly — three-object chain |
| `05-partition-elimination-proof.sql` | ⏳ | Configure table partitioning | Prove partitioning delivers a query perf benefit | Read execution plan: "Actual Partition Count" shows only relevant partitions scanned |
| `06-partition-switch.sql` | ⏳ | Configure table partitioning | Archive old partition (sliding-window pattern) | SWITCH is metadata-only — no data copy, instant even on billions of rows |
| `07-create-shards.sql` | ⏳ | Recommend a database sharding solution | Multi-tenant SaaS at massive scale | Sharding vs partitioning: sharding splits across databases; partitioning splits within one |
| `08-shard-map-manager.sql` / `runbook-sharding.md` | ⏳ | Recommend a database sharding solution | Route writes/reads to correct shard automatically | Shard Map Manager is the query router — app connects to it, not individual shards |

---

## M2 — Secure (Domain 2)

| Artifact | Status | DP-300 Sub-skill | Real-world Scenario | Interview Talking Point |
|----------|--------|-----------------|---------------------|------------------------|
| `entra-auth.sql` | ⏳ | Configure Microsoft Entra ID authentication | Org wants SSO with no SQL passwords | `CREATE USER [email] FROM EXTERNAL PROVIDER` — no LOGIN needed; Entra handles auth externally |
| `least-privilege-roles.sql` | ⏳ | Configure security principals; implement least privilege | Read-only analyst + read/write app account | Always `db_datareader` or custom role, never `db_owner`; `ALTER ROLE ... ADD MEMBER` (not GRANT) |
| `tde-check.sql` | ⏳ | Implement Transparent Data Encryption | Verify encryption status before compliance audit | TDE is on by default in Azure SQL; verify with `sys.databases` `is_encrypted` column |
| `always-encrypted.sql` / `runbook-ae.md` | ⏳ | Implement object-level encryption | PII column (SSN, credit card) that even DBAs must not see | Always Encrypted = client-side; DBA sees ciphertext; key stays in Key Vault; app needs special driver |
| `firewall-rules.sql` | ⏳ | Configure server and database firewall rules | Allow only app server IP; block everything else | Server-level rule = all DBs; database-level = one DB. "Allow Azure services" for Azure-to-Azure |
| `data-classification.sql` | ⏳ | Implement a data classification strategy | GDPR compliance — identify all PII columns | Classification is metadata only; combine with auditing to track access to sensitive columns |
| `auditing.sql` | ⏳ | Configure server and database audits | Audit all logins + SELECT on sensitive tables | Server-level audit covers all DBs; database-level is additive |
| `ct-cdc.sql` | ⏳ | Configure change tracking and change data capture | App needs to sync only changed rows to downstream | CT = lightweight, tracks which rows changed (not old values). CDC = full before/after row history |
| `ddm.sql` | ⏳ | Implement dynamic data masking | Call-centre staff must see last 4 digits only | DDM masks the display; real data in storage unchanged; `GRANT UNMASK` for privileged users |
| `ledger.sql` | ⏳ | Configure ledger in Azure SQL | Financial audit requires tamper-evident history | Chained SHA-256 hashes; stored outside SQL in Blob; changing one row breaks the entire chain |
| `rls-patient-doctor.sql` | ⏳ | Implement row-level security | Each doctor sees only their own patients' records | Same `SELECT * FROM Patients` returns different rows per login — filter is invisible to user |
| `verify-security-consolidation.sql` | ⏳ | Troubleshoot authentication and authorization | Post-deployment security audit | Validate all security objects (policies, masks, classifications) are applied correctly |

---

## M3 — Monitor & Optimize (Domain 3)

| Artifact | Status | DP-300 Sub-skill | Real-world Scenario | Interview Talking Point |
|----------|--------|-----------------|---------------------|------------------------|
| `baseline-metrics.sql` | ✅ | Prepare an operational performance baseline | Record healthy-state metrics before a migration | Captures `sys.dm_db_resource_stats` (15-sec snapshots) + `sys.dm_exec_requests` (live sessions) |
| `cleanup-xe-sessions.sql` | ✅ | Monitor with Extended Events | Teardown script for XE labs | Separation of concerns: working scripts never contain DROP statements |
| `xevents-session.sql` | ⏳ | Monitor with Extended Events | Catch all queries slower than 500ms | XE replaces deprecated SQL Profiler; `ring_buffer` = in-memory; file target → Blob Storage on Azure SQL DB |
| `runbook-database-watcher.md` | ⏳ | Monitor with Database Watcher | One portal for 10+ Azure SQL databases with 90-day retention | Watcher vs DMVs: DMVs = ~1hr history; watcher = long-term, multi-DB, no query needed |
| `query-store.sql` | ⏳ | Configure and monitor Query Store | Identify performance regression after an index change | Query Store captures plans over time; "Regressed Queries" view shows before/after |
| `blocking-dmvs.sql` | ⏳ | Identify and resolve session blocking | App reports timeouts; DBA must find the blocker | `sys.dm_exec_requests` + `blocking_session_id`; `sys.dm_os_waiting_tasks` for wait analysis |
| `index-and-rewrite.sql` | ⏳ | Identify and implement index changes | Table scan on a 10M-row table; missing index DMV suggests a fix | `sys.dm_db_missing_index_details`; create index; verify cost drops in execution plan |
| `index-stats-maintenance.sql` | ⏳ | Implement index maintenance | Weekly rebuild/reorganize job for fragmented indexes | Fragmentation > 30% → REBUILD; 10–30% → REORGANIZE; update statistics after |
| `dbcc-integrity.sql` | ⏳ | Configure database integrity checks | Scheduled DBCC CHECKDB before backup | `DBCC CHECKDB` with `PHYSICAL_ONLY` for speed on large DBs; always run before DR test |
| `auto-tuning-iqp.sql` | ⏳ | Configure automatic tuning | Azure SQL auto-apply index recommendations | Enable `FORCE_LAST_GOOD_PLAN`; verify via `sys.dm_db_tuning_recommendations` |
| `runbook-resource-governor.md` | ⏳ | Configure server settings for optimal performance | SQL-on-VM: isolate ETL workload from OLTP | Resource Governor classifies sessions into pools with CPU/memory caps |
| `verify-perf-consolidation.sql` | ⏳ | Monitor and optimize overall performance | End-to-end performance audit after all optimizations | Verify Query Store, index health, auto-tuning state, and baseline delta |

---

## M4 — Automate (Domain 4)

| Artifact | Status | DP-300 Sub-skill | Real-world Scenario | Interview Talking Point |
|----------|--------|-----------------|---------------------|------------------------|
| `agent-maintenance-job.sql` | ⏳ | Create and manage SQL Server Agent jobs | Nightly index rebuild + statistics update on VM DB | SQL Agent = IaaS only; Azure SQL DB uses Elastic Jobs instead |
| `agent-alerts.sql` | ⏳ | Configure job alerts and notifications | Email DBA when CPU alert fires or job fails | Alert operator + job failure alert; links to Database Mail for SMTP |
| `deploy.ps1` | ⏳ | Deploy resources by using Azure PowerShell | Script the full estate deployment for a new environment | `New-AzResourceGroupDeployment` wraps the Bicep; idempotent — safe to rerun |
| `deploy.azcli` | ⏳ | Deploy resources by using Azure CLI | Same deployment from a Linux CI agent | `az deployment group create --template-file main.bicep` |
| `elastic-job-setup.sql` | ⏳ | Create and configure elastic jobs | Run nightly maintenance across all three shard databases | Elastic Jobs = the Azure SQL DB equivalent of SQL Agent; target groups replace loopback scripts |
| `elastic-job-target-shards.sql` | ⏳ | Create and configure elastic jobs | Add shards to the elastic job target group dynamically | Show how a new shard auto-joins the maintenance group |
| `runbook-automation-troubleshoot.md` | ⏳ | Troubleshoot automated database tasks | Elastic job fails on shard-02 only | Check `jobs.job_executions` in the elastic job agent database for error details |

---

## M5 — HA/DR (Domain 5)

| Artifact | Status | DP-300 Sub-skill | Real-world Scenario | Interview Talking Point |
|----------|--------|-----------------|---------------------|------------------------|
| `runbook-hadr-decision.md` | ⏳ | Recommend an HA/DR strategy based on RPO/RTO | CTO asks: "What's our plan if West Europe goes down?" | RPO=0 → Always On sync-commit or zone-redundant. Cross-region → geo-replication or failover group |
| `runbook-dr-test-procedure.md` | ⏳ | Plan a testing procedure for an HA/DR solution | Compliance requires annual DR test | Steps: initiate failover → verify app connects → fail back → document RTO achieved |
| `pitr-restore.md` | ⏳ | Perform backup and restore by using native tools | Developer dropped a table at 14:32; restore to 14:31 | PITR = automatic in Azure SQL DB (7–35 day retention); Portal → Restore → point in time |
| `ltr-policy.md` | ⏳ | Configure long-term backup retention | Compliance requires 7-year backup retention | LTR copies weekly/monthly/yearly backups to Blob automatically; PITR max is 35 days |
| `backup-to-url.sql` | ⏳ | Back up and restore a database by using T-SQL | SQL-on-VM needs backup to Azure Blob | `BACKUP DATABASE ... TO URL = 'https://...'` with SAS credential |
| `failover-group.md` | ⏳ | Configure a failover group | Single endpoint for app after cross-region failover | Failover group = active geo-rep + automatic/manual failover + single listener DNS name |
| `geo-replication.md` | ⏳ | Configure active geo-replication | Read offload to secondary in another region | Geo-rep = async, readable secondary; failover group adds auto-failover on top |
| `log-shipping.sql` | ⏳ | Configure log shipping | SQL-on-VM DR to standby server with 15-min RPO | Log shipping = backup → copy → restore loop; readable standby with delay option |
| `runbook-ag-fci-flowonly.md` | ⏳ | Configure Always On AGs / FCIs on Azure VMs | Enterprise on-VM HA with sync replication | AG = high availability (sync-commit); FCI = shared-disk cluster. Both IaaS-only, complex setup |
| `hadr-monitoring.sql` | ⏳ | Monitor an HA/DR solution | Ops team asks: "Is our failover group healthy right now?" | `sys.dm_geo_replication_link_status`; replication lag; `sys.availability_replicas` for AG |
| `runbook-hadr-troubleshoot.md` | ⏳ | Troubleshoot an HA/DR solution | Failover group not replicating after a network event | Check replication lag DMV; verify firewall allows port 1433 between regions |
