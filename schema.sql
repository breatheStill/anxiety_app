-- First go into psql:
--    CREATE DATABASE just_breathe
-- Then back in terminal run schema:
--    psql just_breathe -f schema.sql

-- Push db to heroku
-- heroku pg:push just_breathe DATABASE_URL --app just-breathe-cf301


CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DROP TABLE IF EXISTS journals;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS suggestions;

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
  suggestion TEXT,
  name TEXT,
  id SERIAL PRIMARY KEY
);



INSERT INTO users(username, password)
VALUES('andrew', '1234');

INSERT INTO users(username, password)
VALUES('jess', 'test');

INSERT INTO users(username, password)
VALUES('erik', 'p@rty');

INSERT INTO users(username, password)
VALUES('lorin', 'milktoast');

INSERT INTO users(username, password)
VALUES('trump', 'trump');


INSERT INTO journals(uid, date, exercise, outdoors, entry, sentiment, anger, fear, joy, sadness, surprise)
VALUES((SELECT id FROM users WHERE username='trump'), '2017-10-07', false, false, 'The media is—really, the word, I think one of the greatest of all terms I''ve come up with—is fake. I guess other people have used it perhaps over the years, but I''ve never noticed it.', 1,	1,	0,	0,	5,	3);

INSERT INTO journals(uid, date, exercise, outdoors, entry, sentiment, anger, fear, joy, sadness, surprise)
VALUES((SELECT id FROM users WHERE username='trump'), '2017-07-26', false, false, 'After consultation with my Generals and military experts, please be advised that the United States Government will not accept or allow...Transgender individuals to serve in any capacity in the U.S. Military. Our military must be focused on decisive and overwhelming...victory and cannot be burdened with the tremendous medical costs and disruption that transgender in the military would entail. Thank you.', 6,	1,	3,	3,	2,	0);

INSERT INTO journals(uid, date, exercise, outdoors, entry, sentiment, anger, fear, joy, sadness, surprise)
VALUES((SELECT id FROM users WHERE username='trump'), '2017-11-17', false, false, 'There was no collusion. Everybody knows there was no collusion.', 4,	1,	0,	0,	5,	3);

INSERT INTO journals(uid, date, exercise, outdoors, entry, sentiment, anger, fear, joy, sadness, surprise)
VALUES((SELECT id FROM users WHERE username='trump'), '2017-04-22', false, false, 'There is a chance that we could end up having a major, major conflict with North Korea. Absolutely.', 7,	3,	2,	2,	4,	0);

INSERT INTO journals(uid, date, exercise, outdoors, entry, sentiment, anger, fear, joy, sadness, surprise)
VALUES((SELECT id FROM users WHERE username='trump'), '2017-08-10', false, false, 'Nobody has better respect for intelligence than Donald Trump.', 4,	1,	0,	0,	4,	4);

INSERT INTO journals(uid, date, exercise, outdoors, entry, sentiment, anger, fear, joy, sadness, surprise)
VALUES((SELECT id FROM users WHERE username='trump'), '2017-08-29', false, false, 'What a crowd, what a turnout.', 7,	2,	3,	2,	2,	2);

INSERT INTO journals(uid, date, exercise, outdoors, entry, sentiment, anger, fear, joy, sadness, surprise)
VALUES((SELECT id FROM users WHERE username='trump'), '2017-11-09', false, false, 'I don’t blame China, I blame the incompetence of past Admins for allowing China to take advantage of the U.S. on trade leading up to a point where the U.S. is losing $100''s of billions. How can you blame China for taking advantage of people that had no clue? I would''ve done same!', 1,	4,	1,	0,	3,	2);

INSERT INTO journals(uid, date, exercise, outdoors, entry, sentiment, anger, fear, joy, sadness, surprise)
VALUES((SELECT id FROM users WHERE username='trump'), '2017-10-03', false, false, 'You''ve thrown our budget a little out of whack.', 2,	6,	1,	0,	3,	0);

INSERT INTO journals(uid, date, exercise, outdoors, entry, sentiment, anger, fear, joy, sadness, surprise)
VALUES((SELECT id FROM users WHERE username='trump'), '2017-01-11', false, false, 'Russia will have much greater respect for our country when I am leading it than when other people have led it...If Putin likes Donald Trump, I consider that an asset, not a liability, because we have a horrible relationship with Russia.', 6,	3,	1,	0,	6,	0);

INSERT INTO journals(uid, date, exercise, outdoors, entry, sentiment, anger, fear, joy, sadness, surprise)
VALUES((SELECT id FROM users WHERE username='trump'), '2017-11-11', false, false, 'Why would Kim Jong-un insult me by calling me ''old,'' when I would NEVER call him ''short and fat?'' Oh well, I try so hard to be his friend - and maybe someday that will happen!', 1,	5,	1,	1,	3,	0);

INSERT INTO journals(uid, date, exercise, outdoors, entry, sentiment, anger, fear, joy, sadness, surprise)
VALUES((SELECT id FROM users WHERE username='trump'), '2017-10-27', false, false, 'It''s just fake. It''s fake. It''s made-up stuff. It''s disgraceful what happens, but that happens in the—that happens in the world of politics.', 0,	2,	2,	1,	4,	1);

INSERT INTO journals(uid, date, exercise, outdoors, entry, sentiment, anger, fear, joy, sadness, surprise)
VALUES((SELECT id FROM users WHERE username='trump'), '2017-11-28', false, false, 'At least 24 players kneeling this weekend at NFL stadiums that are now having a very hard time filling up. The American public is fed up with the disrespect the NFL is paying to our Country, our Flag and our National Anthem. Weak and out of control!', 2,	2,	2,	1,	5,	0);

INSERT INTO journals(uid, date, exercise, outdoors, entry, sentiment, anger, fear, joy, sadness, surprise)
VALUES((SELECT id FROM users WHERE username='trump'), '2017-08-15', false, false, 'Well, I do think there''s blame ''-- yes, I think there''s blame on both sides. You look at -- you look at both sides. I think there''s blame on both sides. And I have no doubt about it, and you don''t have any doubt about it either.', 5,	2,	3,	0,	3,	0);

INSERT INTO journals(uid, date, exercise, outdoors, entry, sentiment, anger, fear, joy, sadness, surprise)
VALUES((SELECT id FROM users WHERE username='trump'), '2017-11-18', false, false, 'Crooked Hillary Clinton is the worst (and biggest) loser of all time. She just can’t stop, which is so good for the Republican Party. Hillary, get on with your life and give it another try in three years!', 1,	3,	1,	1,	5,	0);

INSERT INTO journals(uid, date, exercise, outdoors, entry, sentiment, anger, fear, joy, sadness, surprise)
VALUES((SELECT id FROM users WHERE username='trump'), '2019-01-15', false, false, 'Why is Nancy Pelosi getting paid when people who are working are not?', 1,	9,	0,	0,	1,	0);

INSERT INTO journals(uid, date, exercise, outdoors, entry, sentiment, anger, fear, joy, sadness, surprise)
VALUES((SELECT id FROM users WHERE username='erik'), '2019-01-01', false, false, 'The greatest happiness is to vanquish your enemies, to chase them before you, to rob them of their wealth, to see those dear to them bathed in tears, to clasp to your bosom their wives and daughters.', 3,	1,	0,	3,	5,	0);


INSERT INTO journals(uid, date, exercise, outdoors, entry, sentiment, anger, fear, joy, sadness, surprise)
VALUES((SELECT id FROM users WHERE username='andrew'), '2018-12-31', false, true, 'Consectetur dolorum aliquam, totam vero odit sit quasi consequatur aspernatur corporis tempora rerum autem. Aliquid itaque enim quibusdam repellat consectetur totam consequuntur. Had a wonderful time with the family on the lake.', 5, 7, 6, 4, 2, 1);

INSERT INTO journals(uid, date, exercise, outdoors, entry, sentiment, anger, fear, joy, sadness, surprise)
VALUES((SELECT id FROM users WHERE username='andrew'), '2019-01-01', true, true, 'Felt kind of hungover. Lorem ipsum dolor sit amet consectetur adipisicing elit. Consectetur dolorum aliquam, totam vero odit sit quasi consequatur aspernatur corporis tempora rerum autem. Aliquid itaque enim quibusdam repellat consectetur totam consequuntur.', 4, 4, 9, 10, 10, 10);

INSERT INTO journals(uid, date, exercise, outdoors, entry, sentiment, anger, fear, joy, sadness, surprise)
VALUES((SELECT id FROM users WHERE username='andrew'), '2019-01-13', false, false, 'Played computer games until my eyes bled. Lorem ipsum dolor sit amet consectetur adipisicing elit.', 5, 9, 4, 6, 10, 0 );

