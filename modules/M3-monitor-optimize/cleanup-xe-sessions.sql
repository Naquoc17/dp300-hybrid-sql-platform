-- Cleanup XE sessions created during M3 labs.
-- Guarded so re-running is safe: dropping a session that does not exist raises
-- an error. Dropping a RUNNING session stops it first, so no STOP is required -
-- but any ring_buffer contents are gone, so read the target data BEFORE this.

IF EXISTS (SELECT 1 FROM sys.database_event_sessions WHERE name = 'xe_slow_statements')
    DROP EVENT SESSION [xe_slow_statements] ON DATABASE;

IF EXISTS (SELECT 1 FROM sys.database_event_sessions WHERE name = 'LongQueries')
    DROP EVENT SESSION [LongQueries] ON DATABASE;
