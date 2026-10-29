-- =============================================================================
-- M3.4 - Query Store: configure and read
-- Level    : DP-300 L11 Part A (Monitor & Optimize Query Performance)
-- Target DB: sqldb-dp300-lab (Azure SQL Database, GP serverless)
-- Built    : 2026-10-02, run and verified live in SSMS
-- Cleanup  : see cleanup-query-store.sql - never add revert statements to this file
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1. Current configuration. desired = what was requested, actual = what is
--    really happening (they differ when the store is full: actual flips to
--    READ_ONLY). Expected on this DB: READ_WRITE, READ_WRITE, 1, 100.
-- -----------------------------------------------------------------------------
SELECT actual_state_desc, desired_state_desc,
       current_storage_size_mb, max_storage_size_mb
FROM sys.database_query_store_options;

-- -----------------------------------------------------------------------------
-- 2. Change one setting, then re-run section 1 to see the AFTER state.
--    CURRENT = the database the session is connected to.
-- -----------------------------------------------------------------------------
ALTER DATABASE CURRENT
SET QUERY_STORE (MAX_STORAGE_SIZE_MB = 150);

-- -----------------------------------------------------------------------------
-- 3. Plans Query Store has recorded. plan_id is a database-wide counter.
--    is_forced_plan = 1 means the plan is pinned.
-- -----------------------------------------------------------------------------
SELECT TOP 5 plan_id, query_id, is_forced_plan
FROM sys.query_store_plan;

-- -----------------------------------------------------------------------------
-- 4. Regression candidates: queries with more than one recorded plan.
--    0 rows = no query has changed plan yet.
-- -----------------------------------------------------------------------------
SELECT query_id, COUNT(*) AS plan_count
FROM sys.query_store_plan
GROUP BY query_id
HAVING COUNT(*) > 1;
