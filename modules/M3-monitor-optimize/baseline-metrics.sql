-- L10: Monitor Resource Activity & Performance
-- Module: M3-monitor-optimize

-- 1. Resource history baseline (last ~1 hour, 15-sec snapshots)
SELECT end_time, avg_cpu_percent, avg_data_io_percent, avg_log_write_percent
FROM sys.dm_db_resource_stats
ORDER BY end_time DESC;

-- 2. Live Activity - what is running RIGHT NOW
SELECT session_id, status, command, blocking_session_id, wait_type, cpu_time
FROM sys.dm_exec_requests;

-- 3. Extended Events for this module now live in xevents-session.sql.
--    Extracted 2026-09-02: a baseline script should contain only baseline
--    measurement. The XE block here also used sys.dm_xe_database_session
--    (singular), which does not exist - it would have failed with Msg 208.
