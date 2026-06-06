# M1B — Partition & Shard (Domain 1: L04) — closes PI-01a / PI-01b

⏳ Planned

---

## Planned Tasks (ordered — must run in sequence)

| Step | Artifact | Mode |
|------|----------|------|
| 1 Build large table | `01-build-large-table.sql` | HANDS-ON |
| 2 Partition function | `02-partition-function.sql` | HANDS-ON |
| 3 Partition scheme | `03-partition-scheme.sql` | HANDS-ON |
| 4 Partitioned table | `04-partitioned-table.sql` | HANDS-ON |
| 5 Partition-elimination proof | `05-partition-elimination-proof.sql` | HANDS-ON |
| 6 Partition SWITCH | `06-partition-switch.sql` | HANDS-ON |
| 7 Create shards | `07-create-shards.sql` | HANDS-ON |
| 8 Shard Map Manager + elastic query | `08-shard-map-manager.sql` + `runbook-sharding.md` | HYBRID |

---

## Script Inventory

| File | Status | What it demonstrates | How to run | Expected output |
|------|--------|---------------------|------------|----------------|
| `01-build-large-table.sql` | ⏳ Planned | Creates SalesPartitioned (~5–10M rows) | Run in SSMS against sqldb-cap | Table with ~5M rows confirmed via COUNT |
| `02-partition-function.sql` | ⏳ Planned | Partition function with RANGE RIGHT boundary values | Run in SSMS | `sys.partition_functions` shows pfSalesYear |
| `03-partition-scheme.sql` | ⏳ Planned | Maps partitions to [PRIMARY] filegroup | Run in SSMS | `sys.partition_schemes` shows psSalesYear |
| `04-partitioned-table.sql` | ⏳ Planned | Creates table using the partition scheme on SaleYear | Run in SSMS | `sys.partitions` shows N partition rows |
| `05-partition-elimination-proof.sql` | ⏳ Planned | Proves partition elimination via execution plan | Run in SSMS, view actual plan | "Actual Partition Count" = 1 (not all partitions scanned) |
| `06-partition-switch.sql` | ⏳ Planned | SWITCH moves one partition — no data copy | Run in SSMS | SWITCH completes in milliseconds regardless of partition size |
| `07-create-shards.sql` | ⏳ Planned | Creates sqldb-shard-01/02/03 databases | Run in SSMS against logical server | Three shard databases appear in Portal |
| `08-shard-map-manager.sql` | ⏳ Planned | Registers shards + configures key-range routing | Run in SSMS | Elastic query returns rows from all three shards |
| `runbook-sharding.md` | ⏳ Planned | Narration of Shard Map Manager setup + exam signals | Read-only | Decision table: sharding vs partitioning |

---

Flags closed when: `sys.partitions` shows N partitions; actual execution plan shows partition elimination; SWITCH runs instantly; insert routes to correct shard; elastic query returns combined results.
