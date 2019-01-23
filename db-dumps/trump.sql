--
-- PostgreSQL database dump
--

-- Dumped from database version 11.1
-- Dumped by pg_dump version 11.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: journals; Type: TABLE; Schema: public; Owner: andavi
--

CREATE TABLE public.journals (
    id integer NOT NULL,
    uid uuid NOT NULL,
    date date,
    entered timestamp without time zone DEFAULT now(),
    exercise boolean,
    outdoors boolean,
    entry text,
    sentiment integer,
    anger integer,
    fear integer,
    joy integer,
    sadness integer,
    surprise integer
);


ALTER TABLE public.journals OWNER TO andavi;

--
-- Name: journals_id_seq; Type: SEQUENCE; Schema: public; Owner: andavi
--

CREATE SEQUENCE public.journals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.journals_id_seq OWNER TO andavi;

--
-- Name: journals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andavi
--

ALTER SEQUENCE public.journals_id_seq OWNED BY public.journals.id;


--
-- Name: suggestions; Type: TABLE; Schema: public; Owner: andavi
--

CREATE TABLE public.suggestions (
    suggestion text,
    name text,
    id integer NOT NULL,
    entered TIMESTAMP DEFAULT now()
);


ALTER TABLE public.suggestions OWNER TO andavi;

--
-- Name: suggestions_id_seq; Type: SEQUENCE; Schema: public; Owner: andavi
--

CREATE SEQUENCE public.suggestions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.suggestions_id_seq OWNER TO andavi;

--
-- Name: suggestions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andavi
--

ALTER SEQUENCE public.suggestions_id_seq OWNED BY public.suggestions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: andavi
--

CREATE TABLE public.users (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    username character varying(10),
    password character varying(25)
);


ALTER TABLE public.users OWNER TO andavi;

--
-- Name: journals id; Type: DEFAULT; Schema: public; Owner: andavi
--

ALTER TABLE ONLY public.journals ALTER COLUMN id SET DEFAULT nextval('public.journals_id_seq'::regclass);


--
-- Name: suggestions id; Type: DEFAULT; Schema: public; Owner: andavi
--

ALTER TABLE ONLY public.suggestions ALTER COLUMN id SET DEFAULT nextval('public.suggestions_id_seq'::regclass);


--
-- Data for Name: journals; Type: TABLE DATA; Schema: public; Owner: andavi
--

COPY public.journals (id, uid, date, entered, exercise, outdoors, entry, sentiment, anger, fear, joy, sadness, surprise) FROM stdin;
1	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-01	2019-01-18 07:48:56.975427	f	t	Happiness is not something ready-made. It comes from your own actions	2	2	2	2	2	2
2	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-02	2019-01-18 07:49:43.569359	f	t	If you can, help others; if you cannot do that, at least do not harm them	4	7	2	0	2	0
3	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-03	2019-01-18 07:50:17.362106	f	f	If you want others to be happy, practice compassion. If you want to be happy, practice compassion	9	3	1	1	4	0
4	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-04	2019-01-18 07:50:39.933413	f	f	According to Buddhism, compassion is an aspiration, a state of mind, wanting others to be free from suffering. It’s not passive – it’s not empathy alone – but rather an emphatic altruism that actively strives to free others from suffering. Genuine compassion must have both wisdom and loving kindness. That is to say, one must understand the nature of the suffering from which we wish to free others (this is wisdom), and one must experience deep intimacy and empathy with other sentient beings (this is loving kindness).	9	1	1	5	2	0
5	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-05	2019-01-18 07:51:02.421445	f	f	Compassion strengthens your outlook, and with that courage you are more relaxed. When your perspective includes the suffering of limitless beings, you own suffering looks comparatively small	10	1	2	2	5	0
6	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-06	2019-01-18 07:51:28.838663	f	f	Without love, human society is in a very difficult state; without love, in the future we will face tremendous problems. Love is the center of human life	10	1	1	5	3	0
7	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-07	2019-01-18 07:52:00.891871	f	f	The body can gain health, but without peace of mind no happiness is possible, not even under the best possible conditions	1	1	1	2	5	2
8	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-08	2019-01-18 07:52:33.046764	f	f	Contentment is key. If you have contentment without material things, you are truly rich. Without it, even if you are a billionaire, you will not have happiness	7	1	1	4	2	3
9	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-09	2019-01-18 07:53:03.153303	f	f	We all dream of a kinder, happier world. But if we wish to make it a reality, we have to ensure that compassion inspires all our actions	7	1	2	3	4	0
10	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-10	2019-01-18 07:53:33.259122	f	f	Be kind whenever possible. It is always possible	8	2	2	2	1	3
11	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-11	2019-01-18 07:54:00.089289	f	f	Happiness is not something ready made. It comes from your own actions	1	2	2	2	2	2
12	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-12	2019-01-18 07:54:22.720399	f	f	This is my simple religion. There is no need for temples; no need for complicated philosophy. Our own brain, our own heart is our temple; the philosophy is kindness	10	3	1	1	4	1
13	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-13	2019-01-18 07:58:17.019965	f	f	All major religious traditions carry basically the same message, that is love, compassion and forgiveness the important thing is they should be part of our daily lives	6	3	1	1	5	0
14	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-14	2019-01-18 07:58:37.814618	f	f	Old friends pass away, new friends appear. It is just like the days. An old day passes, a new day arrives. The important thing is to make it meaningful: a meaningful friend – or a meaningful day	10	1	2	5	2	1
15	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-15	2019-01-18 07:59:18.97444	f	f	It is very important to generate a good attitude, a good heart, as much as possible. From this, happiness in both the short term and the long term for both yourself and others will come	9	0	1	7	1	1
16	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-16	2019-01-18 07:59:47.749517	f	f	Our prime purpose in this life is to help others. And if you can’t help them, at least don’t hurt them	10	2	1	0	6	0
17	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-17	2019-01-18 08:00:10.8925	f	f	I find hope in the darkest of days, and focus in the brightest. I do not judge the universe	4	1	7	1	1	0
18	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-18	2019-01-18 08:00:40.159459	f	f	Love and compassion are necessities, not luxuries. Without them humanity cannot survive	10	4	1	1	4	0
19	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-19	2019-01-18 08:01:06.087865	f	f	My religion is very simple. My religion is kindness	8	3	2	3	2	1
20	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-20	2019-01-18 08:01:43.670509	f	f	Sometimes one creates a dynamic impression by saying something, and sometimes one creates as significant an impression by remaining silent	5	2	1	1	5	2
21	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-21	2019-01-18 08:02:06.40475	f	f	In the practice of tolerance, one’s enemy is the best teacher	9	1	1	5	2	1
22	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-22	2019-01-18 08:02:25.423324	f	f	If you want others to be happy, practice compassion. If you want to be happy, practice compassion	9	3	1	1	4	0
23	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-23	2019-01-18 08:03:16.75486	f	f	The purpose of our lives is to be happy	10	1	1	4	2	2
24	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-24	2019-01-18 08:03:56.896766	f	f	It is necessary to help others, not only in our prayers, but in our daily lives. If we find we cannot help others, the least we can do is to desist from harming them	10	5	2	0	3	0
25	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-25	2019-01-18 08:04:22.190158	f	f	We can never obtain peace in the outer world until we make peace with ourselves	9	2	1	4	3	0
26	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-26	2019-01-18 08:04:48.917417	f	f	Today, more than ever before, life must be characterized by a sense of Universal responsibility, not only nation to nation and human to human, but also human to other forms of life	9	2	1	1	6	0
27	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-27	2019-01-18 08:05:35.920644	f	f	If you have a particular faith or religion, that is good. But you can survive without it	4	1	5	1	3	0
28	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-28	2019-01-18 08:05:53.94442	f	f	We can live without religion and meditation, but we cannot survive without human affection	7	2	1	1	6	0
29	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-29	2019-01-18 08:06:23.538686	f	f	With realization of one’s own potential and self-confidence in one’s ability, one can build a better world	9	1	1	3	3	3
30	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-30	2019-01-18 08:07:08.800187	f	f	Where ignorance is our master, there is no possibility of real peace	9	2	2	1	4	0
31	54381d4e-93cc-4f80-b525-6e8f11b5614d	2019-01-31	2019-01-18 08:07:27.335915	f	f	Whether one believes in a religion or not, and whether one believes in rebirth or not, there isn’t anyone who doesn’t appreciate kindness and compassion	10	3	3	0	4	0
32	69fd5d59-99c1-438e-8e36-6131330aa33f	1926-01-01	2019-01-18 08:23:36.749469	t	f	In the morning I walked down the Boulevard to the rue Soufflot for coffee and brioche. It was a fine morning. The horse-chestnut trees in the Luxembourg gardens were in bloom. There was the pleasant early-morning feeling of a hot day. I read the papers with the coffee and then smoked a cigarette. The flower-women were coming up from the market and arranging their daily stock. Students went by going up to the law school, or down to the Sorbonne. The Boulevard was busy with trams and people going to work.	8	2	1	3	4	1
33	69fd5d59-99c1-438e-8e36-6131330aa33f	1932-01-01	2019-01-18 08:24:01.353493	f	f	If a writer of prose knows enough about what he is writing about, he may omit things that he knows and the reader, if the writer is writing truly enough, will have a feeling of those things as strongly as though the writer had stated them. The dignity of movement of an iceberg is due to only one-eighth of it being above water.	1	2	2	1	3	1
34	69fd5d59-99c1-438e-8e36-6131330aa33f	1940-01-01	2019-01-18 08:24:26.24117	t	t	How little we know of what there is to know. I wish that I were going to live a long time instead of going to die today because I have learned much about life in these four days; more, I think than in all other time. I’d like to be an old man to really know. I wonder if you keep on learning or if there is only a certain amount each man can understand. I thought I knew so many things that I know nothing of. I wish there was more time.	9	2	2	0	6	0
35	69fd5d59-99c1-438e-8e36-6131330aa33f	1951-01-01	2019-01-18 08:24:56.14327	f	f	He remembered the time he had hooked one of a pair of marlin. The male fish always let the female fish feed first and the hooked fish, the female, made a wild, panic-stricken, despairing fight that soon exhausted her, and all the time the male had stayed with her, crossing the line and circling with her on the surface.\r\n\r\nHe had stayed so close that the old man was afraid he would cut the line with his tail which was sharp as a scythe and almost of that size and shape. When the old man had gaffed her and clubbed her, holding the rapier bill with its sandpaper edge and clubbing her across the top of her head until her colour turned to a colour almost like the backing of mirrors, and then, with the boy’s aid, hoisted her aboard, the male fish had stayed by the side of the boat.\r\n\r\nThen, while the old man was clearing the lines and preparing the harpoon, the male fish jumped high into the air beside the boat to see where the female was and then went down deep, his lavender wings, that were his pectoral fins, spread wide and all his wide lavender stripes showing. He was beautiful, the old man remembered, and he had stayed.	9	1	3	2	3	2
36	69fd5d59-99c1-438e-8e36-6131330aa33f	1961-01-01	2019-01-18 08:25:51.953206	f	t	If people bring so much courage to this world the world has to kill them to break them, so of course it kills them. The world breaks every one and afterward many are strong at the broken places. But those that will not break it kills. It kills the very good and the very gentle and the very brave impartially. If you are none of these you can be sure it will kill you too but there will be no special hurry.	10	4	3	0	3	0
37	d58f55a9-4d6a-4973-91b0-736f526b4b28	1206-01-01	2019-01-18 08:32:41.543809	f	f	I am the punishment of God...If you had not committed great sins, God would not have sent a punishment like me upon you.	4	3	2	0	4	0
38	d58f55a9-4d6a-4973-91b0-736f526b4b28	1208-02-02	2019-01-18 00:00:00	f	f	If you're afraid - don't do it, - if you're doing it - don't be afraid!	10	1	8	0	0	0
39	d58f55a9-4d6a-4973-91b0-736f526b4b28	1210-01-01	2019-01-18 08:34:14.031372	f	f	an action comitted in anger is an action doomed to failure.	7	4	2	0	4	0
40	d58f55a9-4d6a-4973-91b0-736f526b4b28	1212-01-01	2019-01-18 08:34:37.891567	f	f	Who can’t stop drinking may get drunken three times a month. If he does it more often, he is guilty. To get drunken twice a month is better; once, still more praiseworthy. But not to drink at all - what could be better than this? But where could such a being be found? But if one would find it, it would be worthy of all honour.	6	5	1	0	4	0
41	d58f55a9-4d6a-4973-91b0-736f526b4b28	1214-01-01	2019-01-18 08:35:27.55674	f	f	I am the flail of god. Had you not created great sins, god would not have sent a punishment like me upon you.	2	4	2	1	3	0
42	d58f55a9-4d6a-4973-91b0-736f526b4b28	1216-01-01	2019-01-18 08:35:50.903539	f	f	There is no value in anything until it is finished.	1	2	1	1	4	2
43	d58f55a9-4d6a-4973-91b0-736f526b4b28	1218-01-01	2019-01-18 00:00:00	f	f	Conquering the world on horseback is easy; it is dismounting and governing that is hard.	6	1	2	3	2	2
44	d58f55a9-4d6a-4973-91b0-736f526b4b28	1220-01-01	2019-01-18 08:37:26.752464	f	f	The greatest happiness is to vanquish your enemies, to chase them before you, to rob them of their wealth, to see those dear to them bathed in tears, to clasp to your bosom their wives and daughters.	3	1	0	3	5	0
45	d58f55a9-4d6a-4973-91b0-736f526b4b28	1222-01-01	2019-01-18 08:37:49.588452	f	f	A man's greatest joy is crushing his enemies.	9	0	1	7	1	1
46	d58f55a9-4d6a-4973-91b0-736f526b4b28	1224-01-01	2019-01-18 08:38:27.990647	f	f	If you're afraid - don't do it, - if you're doing it - don't be afraid!	10	1	8	0	0	0
47	e5d82b58-243b-4d33-a385-596ab547397b	2018-01-02	2019-01-18 18:48:15.758743	f	f	North Korean Leader Kim Jong Un just stated that the “Nuclear Button is on his desk at all times.” Will someone from his depleted and food starved regime please inform him that I too have a Nuclear Button, but it is a much bigger & more powerful one than his, and my Button works!	9	4	2	1	2	1
48	e5d82b58-243b-4d33-a385-596ab547397b	2018-01-06	2019-01-18 18:49:15.71859	f	f	Throughout my life, my two greatest assets have been mental stability and being, like, really smart, "Crooked Hillary Clinton also played these cards very hard and, as everyone knows, went down in flames. I went from VERY successful businessman, to top T.V. Star to President of the United States (on my first try). I think that would qualify as not smart, but genius....and a very stable genius at that!	10	0	1	3	1	4
49	e5d82b58-243b-4d33-a385-596ab547397b	2018-02-05	2019-01-18 18:49:51.162812	f	f	You've got half the room going totally crazy, wild, they loved everything, they wanna do something great for our country, and you have the other side, even on positive news, really positive news, like that, they were like death, and un-American, un-American. Somebody said treasonous, I mean, yeah I guess, why not? Can we call that treason, why not?	2	3	2	0	4	1
50	e5d82b58-243b-4d33-a385-596ab547397b	2018-05-28	2019-01-18 18:50:38.917469	f	f	America will not be held hostage to nuclear blackmail. We will not allow American cities to be threatened with destruction. And we will not allow a regime that chants “Death to America” to gain access to the most deadly weapons on Earth.	3	2	1	1	5	0
51	e5d82b58-243b-4d33-a385-596ab547397b	2018-06-21	2019-01-18 18:51:12.980363	f	f	In the meantime, people are suffering because of the Democrats. So we’ve created, and they’ve created, and they’ve let it happen — a massive child-smuggling industry. That’s exactly what it’s become. Traffickers — if you think about this — human traffickers are making a fortune. It’s a disgrace. These loopholes force the release of alien families and minors into the country when they illegally cross the border.	3	4	2	0	3	0
52	e5d82b58-243b-4d33-a385-596ab547397b	2018-05-07	2019-01-18 18:52:08.721143	f	f	but we have to do it gently because we’re in the #MeToo generation, so we have to be very gentle.\r\nwe will very gently take that kit, and we will slowly toss it, hoping it doesn’t hit her and injure her arm.	6	2	4	1	3	0
53	e5d82b58-243b-4d33-a385-596ab547397b	2018-07-13	2019-01-18 18:53:04.632015	f	f	The border with the Sahara can't be bigger than ours with Mexico.	2	1	1	2	3	4
54	e5d82b58-243b-4d33-a385-596ab547397b	2018-08-14	2019-01-18 18:53:33.059168	f	f	When you give a crazed, crying lowlife a break, and give her a job at the White House, I guess it just didn't work out. Good work by General Kelly for quickly firing that dog!	3	3	1	1	4	1
55	e5d82b58-243b-4d33-a385-596ab547397b	2018-09-13	2019-01-18 18:54:22.263109	f	f	I just wanna thank all of the incredible men and women who have done such a great job in helping with Florence. This is a tough hurricane. One of the wettest we've ever seen from a standpoint of water.	10	1	1	3	2	2
56	e5d82b58-243b-4d33-a385-596ab547397b	2018-10-18	2019-01-18 18:55:22.975775	f	f	I am watching the Democrat Party led (because they want Open Borders and existing weak laws) assault on our country by Guatemala, Honduras and El Salvador, whose leaders are doing little to stop this large flow of people, INCLUDING MANY CRIMINALS, from entering Mexico to U.S.....\r\n....In addition to stopping all payments to these countries, which seem to have almost no control over their population, I must, in the strongest of terms, ask Mexico to stop this onslaught - and if unable to do so I will call up the U.S. Military and CLOSE OUR SOUTHERN BORDER!..\r\n....The assault on our country at our Southern Border, including the Criminal elements and DRUGS pouring in, is far more important to me, as President, than Trade or the USMCA. Hopefully Mexico will stop this onslaught at their Northern Border. All Democrats fault for weak laws!	5	4	2	1	3	0
57	e5d82b58-243b-4d33-a385-596ab547397b	2018-11-28	2019-01-18 18:56:28.000084	f	f	One of the problems that a lot of people like myself we have very high levels of intelligence, but we're not necessarily such believers. You look at our air and our water, and it's now at a record clean. But when you look at China and you look at parts of Asia and when you look at South America, and when you look at many other places in this world, including Russia, including just many other places, the air is incredibly dirty and when you're talking about an atmosphere, oceans are very small and it blows over and it sails over. I mean, we take thousands of tons of garbage off our beaches all the time that comes over from Asia. It just flows right down the Pacific, if flows, and we say where does this come from. And it takes many people to start off with.	9	6	1	1	2	0
58	e5d82b58-243b-4d33-a385-596ab547397b	2018-01-28	2019-01-18 18:58:56.070596	f	f	 Er, there is a cooling and there is a heating, and I mean, look, it used to not be climate change, it used to be global warming. [Interviewer: Right.] Right? That wasn't working too well, because it was getting too cold all over the place. The ice caps were going to melt, they were going to be gone by now, but now they're setting records, OK, they're at a record level.	3	3	2	1	3	1
59	e5d82b58-243b-4d33-a385-596ab547397b	2018-10-22	2019-01-18 19:00:33.786835	f	f	You know they have a word, it sort of became old-fashioned, it's called a nationalist,\r\nAnd I say 'really, we're not supposed to use that word?' Do you know what I am? I'm a nationalist.	2	3	2	1	4	2
60	e5d82b58-243b-4d33-a385-596ab547397b	2018-01-05	2019-01-18 19:01:34.906638	f	f	Do you still like having sex with your wife? How often? You must have had a better fuck than your wife? Tell me about it. I have girls coming in from Los Angeles at three o’clock. We can go upstairs and have a great time. I promise.	9	1	1	2	2	4
61	e5d82b58-243b-4d33-a385-596ab547397b	2018-01-11	2019-01-18 19:02:25.65937	f	f	Why are we having all these people from shithole countries come here?	3	5	1	0	3	0
62	e5d82b58-243b-4d33-a385-596ab547397b	2018-11-02	2019-01-18 19:02:58.776314	f	f	Name one country run by a black person that's not a shithole... Name one city.	3	2	0	1	6	1
\.


--
-- Data for Name: suggestions; Type: TABLE DATA; Schema: public; Owner: andavi
--

-- COPY public.suggestions (suggestion, name, id) FROM stdin;
-- eat brad	Andrew Davis	1
-- eat bread	Andrew Davis	2
-- eat bread	Andrew Davis	3
-- Is it working now?	Jess	4
-- \.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: andavi
--

COPY public.users (id, username, password) FROM stdin;
b445a41b-1db3-4f7f-9393-7f2f443cdc46	andrew	1234
2b2bd723-344f-4535-9522-51ab12e4721b	jess	test
7bbffdca-7f25-4371-b5b9-cb14f8a49753	erik	p@rty
469f6f64-a861-4756-b705-aeff93ffd5b1	lorin	milktoast
54381d4e-93cc-4f80-b525-6e8f11b5614d	lama	lama
69fd5d59-99c1-438e-8e36-6131330aa33f	hemingway	hemingway
d58f55a9-4d6a-4973-91b0-736f526b4b28	khan	khan
e5d82b58-243b-4d33-a385-596ab547397b	trump	trump
\.


--
-- Name: journals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andavi
--

SELECT pg_catalog.setval('public.journals_id_seq', 62, true);


--
-- Name: suggestions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andavi
--

SELECT pg_catalog.setval('public.suggestions_id_seq', 1, false);


--
-- Name: journals journals_pkey; Type: CONSTRAINT; Schema: public; Owner: andavi
--

ALTER TABLE ONLY public.journals
    ADD CONSTRAINT journals_pkey PRIMARY KEY (id);


--
-- Name: suggestions suggestions_pkey; Type: CONSTRAINT; Schema: public; Owner: andavi
--

ALTER TABLE ONLY public.suggestions
    ADD CONSTRAINT suggestions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: andavi
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: andavi
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: journals journals_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: andavi
--

ALTER TABLE ONLY public.journals
    ADD CONSTRAINT journals_uid_fkey FOREIGN KEY (uid) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--
