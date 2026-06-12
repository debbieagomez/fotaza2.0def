--
-- PostgreSQL database dump
--

\restrict V5sChc1geVdxh3Qm5opKdcqKbraJBTGxb9Jv952fYSYbhL1On9Wve0aR7uCxfpF

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

-- Started on 2026-06-11 22:38:28

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 901 (class 1247 OID 16631)
-- Name: enum_images_license; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_images_license AS ENUM (
    'free',
    'copyright'
);


ALTER TYPE public.enum_images_license OWNER TO postgres;

--
-- TOC entry 922 (class 1247 OID 16747)
-- Name: enum_notifications_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_notifications_type AS ENUM (
    'comment',
    'rating',
    'interested',
    'follow'
);


ALTER TYPE public.enum_notifications_type OWNER TO postgres;

--
-- TOC entry 895 (class 1247 OID 16602)
-- Name: enum_posts_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_posts_status AS ENUM (
    'active',
    'pending',
    'removed'
);


ALTER TYPE public.enum_posts_status OWNER TO postgres;

--
-- TOC entry 949 (class 1247 OID 16914)
-- Name: enum_validator_queue_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_validator_queue_status AS ENUM (
    'pending',
    'resolved'
);


ALTER TYPE public.enum_validator_queue_status OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 254 (class 1259 OID 16896)
-- Name: collection_posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.collection_posts (
    collection_id integer NOT NULL,
    post_id integer NOT NULL,
    added_at timestamp with time zone
);


ALTER TABLE public.collection_posts OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 16882)
-- Name: collections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.collections (
    id integer NOT NULL,
    user_id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp with time zone
);


ALTER TABLE public.collections OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 16881)
-- Name: collections_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.collections_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.collections_id_seq OWNER TO postgres;

--
-- TOC entry 5237 (class 0 OID 0)
-- Dependencies: 252
-- Name: collections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.collections_id_seq OWNED BY public.collections.id;


--
-- TOC entry 251 (class 1259 OID 16854)
-- Name: comment_reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment_reports (
    id integer NOT NULL,
    comment_id integer NOT NULL,
    user_id integer NOT NULL,
    reason_id integer NOT NULL,
    description text,
    created_at timestamp with time zone
);


ALTER TABLE public.comment_reports OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 16853)
-- Name: comment_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comment_reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comment_reports_id_seq OWNER TO postgres;

--
-- TOC entry 5238 (class 0 OID 0)
-- Dependencies: 250
-- Name: comment_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comment_reports_id_seq OWNED BY public.comment_reports.id;


--
-- TOC entry 237 (class 1259 OID 16683)
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    post_id integer NOT NULL,
    user_id integer NOT NULL,
    body text NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone
);


ALTER TABLE public.comments OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16682)
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comments_id_seq OWNER TO postgres;

--
-- TOC entry 5239 (class 0 OID 0)
-- Dependencies: 236
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- TOC entry 240 (class 1259 OID 16729)
-- Name: followers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.followers (
    follower_id integer NOT NULL,
    following_id integer NOT NULL,
    created_at timestamp with time zone
);


ALTER TABLE public.followers OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 16825)
-- Name: image_reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.image_reports (
    id integer NOT NULL,
    image_id integer NOT NULL,
    user_id integer NOT NULL,
    reason_id integer NOT NULL,
    description text,
    created_at timestamp with time zone
);


ALTER TABLE public.image_reports OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 16824)
-- Name: image_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.image_reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.image_reports_id_seq OWNER TO postgres;

--
-- TOC entry 5240 (class 0 OID 0)
-- Dependencies: 248
-- Name: image_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.image_reports_id_seq OWNED BY public.image_reports.id;


--
-- TOC entry 232 (class 1259 OID 16636)
-- Name: images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.images (
    id integer NOT NULL,
    post_id integer NOT NULL,
    file_path character varying(255) NOT NULL,
    license public.enum_images_license NOT NULL,
    watermark_text character varying(255),
    order_index integer DEFAULT 0,
    created_at timestamp with time zone
);


ALTER TABLE public.images OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16635)
-- Name: images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.images_id_seq OWNER TO postgres;

--
-- TOC entry 5241 (class 0 OID 0)
-- Dependencies: 231
-- Name: images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.images_id_seq OWNED BY public.images.id;


--
-- TOC entry 245 (class 1259 OID 16798)
-- Name: interested; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.interested (
    user_id integer NOT NULL,
    image_id integer NOT NULL,
    created_at timestamp with time zone
);


ALTER TABLE public.interested OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 16774)
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    sender_id integer NOT NULL,
    receiver_id integer NOT NULL,
    post_id integer,
    body text NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16773)
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.messages_id_seq OWNER TO postgres;

--
-- TOC entry 5242 (class 0 OID 0)
-- Dependencies: 243
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- TOC entry 242 (class 1259 OID 16756)
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    actor_id integer NOT NULL,
    type public.enum_notifications_type NOT NULL,
    entity_id integer,
    is_read boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16755)
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_id_seq OWNER TO postgres;

--
-- TOC entry 5243 (class 0 OID 0)
-- Dependencies: 241
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- TOC entry 235 (class 1259 OID 16665)
-- Name: post_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_tags (
    post_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.post_tags OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16610)
-- Name: posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.posts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    status public.enum_posts_status DEFAULT 'active'::public.enum_posts_status NOT NULL,
    comments_open boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.posts OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16609)
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.posts_id_seq OWNER TO postgres;

--
-- TOC entry 5244 (class 0 OID 0)
-- Dependencies: 229
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- TOC entry 239 (class 1259 OID 16708)
-- Name: ratings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ratings (
    id integer NOT NULL,
    image_id integer NOT NULL,
    user_id integer NOT NULL,
    score integer NOT NULL,
    created_at timestamp with time zone
);


ALTER TABLE public.ratings OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16707)
-- Name: ratings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ratings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ratings_id_seq OWNER TO postgres;

--
-- TOC entry 5245 (class 0 OID 0)
-- Dependencies: 238
-- Name: ratings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ratings_id_seq OWNED BY public.ratings.id;


--
-- TOC entry 247 (class 1259 OID 16816)
-- Name: report_reasons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.report_reasons (
    id integer NOT NULL,
    label character varying(255) NOT NULL
);


ALTER TABLE public.report_reasons OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 16815)
-- Name: report_reasons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.report_reasons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.report_reasons_id_seq OWNER TO postgres;

--
-- TOC entry 5246 (class 0 OID 0)
-- Dependencies: 246
-- Name: report_reasons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.report_reasons_id_seq OWNED BY public.report_reasons.id;


--
-- TOC entry 226 (class 1259 OID 16561)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16560)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 5247 (class 0 OID 0)
-- Dependencies: 225
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 234 (class 1259 OID 16655)
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16654)
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tags_id_seq OWNER TO postgres;

--
-- TOC entry 5248 (class 0 OID 0)
-- Dependencies: 233
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- TOC entry 228 (class 1259 OID 16574)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password_hash character varying(255) NOT NULL,
    display_name character varying(100),
    bio text,
    role_id integer DEFAULT 1 NOT NULL,
    strikes integer DEFAULT 0 NOT NULL,
    avatar_url character varying(255),
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16573)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5249 (class 0 OID 0)
-- Dependencies: 227
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 256 (class 1259 OID 16920)
-- Name: validator_queue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.validator_queue (
    id integer NOT NULL,
    post_id integer NOT NULL,
    status public.enum_validator_queue_status DEFAULT 'pending'::public.enum_validator_queue_status NOT NULL,
    resolved_by integer,
    resolution text,
    created_at timestamp with time zone
);


ALTER TABLE public.validator_queue OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 16919)
-- Name: validator_queue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.validator_queue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.validator_queue_id_seq OWNER TO postgres;

--
-- TOC entry 5250 (class 0 OID 0)
-- Dependencies: 255
-- Name: validator_queue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.validator_queue_id_seq OWNED BY public.validator_queue.id;


--
-- TOC entry 4976 (class 2604 OID 16885)
-- Name: collections id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collections ALTER COLUMN id SET DEFAULT nextval('public.collections_id_seq'::regclass);


--
-- TOC entry 4975 (class 2604 OID 16857)
-- Name: comment_reports id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_reports ALTER COLUMN id SET DEFAULT nextval('public.comment_reports_id_seq'::regclass);


--
-- TOC entry 4966 (class 2604 OID 16686)
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- TOC entry 4974 (class 2604 OID 16828)
-- Name: image_reports id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.image_reports ALTER COLUMN id SET DEFAULT nextval('public.image_reports_id_seq'::regclass);


--
-- TOC entry 4963 (class 2604 OID 16639)
-- Name: images id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images ALTER COLUMN id SET DEFAULT nextval('public.images_id_seq'::regclass);


--
-- TOC entry 4971 (class 2604 OID 16777)
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- TOC entry 4969 (class 2604 OID 16759)
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- TOC entry 4960 (class 2604 OID 16613)
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- TOC entry 4968 (class 2604 OID 16711)
-- Name: ratings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings ALTER COLUMN id SET DEFAULT nextval('public.ratings_id_seq'::regclass);


--
-- TOC entry 4973 (class 2604 OID 16819)
-- Name: report_reasons id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report_reasons ALTER COLUMN id SET DEFAULT nextval('public.report_reasons_id_seq'::regclass);


--
-- TOC entry 4955 (class 2604 OID 16564)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 4965 (class 2604 OID 16658)
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- TOC entry 4956 (class 2604 OID 16577)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4977 (class 2604 OID 16923)
-- Name: validator_queue id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validator_queue ALTER COLUMN id SET DEFAULT nextval('public.validator_queue_id_seq'::regclass);


--
-- TOC entry 5229 (class 0 OID 16896)
-- Dependencies: 254
-- Data for Name: collection_posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.collection_posts (collection_id, post_id, added_at) FROM stdin;
1	4	2026-06-10 19:43:15.35-03
2	5	2026-06-10 19:43:15.354-03
\.


--
-- TOC entry 5228 (class 0 OID 16882)
-- Dependencies: 253
-- Data for Name: collections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.collections (id, user_id, name, created_at) FROM stdin;
1	5	Paisajes	2026-06-10 19:43:15.342-03
2	5	Inspiración	2026-06-10 19:43:15.346-03
\.


--
-- TOC entry 5226 (class 0 OID 16854)
-- Dependencies: 251
-- Data for Name: comment_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comment_reports (id, comment_id, user_id, reason_id, description, created_at) FROM stdin;
\.


--
-- TOC entry 5212 (class 0 OID 16683)
-- Dependencies: 237
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (id, post_id, user_id, body, is_deleted, created_at) FROM stdin;
1	3	2	que tiempos	f	2026-06-07 20:04:01.651-03
2	3	2	que hermosas	f	2026-06-07 20:09:55.284-03
3	3	2	pasa el tiempo	f	2026-06-08 19:28:16.494-03
4	3	2	y no te veoooo	f	2026-06-08 19:37:47.222-03
5	3	2	dime donde estasss	f	2026-06-08 19:44:51.894-03
6	4	6	¡Qué foto tan hermosa!	f	2026-06-10 19:43:15.316-03
7	4	7	Me encanta el juego de luces	f	2026-06-10 19:43:15.321-03
8	5	5	Excelente composición	f	2026-06-10 19:43:15.324-03
\.


--
-- TOC entry 5215 (class 0 OID 16729)
-- Dependencies: 240
-- Data for Name: followers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.followers (follower_id, following_id, created_at) FROM stdin;
5	6	2026-06-10 19:43:15.328-03
6	5	2026-06-10 19:43:15.333-03
7	5	2026-06-10 19:43:15.337-03
\.


--
-- TOC entry 5224 (class 0 OID 16825)
-- Dependencies: 249
-- Data for Name: image_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.image_reports (id, image_id, user_id, reason_id, description, created_at) FROM stdin;
\.


--
-- TOC entry 5207 (class 0 OID 16636)
-- Dependencies: 232
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.images (id, post_id, file_path, license, watermark_text, order_index, created_at) FROM stdin;
1	1	/uploads1780864009949-69448383.png	free	\N	0	2026-06-07 17:26:50.078-03
2	2	/uploads1780865514664-864478443.jpg	free	\N	0	2026-06-07 17:51:54.801-03
3	3	/uploads/1780866526042-391981463.jpg	free	\N	0	2026-06-07 18:08:46.213-03
4	4	/uploads/sample1.jpg	free	\N	0	2026-06-10 19:43:15.28-03
5	5	/uploads/sample2.jpg	copyright	© Pedro López	0	2026-06-10 19:43:15.285-03
6	6	/uploads/sample3.jpg	free	\N	0	2026-06-10 19:43:15.288-03
\.


--
-- TOC entry 5220 (class 0 OID 16798)
-- Dependencies: 245
-- Data for Name: interested; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.interested (user_id, image_id, created_at) FROM stdin;
\.


--
-- TOC entry 5219 (class 0 OID 16774)
-- Dependencies: 244
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id, sender_id, receiver_id, post_id, body, is_read, created_at) FROM stdin;
\.


--
-- TOC entry 5217 (class 0 OID 16756)
-- Dependencies: 242
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (id, user_id, actor_id, type, entity_id, is_read, created_at) FROM stdin;
\.


--
-- TOC entry 5210 (class 0 OID 16665)
-- Dependencies: 235
-- Data for Name: post_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.post_tags (post_id, tag_id) FROM stdin;
3	1
3	2
4	3
4	5
5	4
5	6
6	5
6	12
\.


--
-- TOC entry 5205 (class 0 OID 16610)
-- Dependencies: 230
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posts (id, user_id, title, description, status, comments_open, created_at, updated_at) FROM stdin;
1	2	HOLAA	buenas es una prueba	active	t	2026-06-07 17:26:49.96-03	2026-06-07 17:26:49.96-03
2	2	holaa2	\N	active	t	2026-06-07 17:51:54.764-03	2026-06-07 17:51:54.764-03
3	2	hola 3	buenass	active	t	2026-06-07 18:08:46.177-03	2026-06-07 18:08:46.177-03
4	5	Atardecer en la montaña	Hermoso atardecer capturado en la cordillera	active	t	2026-06-10 19:43:15.264-03	2026-06-10 19:43:15.264-03
5	6	Retrato urbano	Fotografía callejera en el centro de la ciudad	active	t	2026-06-10 19:43:15.27-03	2026-06-10 19:43:15.27-03
6	7	Naturaleza salvaje	Flora y fauna en su estado natural	active	t	2026-06-10 19:43:15.274-03	2026-06-10 19:43:15.274-03
\.


--
-- TOC entry 5214 (class 0 OID 16708)
-- Dependencies: 239
-- Data for Name: ratings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ratings (id, image_id, user_id, score, created_at) FROM stdin;
\.


--
-- TOC entry 5222 (class 0 OID 16816)
-- Dependencies: 247
-- Data for Name: report_reasons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.report_reasons (id, label) FROM stdin;
1	Contenido inapropiado
2	Violación de derechos de autor
3	Spam
4	Acoso
5	Información falsa
6	Otro
\.


--
-- TOC entry 5201 (class 0 OID 16561)
-- Dependencies: 226
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name, description) FROM stdin;
1	user	Usuario registrado
2	validator	Validador de contenidos
3	admin	Administrador
\.


--
-- TOC entry 5209 (class 0 OID 16655)
-- Dependencies: 234
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tags (id, name) FROM stdin;
1	yo
2	amigas
3	paisaje
4	retrato
5	naturaleza
6	ciudad
7	blanco y negro
8	macro
9	arquitectura
10	viaje
11	abstracto
12	animales
\.


--
-- TOC entry 5203 (class 0 OID 16574)
-- Dependencies: 228
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, email, password_hash, display_name, bio, role_id, strikes, avatar_url, is_active, created_at) FROM stdin;
2	Debbie	debbie@test.com	$2b$10$UHJSYfrCLauIZFJ0HqI12OTFC.MElLY0sx105MBNbbo2Q2KkPMrnC	Debbie	\N	1	0	\N	t	2026-06-06 01:23:06.078-03
3	admin	admin@fotaza.com	$2b$10$a6C.TIH5B4gFNNFbKZZHT.47kld/hBhoAQHLOJRsINPISG6q8XeWK	Administrador	\N	3	0	\N	t	2026-06-10 19:43:15.125-03
4	validador	validator@fotaza.com	$2b$10$a6C.TIH5B4gFNNFbKZZHT.47kld/hBhoAQHLOJRsINPISG6q8XeWK	Juan Validador	\N	2	0	\N	t	2026-06-10 19:43:15.184-03
5	maria	maria@fotaza.com	$2b$10$a6C.TIH5B4gFNNFbKZZHT.47kld/hBhoAQHLOJRsINPISG6q8XeWK	María García	\N	1	0	\N	t	2026-06-10 19:43:15.189-03
6	pedro	pedro@fotaza.com	$2b$10$a6C.TIH5B4gFNNFbKZZHT.47kld/hBhoAQHLOJRsINPISG6q8XeWK	Pedro López	\N	1	0	\N	t	2026-06-10 19:43:15.193-03
7	ana	ana@fotaza.com	$2b$10$a6C.TIH5B4gFNNFbKZZHT.47kld/hBhoAQHLOJRsINPISG6q8XeWK	Ana Martínez	\N	1	0	\N	t	2026-06-10 19:43:15.197-03
\.


--
-- TOC entry 5231 (class 0 OID 16920)
-- Dependencies: 256
-- Data for Name: validator_queue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.validator_queue (id, post_id, status, resolved_by, resolution, created_at) FROM stdin;
\.


--
-- TOC entry 5251 (class 0 OID 0)
-- Dependencies: 252
-- Name: collections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.collections_id_seq', 2, true);


--
-- TOC entry 5252 (class 0 OID 0)
-- Dependencies: 250
-- Name: comment_reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comment_reports_id_seq', 1, false);


--
-- TOC entry 5253 (class 0 OID 0)
-- Dependencies: 236
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_id_seq', 8, true);


--
-- TOC entry 5254 (class 0 OID 0)
-- Dependencies: 248
-- Name: image_reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.image_reports_id_seq', 1, false);


--
-- TOC entry 5255 (class 0 OID 0)
-- Dependencies: 231
-- Name: images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.images_id_seq', 6, true);


--
-- TOC entry 5256 (class 0 OID 0)
-- Dependencies: 243
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.messages_id_seq', 1, false);


--
-- TOC entry 5257 (class 0 OID 0)
-- Dependencies: 241
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_id_seq', 1, false);


--
-- TOC entry 5258 (class 0 OID 0)
-- Dependencies: 229
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.posts_id_seq', 6, true);


--
-- TOC entry 5259 (class 0 OID 0)
-- Dependencies: 238
-- Name: ratings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ratings_id_seq', 1, false);


--
-- TOC entry 5260 (class 0 OID 0)
-- Dependencies: 246
-- Name: report_reasons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.report_reasons_id_seq', 1, false);


--
-- TOC entry 5261 (class 0 OID 0)
-- Dependencies: 225
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, false);


--
-- TOC entry 5262 (class 0 OID 0)
-- Dependencies: 233
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tags_id_seq', 12, true);


--
-- TOC entry 5263 (class 0 OID 0)
-- Dependencies: 227
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 7, true);


--
-- TOC entry 5264 (class 0 OID 0)
-- Dependencies: 255
-- Name: validator_queue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.validator_queue_id_seq', 1, false);


--
-- TOC entry 5022 (class 2606 OID 16902)
-- Name: collection_posts collection_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_posts
    ADD CONSTRAINT collection_posts_pkey PRIMARY KEY (collection_id, post_id);


--
-- TOC entry 5020 (class 2606 OID 16890)
-- Name: collections collections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT collections_pkey PRIMARY KEY (id);


--
-- TOC entry 5018 (class 2606 OID 16865)
-- Name: comment_reports comment_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_reports
    ADD CONSTRAINT comment_reports_pkey PRIMARY KEY (id);


--
-- TOC entry 5000 (class 2606 OID 16696)
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- TOC entry 5005 (class 2606 OID 16735)
-- Name: followers followers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followers
    ADD CONSTRAINT followers_pkey PRIMARY KEY (follower_id, following_id);


--
-- TOC entry 5016 (class 2606 OID 16836)
-- Name: image_reports image_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.image_reports
    ADD CONSTRAINT image_reports_pkey PRIMARY KEY (id);


--
-- TOC entry 4992 (class 2606 OID 16648)
-- Name: images images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);


--
-- TOC entry 5011 (class 2606 OID 16804)
-- Name: interested interested_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interested
    ADD CONSTRAINT interested_pkey PRIMARY KEY (user_id, image_id);


--
-- TOC entry 5009 (class 2606 OID 16787)
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- TOC entry 5007 (class 2606 OID 16767)
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- TOC entry 4998 (class 2606 OID 16671)
-- Name: post_tags post_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_tags
    ADD CONSTRAINT post_tags_pkey PRIMARY KEY (post_id, tag_id);


--
-- TOC entry 4990 (class 2606 OID 16624)
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- TOC entry 5003 (class 2606 OID 16717)
-- Name: ratings ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_pkey PRIMARY KEY (id);


--
-- TOC entry 5013 (class 2606 OID 16823)
-- Name: report_reasons report_reasons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report_reasons
    ADD CONSTRAINT report_reasons_pkey PRIMARY KEY (id);


--
-- TOC entry 4980 (class 2606 OID 16572)
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- TOC entry 4982 (class 2606 OID 16570)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4994 (class 2606 OID 16664)
-- Name: tags tags_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_name_key UNIQUE (name);


--
-- TOC entry 4996 (class 2606 OID 16662)
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- TOC entry 4984 (class 2606 OID 16595)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4986 (class 2606 OID 16591)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4988 (class 2606 OID 16593)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 5024 (class 2606 OID 16931)
-- Name: validator_queue validator_queue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validator_queue
    ADD CONSTRAINT validator_queue_pkey PRIMARY KEY (id);


--
-- TOC entry 5026 (class 2606 OID 16933)
-- Name: validator_queue validator_queue_post_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validator_queue
    ADD CONSTRAINT validator_queue_post_id_key UNIQUE (post_id);


--
-- TOC entry 5014 (class 1259 OID 16852)
-- Name: image_reports_image_id_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX image_reports_image_id_user_id ON public.image_reports USING btree (image_id, user_id);


--
-- TOC entry 5001 (class 1259 OID 16728)
-- Name: ratings_image_id_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ratings_image_id_user_id ON public.ratings USING btree (image_id, user_id);


--
-- TOC entry 5050 (class 2606 OID 16903)
-- Name: collection_posts collection_posts_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_posts
    ADD CONSTRAINT collection_posts_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES public.collections(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5051 (class 2606 OID 16908)
-- Name: collection_posts collection_posts_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_posts
    ADD CONSTRAINT collection_posts_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5049 (class 2606 OID 16891)
-- Name: collections collections_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT collections_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5046 (class 2606 OID 16866)
-- Name: comment_reports comment_reports_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_reports
    ADD CONSTRAINT comment_reports_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES public.comments(id) ON UPDATE CASCADE;


--
-- TOC entry 5047 (class 2606 OID 16876)
-- Name: comment_reports comment_reports_reason_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_reports
    ADD CONSTRAINT comment_reports_reason_id_fkey FOREIGN KEY (reason_id) REFERENCES public.report_reasons(id) ON UPDATE CASCADE;


--
-- TOC entry 5048 (class 2606 OID 16871)
-- Name: comment_reports comment_reports_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_reports
    ADD CONSTRAINT comment_reports_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- TOC entry 5032 (class 2606 OID 16697)
-- Name: comments comments_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5033 (class 2606 OID 16702)
-- Name: comments comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5036 (class 2606 OID 16736)
-- Name: followers followers_follower_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followers
    ADD CONSTRAINT followers_follower_id_fkey FOREIGN KEY (follower_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5037 (class 2606 OID 16741)
-- Name: followers followers_following_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followers
    ADD CONSTRAINT followers_following_id_fkey FOREIGN KEY (following_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5043 (class 2606 OID 16837)
-- Name: image_reports image_reports_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.image_reports
    ADD CONSTRAINT image_reports_image_id_fkey FOREIGN KEY (image_id) REFERENCES public.images(id) ON UPDATE CASCADE;


--
-- TOC entry 5044 (class 2606 OID 16847)
-- Name: image_reports image_reports_reason_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.image_reports
    ADD CONSTRAINT image_reports_reason_id_fkey FOREIGN KEY (reason_id) REFERENCES public.report_reasons(id) ON UPDATE CASCADE;


--
-- TOC entry 5045 (class 2606 OID 16842)
-- Name: image_reports image_reports_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.image_reports
    ADD CONSTRAINT image_reports_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- TOC entry 5029 (class 2606 OID 16649)
-- Name: images images_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5041 (class 2606 OID 16810)
-- Name: interested interested_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interested
    ADD CONSTRAINT interested_image_id_fkey FOREIGN KEY (image_id) REFERENCES public.images(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5042 (class 2606 OID 16805)
-- Name: interested interested_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interested
    ADD CONSTRAINT interested_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5039 (class 2606 OID 16793)
-- Name: messages messages_receiver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_receiver_id_fkey FOREIGN KEY (receiver_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5040 (class 2606 OID 16788)
-- Name: messages messages_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5038 (class 2606 OID 16768)
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5030 (class 2606 OID 16672)
-- Name: post_tags post_tags_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_tags
    ADD CONSTRAINT post_tags_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5031 (class 2606 OID 16677)
-- Name: post_tags post_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_tags
    ADD CONSTRAINT post_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5028 (class 2606 OID 16625)
-- Name: posts posts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5034 (class 2606 OID 16718)
-- Name: ratings ratings_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_image_id_fkey FOREIGN KEY (image_id) REFERENCES public.images(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5035 (class 2606 OID 16723)
-- Name: ratings ratings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5027 (class 2606 OID 16596)
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5052 (class 2606 OID 16934)
-- Name: validator_queue validator_queue_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validator_queue
    ADD CONSTRAINT validator_queue_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2026-06-11 22:38:28

--
-- PostgreSQL database dump complete
--

\unrestrict V5sChc1geVdxh3Qm5opKdcqKbraJBTGxb9Jv952fYSYbhL1On9Wve0aR7uCxfpF

