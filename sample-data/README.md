# sample-data

How the lab data gets into `sqldb-cap`:

- **AdventureWorksLT** — selected as the sample database at SQL DB creation time (Portal → Additional settings → Use existing data → Sample), or restored from the public `.bacpac`. This is the base dataset for most modules.
- **SalesPartitioned** — a large table (~5–10M rows) built in M1B by multiplying `SalesLT.SalesOrderDetail` across synthetic years, to make partition elimination observable. Build script: `../modules/M1B-partition-shard/01-build-large-table.sql`.
- **Shard set** — `sqldb-shard-01/02/03` seeded with customers split by key range in M1B.

Large generated data is not committed (see `.gitignore`); scripts regenerate it.
