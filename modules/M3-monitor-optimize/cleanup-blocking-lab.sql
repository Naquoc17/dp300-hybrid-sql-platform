-- Release the lock from the blocking lab if window 1 is still open.
-- Run it IN WINDOW 1. Safe to re-run: it does nothing when no transaction is open.

IF @@TRANCOUNT > 0
    ROLLBACK TRAN;
