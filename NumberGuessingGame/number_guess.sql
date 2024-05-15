--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: number_game; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.number_game (
    user_id integer NOT NULL,
    username character varying(22),
    games_played integer,
    best_game integer
);


ALTER TABLE public.number_game OWNER TO freecodecamp;

--
-- Name: number_game_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.number_game_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.number_game_user_id_seq OWNER TO freecodecamp;

--
-- Name: number_game_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.number_game_user_id_seq OWNED BY public.number_game.user_id;


--
-- Name: number_game user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.number_game ALTER COLUMN user_id SET DEFAULT nextval('public.number_game_user_id_seq'::regclass);


--
-- Data for Name: number_game; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.number_game VALUES (11, 'bob', 2, 2);
INSERT INTO public.number_game VALUES (13, 'user_1715783957633', 2, 310);
INSERT INTO public.number_game VALUES (12, 'user_1715783957634', 5, 103);
INSERT INTO public.number_game VALUES (15, 'user_1715783992107', 2, 317);
INSERT INTO public.number_game VALUES (14, 'user_1715783992108', 5, 1002);


--
-- Name: number_game_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.number_game_user_id_seq', 15, true);


--
-- Name: number_game number_game_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.number_game
    ADD CONSTRAINT number_game_pkey PRIMARY KEY (user_id);


--
-- PostgreSQL database dump complete
--

