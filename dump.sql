--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8
-- Dumped by pg_dump version 16.8

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

--
-- Name: notify_messenger_messages(); Type: FUNCTION; Schema: public; Owner: arcadia_kevin
--

CREATE FUNCTION public.notify_messenger_messages() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        PERFORM pg_notify('messenger_messages', NEW.queue_name::text);
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.notify_messenger_messages() OWNER TO arcadia_kevin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alimentation; Type: TABLE; Schema: public; Owner: arcadia_kevin
--

CREATE TABLE public.alimentation (
    id_alimentation integer NOT NULL,
    date timestamp without time zone NOT NULL,
    nourriture character varying(255) NOT NULL,
    quantite integer NOT NULL,
    id_animal integer NOT NULL,
    id_employe integer NOT NULL
);


ALTER TABLE public.alimentation OWNER TO arcadia_kevin;

--
-- Name: alimentation_id_alimentation_seq; Type: SEQUENCE; Schema: public; Owner: arcadia_kevin
--

CREATE SEQUENCE public.alimentation_id_alimentation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.alimentation_id_alimentation_seq OWNER TO arcadia_kevin;

--
-- Name: alimentation_id_alimentation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcadia_kevin
--

ALTER SEQUENCE public.alimentation_id_alimentation_seq OWNED BY public.alimentation.id_alimentation;


--
-- Name: animal; Type: TABLE; Schema: public; Owner: arcadia_kevin
--

CREATE TABLE public.animal (
    id_animal integer NOT NULL,
    name character varying(100) NOT NULL,
    race character varying(100) NOT NULL,
    image json,
    id_habitat integer,
    visits integer DEFAULT 0 NOT NULL,
    description text
);


ALTER TABLE public.animal OWNER TO arcadia_kevin;

--
-- Name: animal_id_animal_seq; Type: SEQUENCE; Schema: public; Owner: arcadia_kevin
--

CREATE SEQUENCE public.animal_id_animal_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.animal_id_animal_seq OWNER TO arcadia_kevin;

--
-- Name: animal_id_animal_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcadia_kevin
--

ALTER SEQUENCE public.animal_id_animal_seq OWNED BY public.animal.id_animal;


--
-- Name: avis; Type: TABLE; Schema: public; Owner: arcadia_kevin
--

CREATE TABLE public.avis (
    id_avis integer NOT NULL,
    pseudo character varying(100) NOT NULL,
    comment text NOT NULL,
    is_validated boolean NOT NULL,
    created_at timestamp without time zone NOT NULL,
    validate_by integer
);


ALTER TABLE public.avis OWNER TO arcadia_kevin;

--
-- Name: avis_id_avis_seq; Type: SEQUENCE; Schema: public; Owner: arcadia_kevin
--

CREATE SEQUENCE public.avis_id_avis_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.avis_id_avis_seq OWNER TO arcadia_kevin;

--
-- Name: avis_id_avis_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcadia_kevin
--

ALTER SEQUENCE public.avis_id_avis_seq OWNED BY public.avis.id_avis;


--
-- Name: calendrier; Type: TABLE; Schema: public; Owner: arcadia_kevin
--

CREATE TABLE public.calendrier (
    id_calendrier integer NOT NULL,
    day_of_week character varying(100) NOT NULL,
    opening_time time without time zone NOT NULL,
    closing_time time without time zone NOT NULL,
    is_holiday boolean NOT NULL,
    id_admin integer
);


ALTER TABLE public.calendrier OWNER TO arcadia_kevin;

--
-- Name: calendrier_id_calendrier_seq; Type: SEQUENCE; Schema: public; Owner: arcadia_kevin
--

CREATE SEQUENCE public.calendrier_id_calendrier_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.calendrier_id_calendrier_seq OWNER TO arcadia_kevin;

--
-- Name: calendrier_id_calendrier_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcadia_kevin
--

ALTER SEQUENCE public.calendrier_id_calendrier_seq OWNED BY public.calendrier.id_calendrier;


--
-- Name: comment_habitat; Type: TABLE; Schema: public; Owner: arcadia_kevin
--

CREATE TABLE public.comment_habitat (
    id_comment integer NOT NULL,
    comment text NOT NULL,
    condition_habitat character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    id_veterinaire integer NOT NULL,
    id_habitat integer NOT NULL
);


ALTER TABLE public.comment_habitat OWNER TO arcadia_kevin;

--
-- Name: comment_habitat_id_comment_seq; Type: SEQUENCE; Schema: public; Owner: arcadia_kevin
--

CREATE SEQUENCE public.comment_habitat_id_comment_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comment_habitat_id_comment_seq OWNER TO arcadia_kevin;

--
-- Name: comment_habitat_id_comment_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcadia_kevin
--

ALTER SEQUENCE public.comment_habitat_id_comment_seq OWNED BY public.comment_habitat.id_comment;


--
-- Name: contact; Type: TABLE; Schema: public; Owner: arcadia_kevin
--

CREATE TABLE public.contact (
    id_contact integer NOT NULL,
    email character varying(255) NOT NULL,
    sujet character varying(255) NOT NULL,
    message text NOT NULL,
    created_date timestamp without time zone NOT NULL
);


ALTER TABLE public.contact OWNER TO arcadia_kevin;

--
-- Name: contact_id_contact_seq; Type: SEQUENCE; Schema: public; Owner: arcadia_kevin
--

CREATE SEQUENCE public.contact_id_contact_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contact_id_contact_seq OWNER TO arcadia_kevin;

--
-- Name: contact_id_contact_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcadia_kevin
--

ALTER SEQUENCE public.contact_id_contact_seq OWNED BY public.contact.id_contact;


--
-- Name: doctrine_migration_versions; Type: TABLE; Schema: public; Owner: arcadia_kevin
--

CREATE TABLE public.doctrine_migration_versions (
    version character varying(191) NOT NULL,
    executed_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    execution_time integer
);


ALTER TABLE public.doctrine_migration_versions OWNER TO arcadia_kevin;

--
-- Name: habitat; Type: TABLE; Schema: public; Owner: arcadia_kevin
--

CREATE TABLE public.habitat (
    id_habitat integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    image json
);


ALTER TABLE public.habitat OWNER TO arcadia_kevin;

--
-- Name: habitat_id_habitat_seq; Type: SEQUENCE; Schema: public; Owner: arcadia_kevin
--

CREATE SEQUENCE public.habitat_id_habitat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.habitat_id_habitat_seq OWNER TO arcadia_kevin;

--
-- Name: habitat_id_habitat_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcadia_kevin
--

ALTER SEQUENCE public.habitat_id_habitat_seq OWNED BY public.habitat.id_habitat;


--
-- Name: messenger_messages; Type: TABLE; Schema: public; Owner: arcadia_kevin
--

CREATE TABLE public.messenger_messages (
    id bigint NOT NULL,
    body text NOT NULL,
    headers text NOT NULL,
    queue_name character varying(190) NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    available_at timestamp(0) without time zone NOT NULL,
    delivered_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone
);


ALTER TABLE public.messenger_messages OWNER TO arcadia_kevin;

--
-- Name: COLUMN messenger_messages.created_at; Type: COMMENT; Schema: public; Owner: arcadia_kevin
--

COMMENT ON COLUMN public.messenger_messages.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN messenger_messages.available_at; Type: COMMENT; Schema: public; Owner: arcadia_kevin
--

COMMENT ON COLUMN public.messenger_messages.available_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN messenger_messages.delivered_at; Type: COMMENT; Schema: public; Owner: arcadia_kevin
--

COMMENT ON COLUMN public.messenger_messages.delivered_at IS '(DC2Type:datetime_immutable)';


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: arcadia_kevin
--

CREATE SEQUENCE public.messenger_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.messenger_messages_id_seq OWNER TO arcadia_kevin;

--
-- Name: messenger_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcadia_kevin
--

ALTER SEQUENCE public.messenger_messages_id_seq OWNED BY public.messenger_messages.id;


--
-- Name: rapport_veterinaire; Type: TABLE; Schema: public; Owner: arcadia_kevin
--

CREATE TABLE public.rapport_veterinaire (
    id_rapport_veterinaire integer NOT NULL,
    etat character varying(100) NOT NULL,
    nourriture character varying(100) NOT NULL,
    quantite numeric(10,2) NOT NULL,
    date_passage timestamp without time zone NOT NULL,
    details text,
    id_animal integer,
    id_veterinaire integer
);


ALTER TABLE public.rapport_veterinaire OWNER TO arcadia_kevin;

--
-- Name: rapport_veterinaire_id_rapport_veterinaire_seq; Type: SEQUENCE; Schema: public; Owner: arcadia_kevin
--

CREATE SEQUENCE public.rapport_veterinaire_id_rapport_veterinaire_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rapport_veterinaire_id_rapport_veterinaire_seq OWNER TO arcadia_kevin;

--
-- Name: rapport_veterinaire_id_rapport_veterinaire_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcadia_kevin
--

ALTER SEQUENCE public.rapport_veterinaire_id_rapport_veterinaire_seq OWNED BY public.rapport_veterinaire.id_rapport_veterinaire;


--
-- Name: reinitialisation_mot_de_passe; Type: TABLE; Schema: public; Owner: arcadia_kevin
--

CREATE TABLE public.reinitialisation_mot_de_passe (
    id integer NOT NULL,
    selector character varying(255) NOT NULL,
    hashed_token character varying(255) NOT NULL,
    requested_at timestamp without time zone NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    id_utilisateur integer NOT NULL
);


ALTER TABLE public.reinitialisation_mot_de_passe OWNER TO arcadia_kevin;

--
-- Name: reinitialisation_mot_de_passe_id_seq; Type: SEQUENCE; Schema: public; Owner: arcadia_kevin
--

CREATE SEQUENCE public.reinitialisation_mot_de_passe_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reinitialisation_mot_de_passe_id_seq OWNER TO arcadia_kevin;

--
-- Name: reinitialisation_mot_de_passe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcadia_kevin
--

ALTER SEQUENCE public.reinitialisation_mot_de_passe_id_seq OWNED BY public.reinitialisation_mot_de_passe.id;


--
-- Name: service; Type: TABLE; Schema: public; Owner: arcadia_kevin
--

CREATE TABLE public.service (
    id_service integer NOT NULL,
    name character varying(100) NOT NULL,
    images json,
    description text NOT NULL
);


ALTER TABLE public.service OWNER TO arcadia_kevin;

--
-- Name: service_id_service_seq; Type: SEQUENCE; Schema: public; Owner: arcadia_kevin
--

CREATE SEQUENCE public.service_id_service_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_id_service_seq OWNER TO arcadia_kevin;

--
-- Name: user_service; Type: TABLE; Schema: public; Owner: arcadia_kevin
--

CREATE TABLE public.user_service (
    id_utilisateur integer NOT NULL,
    id_service integer NOT NULL
);


ALTER TABLE public.user_service OWNER TO arcadia_kevin;

--
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: arcadia_kevin
--

CREATE TABLE public.utilisateur (
    id_utilisateur integer NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(50) NOT NULL,
    created_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.utilisateur OWNER TO arcadia_kevin;

--
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE; Schema: public; Owner: arcadia_kevin
--

CREATE SEQUENCE public.utilisateur_id_utilisateur_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.utilisateur_id_utilisateur_seq OWNER TO arcadia_kevin;

--
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcadia_kevin
--

ALTER SEQUENCE public.utilisateur_id_utilisateur_seq OWNED BY public.utilisateur.id_utilisateur;


--
-- Name: messenger_messages id; Type: DEFAULT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.messenger_messages ALTER COLUMN id SET DEFAULT nextval('public.messenger_messages_id_seq'::regclass);


--
-- Data for Name: alimentation; Type: TABLE DATA; Schema: public; Owner: arcadia_kevin
--

COPY public.alimentation (id_alimentation, date, nourriture, quantite, id_animal, id_employe) FROM stdin;
\.


--
-- Data for Name: animal; Type: TABLE DATA; Schema: public; Owner: arcadia_kevin
--

COPY public.animal (id_animal, name, race, image, id_habitat, visits, description) FROM stdin;
1	Koba	Gorille	{"url": "/images/image_gorille_rond.jpg"}	1	1	\N
2	Simba	Lion	{"url": "/images/image_lion_rond.jpg"}	2	5	\N
3	Nemo	Crocodile	{"url": "/images/ArcadiaLogo.png"}	3	18	\N
4	Biscut	Rhino	{"url":"\\/images\\/le_rhino1_mini.jpg"}	2	14	\N
\.


--
-- Data for Name: avis; Type: TABLE DATA; Schema: public; Owner: arcadia_kevin
--

COPY public.avis (id_avis, pseudo, comment, is_validated, created_at, validate_by) FROM stdin;
\.


--
-- Data for Name: calendrier; Type: TABLE DATA; Schema: public; Owner: arcadia_kevin
--

COPY public.calendrier (id_calendrier, day_of_week, opening_time, closing_time, is_holiday, id_admin) FROM stdin;
1	lundi	11:30:00	22:00:00	f	7
\.


--
-- Data for Name: comment_habitat; Type: TABLE DATA; Schema: public; Owner: arcadia_kevin
--

COPY public.comment_habitat (id_comment, comment, condition_habitat, created_at, id_veterinaire, id_habitat) FROM stdin;
\.


--
-- Data for Name: contact; Type: TABLE DATA; Schema: public; Owner: arcadia_kevin
--

COPY public.contact (id_contact, email, sujet, message, created_date) FROM stdin;
1	kevinjerome95370@gmail.com	hehe	jjjjjj	2025-05-21 14:59:10
2	kevinjerome95370@gmail.com	hehe	jjjjjj	2025-05-21 14:59:13
3	kevinjerome95370@gmail.com	hehe	iughjklkl	2025-05-21 14:59:31
\.


--
-- Data for Name: doctrine_migration_versions; Type: TABLE DATA; Schema: public; Owner: arcadia_kevin
--

COPY public.doctrine_migration_versions (version, executed_at, execution_time) FROM stdin;
DoctrineMigrations\\Version20250527121349	2025-05-27 12:16:37	142
DoctrineMigrations\\Version20250527121650	2025-05-27 12:16:57	25
DoctrineMigrations\\Version20250527122436	2025-05-27 12:24:50	4
\.


--
-- Data for Name: habitat; Type: TABLE DATA; Schema: public; Owner: arcadia_kevin
--

COPY public.habitat (id_habitat, name, description, image) FROM stdin;
2	Savane	Plaine aride avec des herbes hautes	{}
3	Marais	Zone humide avec des marécages	{}
1	Jungle	Forêt tropicale humide	[]
4	Maison	Maison de admin	{"url":"\\/images\\/ArcadiaLogo.png"}
\.


--
-- Data for Name: messenger_messages; Type: TABLE DATA; Schema: public; Owner: arcadia_kevin
--

COPY public.messenger_messages (id, body, headers, queue_name, created_at, available_at, delivered_at) FROM stdin;
1	O:36:\\"Symfony\\\\Component\\\\Messenger\\\\Envelope\\":2:{s:44:\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0stamps\\";a:1:{s:46:\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\";a:1:{i:0;O:46:\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\":1:{s:55:\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\0busName\\";s:21:\\"messenger.bus.default\\";}}}s:45:\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0message\\";O:51:\\"Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\":2:{s:60:\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0message\\";O:28:\\"Symfony\\\\Component\\\\Mime\\\\Email\\":6:{i:0;N;i:1;N;i:2;s:216:\\"<p>Un compte a été créé pour vous.</p>\r\n                        <p>Votre email : kevinjerome95370@gmail.com</p>\r\n                        <p>Veuillez contacter l\\'administrateur pour obtenir votre mot de passe.</p>\\";i:3;s:5:\\"utf-8\\";i:4;a:0:{}i:5;a:2:{i:0;O:37:\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\":2:{s:46:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0headers\\";a:3:{s:4:\\"from\\";a:1:{i:0;O:47:\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\":5:{s:50:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\";s:4:\\"From\\";s:56:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\";i:76;s:50:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\";N;s:53:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\";s:5:\\"utf-8\\";s:58:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\";a:1:{i:0;O:30:\\"Symfony\\\\Component\\\\Mime\\\\Address\\":2:{s:39:\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\";s:19:\\"admin@arcadiazoo.fr\\";s:36:\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\";s:0:\\"\\";}}}}s:2:\\"to\\";a:1:{i:0;O:47:\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\":5:{s:50:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\";s:2:\\"To\\";s:56:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\";i:76;s:50:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\";N;s:53:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\";s:5:\\"utf-8\\";s:58:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\";a:1:{i:0;O:30:\\"Symfony\\\\Component\\\\Mime\\\\Address\\":2:{s:39:\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\";s:26:\\"kevinjerome95370@gmail.com\\";s:36:\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\";s:0:\\"\\";}}}}s:7:\\"subject\\";a:1:{i:0;O:48:\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\":5:{s:50:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\";s:7:\\"Subject\\";s:56:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\";i:76;s:50:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\";N;s:53:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\";s:5:\\"utf-8\\";s:55:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\0value\\";s:39:\\"Votre compte Arcadia Zoo a été créé\\";}}}s:49:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0lineLength\\";i:76;}i:1;N;}}s:61:\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0envelope\\";N;}}	[]	default	2025-05-26 10:38:46	2025-05-26 10:38:46	\N
2	O:36:\\"Symfony\\\\Component\\\\Messenger\\\\Envelope\\":2:{s:44:\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0stamps\\";a:1:{s:46:\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\";a:1:{i:0;O:46:\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\":1:{s:55:\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\0busName\\";s:21:\\"messenger.bus.default\\";}}}s:45:\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0message\\";O:51:\\"Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\":2:{s:60:\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0message\\";O:28:\\"Symfony\\\\Component\\\\Mime\\\\Email\\":6:{i:0;N;i:1;N;i:2;s:215:\\"<p>Un compte a été créé pour vous.</p>\r\n                        <p>Votre email : kevinjerome9537@gmail.com</p>\r\n                        <p>Veuillez contacter l\\'administrateur pour obtenir votre mot de passe.</p>\\";i:3;s:5:\\"utf-8\\";i:4;a:0:{}i:5;a:2:{i:0;O:37:\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\":2:{s:46:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0headers\\";a:3:{s:4:\\"from\\";a:1:{i:0;O:47:\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\":5:{s:50:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\";s:4:\\"From\\";s:56:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\";i:76;s:50:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\";N;s:53:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\";s:5:\\"utf-8\\";s:58:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\";a:1:{i:0;O:30:\\"Symfony\\\\Component\\\\Mime\\\\Address\\":2:{s:39:\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\";s:19:\\"admin@arcadiazoo.fr\\";s:36:\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\";s:0:\\"\\";}}}}s:2:\\"to\\";a:1:{i:0;O:47:\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\":5:{s:50:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\";s:2:\\"To\\";s:56:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\";i:76;s:50:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\";N;s:53:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\";s:5:\\"utf-8\\";s:58:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\";a:1:{i:0;O:30:\\"Symfony\\\\Component\\\\Mime\\\\Address\\":2:{s:39:\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\";s:25:\\"kevinjerome9537@gmail.com\\";s:36:\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\";s:0:\\"\\";}}}}s:7:\\"subject\\";a:1:{i:0;O:48:\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\":5:{s:50:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\";s:7:\\"Subject\\";s:56:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\";i:76;s:50:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\";N;s:53:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\";s:5:\\"utf-8\\";s:55:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\0value\\";s:39:\\"Votre compte Arcadia Zoo a été créé\\";}}}s:49:\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0lineLength\\";i:76;}i:1;N;}}s:61:\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0envelope\\";N;}}	[]	default	2025-05-26 13:19:00	2025-05-26 13:19:00	\N
\.


--
-- Data for Name: rapport_veterinaire; Type: TABLE DATA; Schema: public; Owner: arcadia_kevin
--

COPY public.rapport_veterinaire (id_rapport_veterinaire, etat, nourriture, quantite, date_passage, details, id_animal, id_veterinaire) FROM stdin;
\.


--
-- Data for Name: reinitialisation_mot_de_passe; Type: TABLE DATA; Schema: public; Owner: arcadia_kevin
--

COPY public.reinitialisation_mot_de_passe (id, selector, hashed_token, requested_at, expires_at, id_utilisateur) FROM stdin;
\.


--
-- Data for Name: service; Type: TABLE DATA; Schema: public; Owner: arcadia_kevin
--

COPY public.service (id_service, name, images, description) FROM stdin;
2	service menages	{"url":"\\/images\\/image_gorille_rond.jpg"}	payant
3	Petit train	{"url":"\\/images\\/image_petit_train.jpg"}	Tarif : 10$
4	Restauration	{"url":"\\/images\\/image_restauration.jpg"}	Services déjeuner
5	Visite guidée	{"url":"\\/images\\/image_visite_guidee.jpg"}	Retrouver nos meilleur guideur pour vous faire visiter le parc !\nTarif : 25$
\.


--
-- Data for Name: user_service; Type: TABLE DATA; Schema: public; Owner: arcadia_kevin
--

COPY public.user_service (id_utilisateur, id_service) FROM stdin;
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: arcadia_kevin
--

COPY public.utilisateur (id_utilisateur, email, password, role, created_at) FROM stdin;
7	admin@arcadiazoo.com	$2y$13$Hc6uG.Hgy.Zg3nOldqQBquS.itea3P0q6HpWViE6kvNDbY8wy33ve	ROLE_ADMIN	2025-05-26 10:07:14
8	kevinjerome95370@gmail.com	$2y$13$2dEiGFxeuyHPabafsJHjiuNFFxH81e63E3uZLaePPNIfBb3ToGati	ROLE_VETERINAIRE	2025-05-26 10:38:44
9	kevinjerome9537@gmail.com	$2y$13$ON1tCNmStWtLlPBuHODXeOfbQSA6HLngykoNAPROJ4UZjRuNUXOGa	ROLE_EMPLOYE	2025-05-26 13:18:57
\.


--
-- Name: alimentation_id_alimentation_seq; Type: SEQUENCE SET; Schema: public; Owner: arcadia_kevin
--

SELECT pg_catalog.setval('public.alimentation_id_alimentation_seq', 1, false);


--
-- Name: animal_id_animal_seq; Type: SEQUENCE SET; Schema: public; Owner: arcadia_kevin
--

SELECT pg_catalog.setval('public.animal_id_animal_seq', 5, true);


--
-- Name: avis_id_avis_seq; Type: SEQUENCE SET; Schema: public; Owner: arcadia_kevin
--

SELECT pg_catalog.setval('public.avis_id_avis_seq', 1, false);


--
-- Name: calendrier_id_calendrier_seq; Type: SEQUENCE SET; Schema: public; Owner: arcadia_kevin
--

SELECT pg_catalog.setval('public.calendrier_id_calendrier_seq', 1, true);


--
-- Name: comment_habitat_id_comment_seq; Type: SEQUENCE SET; Schema: public; Owner: arcadia_kevin
--

SELECT pg_catalog.setval('public.comment_habitat_id_comment_seq', 1, false);


--
-- Name: contact_id_contact_seq; Type: SEQUENCE SET; Schema: public; Owner: arcadia_kevin
--

SELECT pg_catalog.setval('public.contact_id_contact_seq', 3, true);


--
-- Name: habitat_id_habitat_seq; Type: SEQUENCE SET; Schema: public; Owner: arcadia_kevin
--

SELECT pg_catalog.setval('public.habitat_id_habitat_seq', 4, true);


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arcadia_kevin
--

SELECT pg_catalog.setval('public.messenger_messages_id_seq', 2, true);


--
-- Name: rapport_veterinaire_id_rapport_veterinaire_seq; Type: SEQUENCE SET; Schema: public; Owner: arcadia_kevin
--

SELECT pg_catalog.setval('public.rapport_veterinaire_id_rapport_veterinaire_seq', 1, false);


--
-- Name: reinitialisation_mot_de_passe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arcadia_kevin
--

SELECT pg_catalog.setval('public.reinitialisation_mot_de_passe_id_seq', 1, false);


--
-- Name: service_id_service_seq; Type: SEQUENCE SET; Schema: public; Owner: arcadia_kevin
--

SELECT pg_catalog.setval('public.service_id_service_seq', 5, true);


--
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE SET; Schema: public; Owner: arcadia_kevin
--

SELECT pg_catalog.setval('public.utilisateur_id_utilisateur_seq', 9, true);


--
-- Name: alimentation alimentation_pkey; Type: CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.alimentation
    ADD CONSTRAINT alimentation_pkey PRIMARY KEY (id_alimentation);


--
-- Name: animal animal_pkey; Type: CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.animal
    ADD CONSTRAINT animal_pkey PRIMARY KEY (id_animal);


--
-- Name: avis avis_pkey; Type: CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.avis
    ADD CONSTRAINT avis_pkey PRIMARY KEY (id_avis);


--
-- Name: calendrier calendrier_pkey; Type: CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.calendrier
    ADD CONSTRAINT calendrier_pkey PRIMARY KEY (id_calendrier);


--
-- Name: comment_habitat comment_habitat_pkey; Type: CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.comment_habitat
    ADD CONSTRAINT comment_habitat_pkey PRIMARY KEY (id_comment);


--
-- Name: contact contact_pkey; Type: CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (id_contact);


--
-- Name: doctrine_migration_versions doctrine_migration_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.doctrine_migration_versions
    ADD CONSTRAINT doctrine_migration_versions_pkey PRIMARY KEY (version);


--
-- Name: habitat habitat_pkey; Type: CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.habitat
    ADD CONSTRAINT habitat_pkey PRIMARY KEY (id_habitat);


--
-- Name: messenger_messages messenger_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.messenger_messages
    ADD CONSTRAINT messenger_messages_pkey PRIMARY KEY (id);


--
-- Name: rapport_veterinaire rapport_veterinaire_pkey; Type: CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.rapport_veterinaire
    ADD CONSTRAINT rapport_veterinaire_pkey PRIMARY KEY (id_rapport_veterinaire);


--
-- Name: reinitialisation_mot_de_passe reinitialisation_mot_de_passe_pkey; Type: CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.reinitialisation_mot_de_passe
    ADD CONSTRAINT reinitialisation_mot_de_passe_pkey PRIMARY KEY (id);


--
-- Name: service service_pkey; Type: CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.service
    ADD CONSTRAINT service_pkey PRIMARY KEY (id_service);


--
-- Name: user_service user_service_pkey; Type: CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.user_service
    ADD CONSTRAINT user_service_pkey PRIMARY KEY (id_utilisateur, id_service);


--
-- Name: utilisateur utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id_utilisateur);


--
-- Name: idx_3f69475150eae44; Type: INDEX; Schema: public; Owner: arcadia_kevin
--

CREATE INDEX idx_3f69475150eae44 ON public.reinitialisation_mot_de_passe USING btree (id_utilisateur);


--
-- Name: idx_75ea56e016ba31db; Type: INDEX; Schema: public; Owner: arcadia_kevin
--

CREATE INDEX idx_75ea56e016ba31db ON public.messenger_messages USING btree (delivered_at);


--
-- Name: idx_75ea56e0e3bd61ce; Type: INDEX; Schema: public; Owner: arcadia_kevin
--

CREATE INDEX idx_75ea56e0e3bd61ce ON public.messenger_messages USING btree (available_at);


--
-- Name: idx_75ea56e0fb7336f0; Type: INDEX; Schema: public; Owner: arcadia_kevin
--

CREATE INDEX idx_75ea56e0fb7336f0 ON public.messenger_messages USING btree (queue_name);


--
-- Name: idx_8e65dfa026997ac9; Type: INDEX; Schema: public; Owner: arcadia_kevin
--

CREATE INDEX idx_8e65dfa026997ac9 ON public.alimentation USING btree (id_employe);


--
-- Name: idx_8f91abf093cfd335; Type: INDEX; Schema: public; Owner: arcadia_kevin
--

CREATE INDEX idx_8f91abf093cfd335 ON public.avis USING btree (validate_by);


--
-- Name: idx_b2753cb9668b4c46; Type: INDEX; Schema: public; Owner: arcadia_kevin
--

CREATE INDEX idx_b2753cb9668b4c46 ON public.calendrier USING btree (id_admin);


--
-- Name: idx_b99084d83f0033a2; Type: INDEX; Schema: public; Owner: arcadia_kevin
--

CREATE INDEX idx_b99084d83f0033a2 ON public.user_service USING btree (id_service);


--
-- Name: idx_b99084d850eae44; Type: INDEX; Schema: public; Owner: arcadia_kevin
--

CREATE INDEX idx_b99084d850eae44 ON public.user_service USING btree (id_utilisateur);


--
-- Name: idx_c844d0f8f1cbaf4f; Type: INDEX; Schema: public; Owner: arcadia_kevin
--

CREATE INDEX idx_c844d0f8f1cbaf4f ON public.comment_habitat USING btree (id_veterinaire);


--
-- Name: idx_ce729cdef1cbaf4f; Type: INDEX; Schema: public; Owner: arcadia_kevin
--

CREATE INDEX idx_ce729cdef1cbaf4f ON public.rapport_veterinaire USING btree (id_veterinaire);


--
-- Name: messenger_messages notify_trigger; Type: TRIGGER; Schema: public; Owner: arcadia_kevin
--

CREATE TRIGGER notify_trigger AFTER INSERT OR UPDATE ON public.messenger_messages FOR EACH ROW EXECUTE FUNCTION public.notify_messenger_messages();


--
-- Name: reinitialisation_mot_de_passe fk_3f69475150eae44; Type: FK CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.reinitialisation_mot_de_passe
    ADD CONSTRAINT fk_3f69475150eae44 FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id_utilisateur);


--
-- Name: animal fk_6aab231fe5aa1b98; Type: FK CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.animal
    ADD CONSTRAINT fk_6aab231fe5aa1b98 FOREIGN KEY (id_habitat) REFERENCES public.habitat(id_habitat);


--
-- Name: alimentation fk_8e65dfa026997ac9; Type: FK CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.alimentation
    ADD CONSTRAINT fk_8e65dfa026997ac9 FOREIGN KEY (id_employe) REFERENCES public.utilisateur(id_utilisateur);


--
-- Name: alimentation fk_8e65dfa04c9c96f2; Type: FK CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.alimentation
    ADD CONSTRAINT fk_8e65dfa04c9c96f2 FOREIGN KEY (id_animal) REFERENCES public.animal(id_animal);


--
-- Name: avis fk_8f91abf093cfd335; Type: FK CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.avis
    ADD CONSTRAINT fk_8f91abf093cfd335 FOREIGN KEY (validate_by) REFERENCES public.utilisateur(id_utilisateur);


--
-- Name: calendrier fk_b2753cb9668b4c46; Type: FK CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.calendrier
    ADD CONSTRAINT fk_b2753cb9668b4c46 FOREIGN KEY (id_admin) REFERENCES public.utilisateur(id_utilisateur);


--
-- Name: user_service fk_b99084d83f0033a2; Type: FK CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.user_service
    ADD CONSTRAINT fk_b99084d83f0033a2 FOREIGN KEY (id_service) REFERENCES public.service(id_service);


--
-- Name: user_service fk_b99084d850eae44; Type: FK CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.user_service
    ADD CONSTRAINT fk_b99084d850eae44 FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id_utilisateur);


--
-- Name: comment_habitat fk_c844d0f8e5aa1b98; Type: FK CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.comment_habitat
    ADD CONSTRAINT fk_c844d0f8e5aa1b98 FOREIGN KEY (id_habitat) REFERENCES public.habitat(id_habitat);


--
-- Name: comment_habitat fk_c844d0f8f1cbaf4f; Type: FK CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.comment_habitat
    ADD CONSTRAINT fk_c844d0f8f1cbaf4f FOREIGN KEY (id_veterinaire) REFERENCES public.utilisateur(id_utilisateur);


--
-- Name: rapport_veterinaire fk_ce729cde4c9c96f2; Type: FK CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.rapport_veterinaire
    ADD CONSTRAINT fk_ce729cde4c9c96f2 FOREIGN KEY (id_animal) REFERENCES public.animal(id_animal);


--
-- Name: rapport_veterinaire fk_ce729cdef1cbaf4f; Type: FK CONSTRAINT; Schema: public; Owner: arcadia_kevin
--

ALTER TABLE ONLY public.rapport_veterinaire
    ADD CONSTRAINT fk_ce729cdef1cbaf4f FOREIGN KEY (id_veterinaire) REFERENCES public.utilisateur(id_utilisateur);


--
-- PostgreSQL database dump complete
--

