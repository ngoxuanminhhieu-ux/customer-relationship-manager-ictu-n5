-- CRM-21 - persistent login lockout
-- Run ONCE on an existing database.
USE crm_db;

ALTER TABLE users
    ADD COLUMN failed_login_attempts INT NOT NULL DEFAULT 0 AFTER status,
    ADD COLUMN lock_until DATETIME NULL AFTER failed_login_attempts;