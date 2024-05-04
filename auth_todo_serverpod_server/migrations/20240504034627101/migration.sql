BEGIN;


--
-- MIGRATION VERSION FOR auth_todo_serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('auth_todo_serverpod', '20240504034627101', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240504034627101', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();


COMMIT;
