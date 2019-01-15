-- First go into psql:
--    CREATE DATABASE just_breathe
-- Then back in terminal run schema:
--    psql just_breathe -f schema.sql 

-- Push db to heroku
-- heroku pg:push just_breathe DATABASE_URL --app just-breathe-cf301

	
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DROP TABLE IF EXISTS journals;
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
  exercise BOOLEAN,
  outdoors BOOLEAN,
  entry TEXT,
  rating INTEGER
);

INSERT INTO users(username, password)
VALUES('andrew', '1234');

INSERT INTO users(username, password)
VALUES('jess', 'test');

INSERT INTO users(username, password)
VALUES('erik', 'p@rty');


INSERT INTO journals(uid, date, exercise, outdoors, entry, rating)
VALUES((SELECT id FROM users WHERE username='andrew'), '2018-12-31', false, true, 'Consectetur dolorum aliquam, totam vero odit sit quasi consequatur aspernatur corporis tempora rerum autem. Aliquid itaque enim quibusdam repellat consectetur totam consequuntur. Had a wonderful time with the family on the lake.', 3);

INSERT INTO journals(uid, date, exercise, outdoors, entry, rating)
VALUES((SELECT id FROM users WHERE username='andrew'), '2019-01-01', true, true, 'Felt kind of hungover. Lorem ipsum dolor sit amet consectetur adipisicing elit. Consectetur dolorum aliquam, totam vero odit sit quasi consequatur aspernatur corporis tempora rerum autem. Aliquid itaque enim quibusdam repellat consectetur totam consequuntur.', 4);

INSERT INTO journals(uid, date, exercise, outdoors, entry, rating)
VALUES((SELECT id FROM users WHERE username='andrew'), '2019-01-13', false, false, 'Played computer games until my eyes bled. Lorem ipsum dolor sit amet consectetur adipisicing elit.', 9);