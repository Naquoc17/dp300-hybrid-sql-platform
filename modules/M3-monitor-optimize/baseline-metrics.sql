-- L10: Monitor Resource Activity & Performance
-- Module: M3-monitor-optimize

-- 1. Resource history baseline (last ~1 hour, 15-sec snapshots)
FROM sys.dm_db_resource_stats
SELECT end_time, avg_cpu_percent, avg_data_io_percent, avg_log_write_percent
ORDER BY end_time DESC;

-- 2. Live Activity - what is running RIGHT NOW
SELECT session_id, status, command, blocking_session_id, wait_type, cpu_time
FROM sys.dm_exec_requests;

-- 3. Extended Event session - create + start
--    Captures batches taking longer than 2 seconds
CREATE EVENT SESSION [LongQueries] ON DATABASE
ADD EVENT sqlserver.sql_batch_completed
  (WHERE duration > 2000000)
ADD TARGET package0.ring_buffer;

ALTER EVENT SESSION [LongQueries] ON DATABASE STATE = START;

-- 4. Verify session is running
SELECT name FROM sys.dm_xe_database_session;

-- 5. Trigger a slow batch to test the trap (3s > 2s filter)
WAITFOR DELAY '00:00:03';

-- 6. View captured events (GUI - no SQL needed)
--    Object Explorer -> dp300-sqldb-lab -> Management ->
--    Extended Events -> Sessions        -> LongQueries ->
--    right-click     -> View Target Data

-- 7. Cleanup
ALTER EVENT SESSION [LongQueries] ON DATABASE STATE = STOP;
DROP EVENT SESSION [LongQueries] ON DATABASE;
