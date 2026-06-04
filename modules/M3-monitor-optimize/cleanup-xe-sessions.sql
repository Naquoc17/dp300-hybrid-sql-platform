-- Cleanup XE sessions created during M3 labs
ALTER EVENT SESSION [LongQueries] ON DATABASE STATE = STOP;
DROP EVENT SESSION [LongQueries] ON DATABASE;
