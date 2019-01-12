-- First go into psql:
--    CREATE DATABASE just_breathe
-- Then back in terminal run schema:
--    psql just_breathe -f schema.sql 

-- Push db to heroku
-- heroku pg:push just_breathe DATABASE_URL --app just-breathe-cf301

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS journals;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(25) UNIQUE,
  password VARCHAR(25)
);

CREATE TABLE journals (
  id SERIAL PRIMARY KEY,
  uid INTEGER NOT NULL REFERENCES users(id),
  date DATE,
  exercise BOOLEAN,
  outdoors BOOLEAN,
  entry TEXT,
  rating INTEGER
);

INSERT INTO users(username, password)
VALUES('Andrew', '1234');

INSERT INTO users(username, password)
VALUES('Jess', 'test');

INSERT INTO users(username, password)
VALUES('Erik', 'p@rty');