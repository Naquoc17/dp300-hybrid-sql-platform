# M1B — Partition & Shard (Domain 1: L04) — closes PI-01a / PI-01b

Ordered flow:

| Step | Planned artifact | Mode |
|------|------------------|------|
| 1 Build large table | `01-build-large-table.sql` | HANDS-ON |
| 2 Partition function | `02-partition-function.sql` | HANDS-ON |
| 3 Partition scheme | `03-partition-scheme.sql` | HANDS-ON |
| 4 Partitioned table | `04-partitioned-table.sql` | HANDS-ON |
| 5 Partition-elimination proof | `05-partition-elimination-proof.sql` | HANDS-ON |
| 6 Partition SWITCH | `06-partition-switch.sql` | HANDS-ON |
| 7 Create shards | `07-create-shards.sql` | HANDS-ON |
| 8 Shard Map Manager + elastic query | `08-shard-map-manager.sql`, `runbook-sharding.md` | HYBRID |

Verification (closes the flags): `sys.partitions` shows N partitions; actual plan shows partition elimination; `SWITCH` moves a partition with no data copy; insert routes to the correct shard; elastic query returns rows from all shards.

Flag registry: vault `Capstone/Flagged-Practice-Items.md` (PI-01a, PI-01b).
