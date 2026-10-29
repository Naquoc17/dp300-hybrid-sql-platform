-- Revert the Query Store settings changed by query-store.sql section 2.
-- Safe to re-run: setting a value to what it already is changes nothing.

ALTER DATABASE CURRENT
SET QUERY_STORE (MAX_STORAGE_SIZE_MB = 100);
