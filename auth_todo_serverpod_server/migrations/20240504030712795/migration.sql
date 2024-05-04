BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "todos" (
    "id" serial PRIMARY KEY,
    "todo" text NOT NULL,
    "completed" boolean NOT NULL,
    "ownerUserId" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "users" (
    "id" serial PRIMARY KEY,
    "username" text NOT NULL
);


--
-- MIGRATION VERSION FOR auth_todo_serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('auth_todo_serverpod', '20240504030712795', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240504030712795', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();


COMMIT;
