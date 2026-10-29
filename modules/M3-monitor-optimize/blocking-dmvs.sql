-- =============================================================================
-- M3.5 - Session blocking: reproduce, diagnose, resolve
-- Level    : DP-300 L11 Part B (Monitor & Optimize Query Performance)
-- Target DB: sqldb-dp300-lab (Azure SQL Database, GP serverless)
-- Built    : 2026-10-02, run and verified live in SSMS (3 query windows)
-- Cleanup  : see cleanup-blocking-lab.sql - never add revert statements to this file
-- =============================================================================

-- -----------------------------------------------------------------------------
-- WINDOW 1 (the blocker). Opens a transaction and never commits, so it keeps
-- its lock. The UPDATE sets a column to its own value: no data changes, but the
-- row is still locked. Do NOT commit and do NOT close this window yet.
-- -----------------------------------------------------------------------------
BEGIN TRAN;
UPDATE SalesLT.Customer
SET CompanyName = CompanyName
WHERE CustomerID = 1;

-- -----------------------------------------------------------------------------
-- WINDOW 2 (the victim). Same row, so it hangs behind window 1.
-- -----------------------------------------------------------------------------
UPDATE SalesLT.Customer
SET CompanyName = CompanyName
WHERE CustomerID = 1;

-- -----------------------------------------------------------------------------
-- WINDOW 3 (diagnose). blocking_session_id = the session holding the lock.
-- wait_type LCK_M_* = waiting for a lock. The session id that never appears in
-- this list but appears as a blocking_session_id is the HEAD BLOCKER.
-- -----------------------------------------------------------------------------
SELECT session_id, blocking_session_id, wait_type, wait_time
FROM sys.dm_exec_requests
WHERE blocking_session_id <> 0;

-- -----------------------------------------------------------------------------
-- WINDOW 3 (resolve). KILL ends the head blocker and rolls back its open
-- transaction, which releases the lock. Commented out so a full-file run can
-- never kill a session by accident; replace the number, then run the line.
-- -----------------------------------------------------------------------------
-- KILL <blocking_session_id>;

-- -----------------------------------------------------------------------------
-- WINDOW 3 (verify). Re-run the diagnose query. Expected: 0 rows.
-- A DMV is a live snapshot; blocking that already ended leaves no trace here.
-- -----------------------------------------------------------------------------
