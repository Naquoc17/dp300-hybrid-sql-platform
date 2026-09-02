-- =============================================================================
-- M3.3 - Extended Events: capture slow statements
-- Level    : DP-300 L10 (Monitor Resource Activity & Performance)
-- Target DB: sqldb-dp300-lab (Azure SQL Database, GP serverless)
-- Built    : 2026-09-02, run and verified live in SSMS
-- Cleanup  : see cleanup-xe-sessions.sql - never add DROP statements to this file
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1. BEFORE state - which XE sessions are DEFINED in this database?
--    Azure SQL Database is database-scoped: sys.database_event_sessions.
--    (SQL Server / MI / VM use the server-scoped sys.server_event_sessions.)
--    Expected on a fresh database: 0 rows.
-- -----------------------------------------------------------------------------
SELECT name, event_retention_mode_desc, startup_state
FROM sys.database_event_sessions;

-- -----------------------------------------------------------------------------
-- 2. Define the session.
--    ON DATABASE  - the only scope Azure SQL Database allows (no ON SERVER).
--    ADD EVENT    - sqlserver. = things that HAPPEN inside SQL Server.
--                   sql_statement_completed fires once per individual statement.
--    ACTION       - extra context fetched at fire time; NOT in the event payload.
--    WHERE        - event-level predicate, inside the event's own parentheses.
--                   duration is in MICROSECONDS: 500000 = 0.5 seconds.
--                   Evaluated BEFORE the ACTIONs are collected, which is what
--                   keeps a rich ACTION list affordable.
--    ADD TARGET   - package0. = every target lives here.
--                   ring_buffer is in-memory: contents are lost on STOP, on
--                   failover, and when a serverless database auto-pauses.
--    NOTE: CREATE only DEFINES the session. It records nothing until started.
-- -----------------------------------------------------------------------------
CREATE EVENT SESSION [xe_slow_statements] ON DATABASE
ADD EVENT sqlserver.sql_statement_completed
  (ACTION (sqlserver.sql_text, sqlserver.username)
   WHERE duration > 500000)
ADD TARGET package0.ring_buffer;

-- -----------------------------------------------------------------------------
-- 3. AFTER state - the session now exists (1 row).
--    event_retention_mode_desc = ALLOW_SINGLE_EVENT_LOSS (default): under buffer
--      pressure the engine drops individual events rather than blocking the
--      workload. NO_EVENT_LOSS would stall the session that raised the event.
--    startup_state = 0 (default): does not auto-start when the database comes
--      online. Correct for a troubleshooting session.
-- -----------------------------------------------------------------------------
SELECT name, event_retention_mode_desc, startup_state
FROM sys.database_event_sessions;

-- -----------------------------------------------------------------------------
-- 4. Arm the session. This is the step that is most often forgotten.
-- -----------------------------------------------------------------------------
ALTER EVENT SESSION [xe_slow_statements] ON DATABASE STATE = START;

-- -----------------------------------------------------------------------------
-- 5. Confirm it is RUNNING - a different view from step 1.
--    sys.database_event_sessions    -> sessions DEFINED   (persisted definition)
--    sys.dm_xe_database_sessions    -> sessions RUNNING   (dm_ = dynamic state)
--    Note the plural: sys.dm_xe_database_session does not exist.
-- -----------------------------------------------------------------------------
SELECT name FROM sys.dm_xe_database_sessions;

-- -----------------------------------------------------------------------------
-- 6. Test load - run each statement separately.
--    6a MUST be captured (3s > 0.5s threshold).
--    6b MUST NOT be captured (milliseconds) - this proves the filter works in
--       BOTH directions, not just that something was recorded.
-- -----------------------------------------------------------------------------
WAITFOR DELAY '00:00:03';

SELECT COUNT(*) FROM SalesLT.Customer;

-- -----------------------------------------------------------------------------
-- 7. Read the captured events - SSMS GUI, no T-SQL needed.
--
--    Object Explorer -> sqldb-dp300-lab -> Extended Events -> Sessions ->
--    xe_slow_statements -> package0.ring_buffer -> right-click ->
--    View Target Data...
--
--    ring_buffer returns a single XML cell; click it to open in its own tab.
--    (event_file would render as a proper grid - the trade-off for being free.)
--
--    WAIT ~30 SECONDS FIRST. MAX_DISPATCH_LATENCY defaults to 30 SECONDS, so
--    events sit in a memory buffer before being flushed to the target. An empty
--    target immediately after the workload is normal, not a failure.
--
--    Verified 2026-09-02:
--      duration = 3004067      (3.004 s, in microseconds)
--      sql_text = WAITFOR DELAY '00:00:03';
--      username = sqladmin
--      SELECT COUNT(*) absent  -> filter correct in both directions
--
--    On username: it records the LOGIN the connection authenticated as, not the
--    end user. A real application connects through a pooled service account, so
--    every user appears as that one login. Narrow it with
--    sqlserver.client_app_name and sqlserver.client_hostname (diagnostic only -
--    client_app_name is self-declared and must never gate authorization), or
--    have the application stamp the end-user identity into SESSION_CONTEXT.
-- -----------------------------------------------------------------------------

-- 8. Teardown lives in cleanup-xe-sessions.sql.
