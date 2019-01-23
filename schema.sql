-- First go into psql:
--    CREATE DATABASE just_breathe
-- Then back in terminal run schema:
--    psql just_breathe -f schema.sql

-- Push db to heroku
-- heroku pg:push just_breathe DATABASE_URL --app breathe-chill


CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DROP TABLE IF EXISTS journals;
DROP TABLE IF EXISTS suggestions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id uuid DEFAULT uuid_generate_v4 (),
  username VARCHAR(25) UNIQUE,
  password VARCHAR(25),
  PRIMARY KEY (id)
);

CREATE TABLE journals (
  id SERIAL PRIMARY KEY,
  uid uuid NOT NULL REFERENCES users(id),
  date DATE,
  entered TIMESTAMP DEFAULT now(),
  exercise BOOLEAN,
  outdoors BOOLEAN,
  entry TEXT,
  sentiment INTEGER,
  anger INTEGER,
  fear INTEGER,
  joy INTEGER,
  sadness INTEGER,
  surprise INTEGER
);

CREATE TABLE suggestions (
  id SERIAL PRIMARY KEY,
  suggestion TEXT,
  name TEXT,
  entered TIMESTAMP DEFAULT now()
);



-- Copy Journal Entries
