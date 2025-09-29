--
-- PostgreSQL database cluster dump
--

\restrict ib0Bmt08KJpLIhfTkWOoQLktX2xZXFJ7IslWj5ZIiTMMFvcSZiqP87iMRlgELoj

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:4ax4ZUBmT9e1gyEwj3WjwQ==$vo+Ep4x4fGBz6Lg8idT7WYKxcQCA/1vECgi0vmcHyi8=:BrCLogx6uZoi4KgHok2Jd+lPklV8byM2D1SbuXO4glc=';

--
-- User Configurations
--








\unrestrict ib0Bmt08KJpLIhfTkWOoQLktX2xZXFJ7IslWj5ZIiTMMFvcSZiqP87iMRlgELoj

--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

\restrict bPf5oR9xt1ZruFw6jVvOZBmz7kyZ3n6gR4gM1F5G9KpqNEM0WoxtaMNwqo1w7dG

-- Dumped from database version 15.14 (Debian 15.14-1.pgdg13+1)
-- Dumped by pg_dump version 15.14 (Debian 15.14-1.pgdg13+1)

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
-- PostgreSQL database dump complete
--

\unrestrict bPf5oR9xt1ZruFw6jVvOZBmz7kyZ3n6gR4gM1F5G9KpqNEM0WoxtaMNwqo1w7dG

--
-- Database "airflow" dump
--

--
-- PostgreSQL database dump
--

\restrict 1GUACJkFGE6lK6MOOReC3FBIW464Wmt6Ig5G96FxghXT3owKlsnv8I7v9HT5mca

-- Dumped from database version 15.14 (Debian 15.14-1.pgdg13+1)
-- Dumped by pg_dump version 15.14 (Debian 15.14-1.pgdg13+1)

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
-- Name: airflow; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE airflow WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE airflow OWNER TO postgres;

\unrestrict 1GUACJkFGE6lK6MOOReC3FBIW464Wmt6Ig5G96FxghXT3owKlsnv8I7v9HT5mca
\connect airflow
\restrict 1GUACJkFGE6lK6MOOReC3FBIW464Wmt6Ig5G96FxghXT3owKlsnv8I7v9HT5mca

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
-- Name: ab_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ab_group (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    label character varying(150),
    description character varying(512)
);


ALTER TABLE public.ab_group OWNER TO postgres;

--
-- Name: ab_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ab_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ab_group_id_seq OWNER TO postgres;

--
-- Name: ab_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ab_group_id_seq OWNED BY public.ab_group.id;


--
-- Name: ab_group_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ab_group_role (
    id integer NOT NULL,
    group_id integer,
    role_id integer
);


ALTER TABLE public.ab_group_role OWNER TO postgres;

--
-- Name: ab_group_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ab_group_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ab_group_role_id_seq OWNER TO postgres;

--
-- Name: ab_group_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ab_group_role_id_seq OWNED BY public.ab_group_role.id;


--
-- Name: ab_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ab_permission (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.ab_permission OWNER TO postgres;

--
-- Name: ab_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ab_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ab_permission_id_seq OWNER TO postgres;

--
-- Name: ab_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ab_permission_id_seq OWNED BY public.ab_permission.id;


--
-- Name: ab_permission_view; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ab_permission_view (
    id integer NOT NULL,
    permission_id integer,
    view_menu_id integer
);


ALTER TABLE public.ab_permission_view OWNER TO postgres;

--
-- Name: ab_permission_view_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ab_permission_view_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ab_permission_view_id_seq OWNER TO postgres;

--
-- Name: ab_permission_view_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ab_permission_view_id_seq OWNED BY public.ab_permission_view.id;


--
-- Name: ab_permission_view_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ab_permission_view_role (
    id integer NOT NULL,
    permission_view_id integer,
    role_id integer
);


ALTER TABLE public.ab_permission_view_role OWNER TO postgres;

--
-- Name: ab_permission_view_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ab_permission_view_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ab_permission_view_role_id_seq OWNER TO postgres;

--
-- Name: ab_permission_view_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ab_permission_view_role_id_seq OWNED BY public.ab_permission_view_role.id;


--
-- Name: ab_register_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ab_register_user (
    id integer NOT NULL,
    first_name character varying(256) NOT NULL,
    last_name character varying(256) NOT NULL,
    username character varying(512) NOT NULL,
    password character varying(256),
    email character varying(512) NOT NULL,
    registration_date timestamp without time zone,
    registration_hash character varying(256)
);


ALTER TABLE public.ab_register_user OWNER TO postgres;

--
-- Name: ab_register_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ab_register_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ab_register_user_id_seq OWNER TO postgres;

--
-- Name: ab_register_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ab_register_user_id_seq OWNED BY public.ab_register_user.id;


--
-- Name: ab_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ab_role (
    id integer NOT NULL,
    name character varying(64) NOT NULL
);


ALTER TABLE public.ab_role OWNER TO postgres;

--
-- Name: ab_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ab_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ab_role_id_seq OWNER TO postgres;

--
-- Name: ab_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ab_role_id_seq OWNED BY public.ab_role.id;


--
-- Name: ab_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ab_user (
    id integer NOT NULL,
    first_name character varying(256) NOT NULL,
    last_name character varying(256) NOT NULL,
    username character varying(512) NOT NULL,
    password character varying(256),
    active boolean,
    email character varying(512) NOT NULL,
    last_login timestamp without time zone,
    login_count integer,
    fail_login_count integer,
    created_on timestamp without time zone,
    changed_on timestamp without time zone,
    created_by_fk integer,
    changed_by_fk integer
);


ALTER TABLE public.ab_user OWNER TO postgres;

--
-- Name: ab_user_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ab_user_group (
    id integer NOT NULL,
    user_id integer,
    group_id integer
);


ALTER TABLE public.ab_user_group OWNER TO postgres;

--
-- Name: ab_user_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ab_user_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ab_user_group_id_seq OWNER TO postgres;

--
-- Name: ab_user_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ab_user_group_id_seq OWNED BY public.ab_user_group.id;


--
-- Name: ab_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ab_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ab_user_id_seq OWNER TO postgres;

--
-- Name: ab_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ab_user_id_seq OWNED BY public.ab_user.id;


--
-- Name: ab_user_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ab_user_role (
    id integer NOT NULL,
    user_id integer,
    role_id integer
);


ALTER TABLE public.ab_user_role OWNER TO postgres;

--
-- Name: ab_user_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ab_user_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ab_user_role_id_seq OWNER TO postgres;

--
-- Name: ab_user_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ab_user_role_id_seq OWNED BY public.ab_user_role.id;


--
-- Name: ab_view_menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ab_view_menu (
    id integer NOT NULL,
    name character varying(250) NOT NULL
);


ALTER TABLE public.ab_view_menu OWNER TO postgres;

--
-- Name: ab_view_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ab_view_menu_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ab_view_menu_id_seq OWNER TO postgres;

--
-- Name: ab_view_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ab_view_menu_id_seq OWNED BY public.ab_view_menu.id;


--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- Name: alembic_version_fab; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version_fab (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version_fab OWNER TO postgres;

--
-- Name: asset; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asset (
    id integer NOT NULL,
    name character varying(1500) NOT NULL,
    uri character varying(1500) NOT NULL,
    "group" character varying(1500) NOT NULL,
    extra json NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.asset OWNER TO postgres;

--
-- Name: asset_active; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asset_active (
    name character varying(1500) NOT NULL,
    uri character varying(1500) NOT NULL
);


ALTER TABLE public.asset_active OWNER TO postgres;

--
-- Name: asset_alias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asset_alias (
    id integer NOT NULL,
    name character varying(1500) NOT NULL,
    "group" character varying(1500) NOT NULL
);


ALTER TABLE public.asset_alias OWNER TO postgres;

--
-- Name: asset_alias_asset; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asset_alias_asset (
    alias_id integer NOT NULL,
    asset_id integer NOT NULL
);


ALTER TABLE public.asset_alias_asset OWNER TO postgres;

--
-- Name: asset_alias_asset_event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asset_alias_asset_event (
    alias_id integer NOT NULL,
    event_id integer NOT NULL
);


ALTER TABLE public.asset_alias_asset_event OWNER TO postgres;

--
-- Name: asset_alias_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.asset_alias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.asset_alias_id_seq OWNER TO postgres;

--
-- Name: asset_alias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.asset_alias_id_seq OWNED BY public.asset_alias.id;


--
-- Name: asset_dag_run_queue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asset_dag_run_queue (
    asset_id integer NOT NULL,
    target_dag_id character varying(250) NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.asset_dag_run_queue OWNER TO postgres;

--
-- Name: asset_event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asset_event (
    id integer NOT NULL,
    asset_id integer NOT NULL,
    extra json NOT NULL,
    source_task_id character varying(250),
    source_dag_id character varying(250),
    source_run_id character varying(250),
    source_map_index integer DEFAULT '-1'::integer,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.asset_event OWNER TO postgres;

--
-- Name: asset_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.asset_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.asset_event_id_seq OWNER TO postgres;

--
-- Name: asset_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.asset_event_id_seq OWNED BY public.asset_event.id;


--
-- Name: asset_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.asset_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.asset_id_seq OWNER TO postgres;

--
-- Name: asset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.asset_id_seq OWNED BY public.asset.id;


--
-- Name: asset_trigger; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asset_trigger (
    asset_id integer NOT NULL,
    trigger_id integer NOT NULL
);


ALTER TABLE public.asset_trigger OWNER TO postgres;

--
-- Name: backfill; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backfill (
    id integer NOT NULL,
    dag_id character varying(250) NOT NULL,
    from_date timestamp with time zone NOT NULL,
    to_date timestamp with time zone NOT NULL,
    dag_run_conf json NOT NULL,
    is_paused boolean,
    reprocess_behavior character varying(250) NOT NULL,
    max_active_runs integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    completed_at timestamp with time zone,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.backfill OWNER TO postgres;

--
-- Name: backfill_dag_run; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backfill_dag_run (
    id integer NOT NULL,
    backfill_id integer NOT NULL,
    dag_run_id integer,
    exception_reason character varying(250),
    logical_date timestamp with time zone NOT NULL,
    sort_ordinal integer NOT NULL
);


ALTER TABLE public.backfill_dag_run OWNER TO postgres;

--
-- Name: backfill_dag_run_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backfill_dag_run_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backfill_dag_run_id_seq OWNER TO postgres;

--
-- Name: backfill_dag_run_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backfill_dag_run_id_seq OWNED BY public.backfill_dag_run.id;


--
-- Name: backfill_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backfill_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backfill_id_seq OWNER TO postgres;

--
-- Name: backfill_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backfill_id_seq OWNED BY public.backfill.id;


--
-- Name: callback_request; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.callback_request (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    priority_weight integer NOT NULL,
    callback_data jsonb NOT NULL,
    callback_type character varying(20) NOT NULL
);


ALTER TABLE public.callback_request OWNER TO postgres;

--
-- Name: callback_request_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.callback_request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.callback_request_id_seq OWNER TO postgres;

--
-- Name: callback_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.callback_request_id_seq OWNED BY public.callback_request.id;


--
-- Name: connection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.connection (
    id integer NOT NULL,
    conn_id character varying(250) NOT NULL,
    conn_type character varying(500) NOT NULL,
    description text,
    host character varying(500),
    schema character varying(500),
    login text,
    password text,
    port integer,
    is_encrypted boolean,
    is_extra_encrypted boolean,
    extra text
);


ALTER TABLE public.connection OWNER TO postgres;

--
-- Name: connection_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.connection_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.connection_id_seq OWNER TO postgres;

--
-- Name: connection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.connection_id_seq OWNED BY public.connection.id;


--
-- Name: dag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dag (
    dag_id character varying(250) NOT NULL,
    is_paused boolean,
    is_stale boolean,
    last_parsed_time timestamp with time zone,
    last_expired timestamp with time zone,
    fileloc character varying(2000),
    relative_fileloc character varying(2000),
    bundle_name character varying(250),
    bundle_version character varying(200),
    owners character varying(2000),
    dag_display_name character varying(2000),
    description text,
    timetable_summary text,
    timetable_description character varying(1000),
    asset_expression json,
    max_active_tasks integer NOT NULL,
    max_active_runs integer,
    max_consecutive_failed_dag_runs integer NOT NULL,
    has_task_concurrency_limits boolean NOT NULL,
    has_import_errors boolean DEFAULT false,
    next_dagrun timestamp with time zone,
    next_dagrun_data_interval_start timestamp with time zone,
    next_dagrun_data_interval_end timestamp with time zone,
    next_dagrun_create_after timestamp with time zone
);


ALTER TABLE public.dag OWNER TO postgres;

--
-- Name: dag_bundle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dag_bundle (
    name character varying(250) NOT NULL,
    active boolean,
    version character varying(200),
    last_refreshed timestamp with time zone
);


ALTER TABLE public.dag_bundle OWNER TO postgres;

--
-- Name: dag_code; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dag_code (
    id uuid NOT NULL,
    dag_id character varying(250) NOT NULL,
    fileloc character varying(2000) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    last_updated timestamp with time zone NOT NULL,
    source_code text NOT NULL,
    source_code_hash character varying(32) NOT NULL,
    dag_version_id uuid NOT NULL
);


ALTER TABLE public.dag_code OWNER TO postgres;

--
-- Name: dag_owner_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dag_owner_attributes (
    dag_id character varying(250) NOT NULL,
    owner character varying(500) NOT NULL,
    link character varying(500) NOT NULL
);


ALTER TABLE public.dag_owner_attributes OWNER TO postgres;

--
-- Name: dag_priority_parsing_request; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dag_priority_parsing_request (
    id character varying(32) NOT NULL,
    bundle_name character varying(250) NOT NULL,
    relative_fileloc character varying(2000) NOT NULL
);


ALTER TABLE public.dag_priority_parsing_request OWNER TO postgres;

--
-- Name: dag_run; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dag_run (
    id integer NOT NULL,
    dag_id character varying(250) NOT NULL,
    queued_at timestamp with time zone,
    logical_date timestamp with time zone,
    start_date timestamp with time zone,
    end_date timestamp with time zone,
    state character varying(50),
    run_id character varying(250) NOT NULL,
    creating_job_id integer,
    run_type character varying(50) NOT NULL,
    triggered_by character varying(50),
    conf jsonb,
    data_interval_start timestamp with time zone,
    data_interval_end timestamp with time zone,
    run_after timestamp with time zone NOT NULL,
    last_scheduling_decision timestamp with time zone,
    log_template_id integer,
    updated_at timestamp with time zone,
    clear_number integer DEFAULT 0 NOT NULL,
    backfill_id integer,
    bundle_version character varying(250),
    scheduled_by_job_id integer,
    context_carrier jsonb,
    span_status character varying(250) DEFAULT 'not_started'::character varying NOT NULL,
    created_dag_version_id uuid
);


ALTER TABLE public.dag_run OWNER TO postgres;

--
-- Name: dag_run_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dag_run_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dag_run_id_seq OWNER TO postgres;

--
-- Name: dag_run_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dag_run_id_seq OWNED BY public.dag_run.id;


--
-- Name: dag_run_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dag_run_note (
    user_id character varying(128),
    dag_run_id integer NOT NULL,
    content character varying(1000),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.dag_run_note OWNER TO postgres;

--
-- Name: dag_schedule_asset_alias_reference; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dag_schedule_asset_alias_reference (
    alias_id integer NOT NULL,
    dag_id character varying(250) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.dag_schedule_asset_alias_reference OWNER TO postgres;

--
-- Name: dag_schedule_asset_name_reference; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dag_schedule_asset_name_reference (
    name character varying(1500) NOT NULL,
    dag_id character varying(250) NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.dag_schedule_asset_name_reference OWNER TO postgres;

--
-- Name: dag_schedule_asset_reference; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dag_schedule_asset_reference (
    asset_id integer NOT NULL,
    dag_id character varying(250) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.dag_schedule_asset_reference OWNER TO postgres;

--
-- Name: dag_schedule_asset_uri_reference; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dag_schedule_asset_uri_reference (
    uri character varying(1500) NOT NULL,
    dag_id character varying(250) NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.dag_schedule_asset_uri_reference OWNER TO postgres;

--
-- Name: dag_tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dag_tag (
    name character varying(100) NOT NULL,
    dag_id character varying(250) NOT NULL
);


ALTER TABLE public.dag_tag OWNER TO postgres;

--
-- Name: dag_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dag_version (
    id uuid NOT NULL,
    version_number integer NOT NULL,
    dag_id character varying(250) NOT NULL,
    bundle_name character varying(250),
    bundle_version character varying(250),
    created_at timestamp with time zone NOT NULL,
    last_updated timestamp with time zone NOT NULL
);


ALTER TABLE public.dag_version OWNER TO postgres;

--
-- Name: dag_warning; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dag_warning (
    dag_id character varying(250) NOT NULL,
    warning_type character varying(50) NOT NULL,
    message text NOT NULL,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.dag_warning OWNER TO postgres;

--
-- Name: dagrun_asset_event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dagrun_asset_event (
    dag_run_id integer NOT NULL,
    event_id integer NOT NULL
);


ALTER TABLE public.dagrun_asset_event OWNER TO postgres;

--
-- Name: deadline; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deadline (
    id uuid NOT NULL,
    dag_id character varying(250),
    dagrun_id integer,
    deadline timestamp without time zone NOT NULL,
    callback character varying(500) NOT NULL,
    callback_kwargs json
);


ALTER TABLE public.deadline OWNER TO postgres;

--
-- Name: import_error; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.import_error (
    id integer NOT NULL,
    "timestamp" timestamp with time zone,
    filename character varying(1024),
    bundle_name character varying(250),
    stacktrace text
);


ALTER TABLE public.import_error OWNER TO postgres;

--
-- Name: import_error_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.import_error_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.import_error_id_seq OWNER TO postgres;

--
-- Name: import_error_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.import_error_id_seq OWNED BY public.import_error.id;


--
-- Name: job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job (
    id integer NOT NULL,
    dag_id character varying(250),
    state character varying(20),
    job_type character varying(30),
    start_date timestamp with time zone,
    end_date timestamp with time zone,
    latest_heartbeat timestamp with time zone,
    executor_class character varying(500),
    hostname character varying(500),
    unixname character varying(1000)
);


ALTER TABLE public.job OWNER TO postgres;

--
-- Name: job_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.job_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.job_id_seq OWNER TO postgres;

--
-- Name: job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.job_id_seq OWNED BY public.job.id;


--
-- Name: log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.log (
    id integer NOT NULL,
    dttm timestamp with time zone,
    dag_id character varying(250),
    task_id character varying(250),
    map_index integer,
    event character varying(60),
    logical_date timestamp with time zone,
    run_id character varying(250),
    owner character varying(500),
    owner_display_name character varying(500),
    extra text,
    try_number integer
);


ALTER TABLE public.log OWNER TO postgres;

--
-- Name: log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.log_id_seq OWNER TO postgres;

--
-- Name: log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.log_id_seq OWNED BY public.log.id;


--
-- Name: log_template; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.log_template (
    id integer NOT NULL,
    filename text NOT NULL,
    elasticsearch_id text NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.log_template OWNER TO postgres;

--
-- Name: log_template_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.log_template_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.log_template_id_seq OWNER TO postgres;

--
-- Name: log_template_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.log_template_id_seq OWNED BY public.log_template.id;


--
-- Name: rendered_task_instance_fields; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rendered_task_instance_fields (
    dag_id character varying(250) NOT NULL,
    task_id character varying(250) NOT NULL,
    run_id character varying(250) NOT NULL,
    map_index integer DEFAULT '-1'::integer NOT NULL,
    rendered_fields json NOT NULL,
    k8s_pod_yaml json
);


ALTER TABLE public.rendered_task_instance_fields OWNER TO postgres;

--
-- Name: serialized_dag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serialized_dag (
    id uuid NOT NULL,
    dag_id character varying(250) NOT NULL,
    data json,
    data_compressed bytea,
    created_at timestamp with time zone NOT NULL,
    last_updated timestamp with time zone NOT NULL,
    dag_hash character varying(32) NOT NULL,
    dag_version_id uuid NOT NULL
);


ALTER TABLE public.serialized_dag OWNER TO postgres;

--
-- Name: session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.session (
    id integer NOT NULL,
    session_id character varying(255),
    data bytea,
    expiry timestamp without time zone
);


ALTER TABLE public.session OWNER TO postgres;

--
-- Name: session_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.session_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.session_id_seq OWNER TO postgres;

--
-- Name: session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.session_id_seq OWNED BY public.session.id;


--
-- Name: slot_pool; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.slot_pool (
    id integer NOT NULL,
    pool character varying(256),
    slots integer,
    description text,
    include_deferred boolean NOT NULL
);


ALTER TABLE public.slot_pool OWNER TO postgres;

--
-- Name: slot_pool_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.slot_pool_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.slot_pool_id_seq OWNER TO postgres;

--
-- Name: slot_pool_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.slot_pool_id_seq OWNED BY public.slot_pool.id;


--
-- Name: task_instance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_instance (
    id uuid NOT NULL,
    task_id character varying(250) NOT NULL,
    dag_id character varying(250) NOT NULL,
    run_id character varying(250) NOT NULL,
    map_index integer DEFAULT '-1'::integer NOT NULL,
    start_date timestamp with time zone,
    end_date timestamp with time zone,
    duration double precision,
    state character varying(20),
    try_number integer,
    max_tries integer DEFAULT '-1'::integer,
    hostname character varying(1000),
    unixname character varying(1000),
    pool character varying(256) NOT NULL,
    pool_slots integer NOT NULL,
    queue character varying(256),
    priority_weight integer,
    operator character varying(1000),
    custom_operator_name character varying(1000),
    queued_dttm timestamp with time zone,
    scheduled_dttm timestamp with time zone,
    queued_by_job_id integer,
    last_heartbeat_at timestamp with time zone,
    pid integer,
    executor character varying(1000),
    executor_config bytea,
    updated_at timestamp with time zone,
    rendered_map_index character varying(250),
    context_carrier jsonb,
    span_status character varying(250) DEFAULT 'not_started'::character varying NOT NULL,
    external_executor_id character varying(250),
    trigger_id integer,
    trigger_timeout timestamp with time zone,
    next_method character varying(1000),
    next_kwargs jsonb,
    task_display_name character varying(2000),
    dag_version_id uuid
);


ALTER TABLE public.task_instance OWNER TO postgres;

--
-- Name: task_instance_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_instance_history (
    task_instance_id uuid NOT NULL,
    task_id character varying(250) NOT NULL,
    dag_id character varying(250) NOT NULL,
    run_id character varying(250) NOT NULL,
    map_index integer DEFAULT '-1'::integer NOT NULL,
    try_number integer NOT NULL,
    start_date timestamp with time zone,
    end_date timestamp with time zone,
    duration double precision,
    state character varying(20),
    max_tries integer DEFAULT '-1'::integer,
    hostname character varying(1000),
    unixname character varying(1000),
    pool character varying(256) NOT NULL,
    pool_slots integer NOT NULL,
    queue character varying(256),
    priority_weight integer,
    operator character varying(1000),
    custom_operator_name character varying(1000),
    queued_dttm timestamp with time zone,
    scheduled_dttm timestamp with time zone,
    queued_by_job_id integer,
    pid integer,
    executor character varying(1000),
    executor_config bytea,
    updated_at timestamp with time zone,
    rendered_map_index character varying(250),
    context_carrier jsonb,
    span_status character varying(250) DEFAULT 'not_started'::character varying NOT NULL,
    external_executor_id character varying(250),
    trigger_id integer,
    trigger_timeout timestamp without time zone,
    next_method character varying(1000),
    next_kwargs jsonb,
    task_display_name character varying(2000),
    dag_version_id uuid
);


ALTER TABLE public.task_instance_history OWNER TO postgres;

--
-- Name: task_instance_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_instance_note (
    ti_id uuid NOT NULL,
    user_id character varying(128),
    content character varying(1000),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.task_instance_note OWNER TO postgres;

--
-- Name: task_map; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_map (
    dag_id character varying(250) NOT NULL,
    task_id character varying(250) NOT NULL,
    run_id character varying(250) NOT NULL,
    map_index integer NOT NULL,
    length integer NOT NULL,
    keys jsonb,
    CONSTRAINT ck_task_map_task_map_length_not_negative CHECK ((length >= 0))
);


ALTER TABLE public.task_map OWNER TO postgres;

--
-- Name: task_outlet_asset_reference; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_outlet_asset_reference (
    asset_id integer NOT NULL,
    dag_id character varying(250) NOT NULL,
    task_id character varying(250) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.task_outlet_asset_reference OWNER TO postgres;

--
-- Name: task_reschedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_reschedule (
    id integer NOT NULL,
    ti_id uuid NOT NULL,
    start_date timestamp with time zone NOT NULL,
    end_date timestamp with time zone NOT NULL,
    duration integer NOT NULL,
    reschedule_date timestamp with time zone NOT NULL
);


ALTER TABLE public.task_reschedule OWNER TO postgres;

--
-- Name: task_reschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.task_reschedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_reschedule_id_seq OWNER TO postgres;

--
-- Name: task_reschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.task_reschedule_id_seq OWNED BY public.task_reschedule.id;


--
-- Name: trigger; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trigger (
    id integer NOT NULL,
    classpath character varying(1000) NOT NULL,
    kwargs text NOT NULL,
    created_date timestamp with time zone NOT NULL,
    triggerer_id integer
);


ALTER TABLE public.trigger OWNER TO postgres;

--
-- Name: trigger_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.trigger_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trigger_id_seq OWNER TO postgres;

--
-- Name: trigger_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trigger_id_seq OWNED BY public.trigger.id;


--
-- Name: variable; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.variable (
    id integer NOT NULL,
    key character varying(250),
    val text,
    description text,
    is_encrypted boolean
);


ALTER TABLE public.variable OWNER TO postgres;

--
-- Name: variable_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.variable_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.variable_id_seq OWNER TO postgres;

--
-- Name: variable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.variable_id_seq OWNED BY public.variable.id;


--
-- Name: xcom; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.xcom (
    dag_run_id integer NOT NULL,
    task_id character varying(250) NOT NULL,
    map_index integer DEFAULT '-1'::integer NOT NULL,
    key character varying(512) NOT NULL,
    dag_id character varying(250) NOT NULL,
    run_id character varying(250) NOT NULL,
    value jsonb,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.xcom OWNER TO postgres;

--
-- Name: ab_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_group ALTER COLUMN id SET DEFAULT nextval('public.ab_group_id_seq'::regclass);


--
-- Name: ab_group_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_group_role ALTER COLUMN id SET DEFAULT nextval('public.ab_group_role_id_seq'::regclass);


--
-- Name: ab_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_permission ALTER COLUMN id SET DEFAULT nextval('public.ab_permission_id_seq'::regclass);


--
-- Name: ab_permission_view id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_permission_view ALTER COLUMN id SET DEFAULT nextval('public.ab_permission_view_id_seq'::regclass);


--
-- Name: ab_permission_view_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_permission_view_role ALTER COLUMN id SET DEFAULT nextval('public.ab_permission_view_role_id_seq'::regclass);


--
-- Name: ab_register_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_register_user ALTER COLUMN id SET DEFAULT nextval('public.ab_register_user_id_seq'::regclass);


--
-- Name: ab_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_role ALTER COLUMN id SET DEFAULT nextval('public.ab_role_id_seq'::regclass);


--
-- Name: ab_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user ALTER COLUMN id SET DEFAULT nextval('public.ab_user_id_seq'::regclass);


--
-- Name: ab_user_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user_group ALTER COLUMN id SET DEFAULT nextval('public.ab_user_group_id_seq'::regclass);


--
-- Name: ab_user_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user_role ALTER COLUMN id SET DEFAULT nextval('public.ab_user_role_id_seq'::regclass);


--
-- Name: ab_view_menu id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_view_menu ALTER COLUMN id SET DEFAULT nextval('public.ab_view_menu_id_seq'::regclass);


--
-- Name: asset id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset ALTER COLUMN id SET DEFAULT nextval('public.asset_id_seq'::regclass);


--
-- Name: asset_alias id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_alias ALTER COLUMN id SET DEFAULT nextval('public.asset_alias_id_seq'::regclass);


--
-- Name: asset_event id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_event ALTER COLUMN id SET DEFAULT nextval('public.asset_event_id_seq'::regclass);


--
-- Name: backfill id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backfill ALTER COLUMN id SET DEFAULT nextval('public.backfill_id_seq'::regclass);


--
-- Name: backfill_dag_run id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backfill_dag_run ALTER COLUMN id SET DEFAULT nextval('public.backfill_dag_run_id_seq'::regclass);


--
-- Name: callback_request id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.callback_request ALTER COLUMN id SET DEFAULT nextval('public.callback_request_id_seq'::regclass);


--
-- Name: connection id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.connection ALTER COLUMN id SET DEFAULT nextval('public.connection_id_seq'::regclass);


--
-- Name: dag_run id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_run ALTER COLUMN id SET DEFAULT nextval('public.dag_run_id_seq'::regclass);


--
-- Name: import_error id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.import_error ALTER COLUMN id SET DEFAULT nextval('public.import_error_id_seq'::regclass);


--
-- Name: job id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job ALTER COLUMN id SET DEFAULT nextval('public.job_id_seq'::regclass);


--
-- Name: log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log ALTER COLUMN id SET DEFAULT nextval('public.log_id_seq'::regclass);


--
-- Name: log_template id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_template ALTER COLUMN id SET DEFAULT nextval('public.log_template_id_seq'::regclass);


--
-- Name: session id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session ALTER COLUMN id SET DEFAULT nextval('public.session_id_seq'::regclass);


--
-- Name: slot_pool id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.slot_pool ALTER COLUMN id SET DEFAULT nextval('public.slot_pool_id_seq'::regclass);


--
-- Name: task_reschedule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_reschedule ALTER COLUMN id SET DEFAULT nextval('public.task_reschedule_id_seq'::regclass);


--
-- Name: trigger id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trigger ALTER COLUMN id SET DEFAULT nextval('public.trigger_id_seq'::regclass);


--
-- Name: variable id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variable ALTER COLUMN id SET DEFAULT nextval('public.variable_id_seq'::regclass);


--
-- Data for Name: ab_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ab_group (id, name, label, description) FROM stdin;
\.


--
-- Data for Name: ab_group_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ab_group_role (id, group_id, role_id) FROM stdin;
\.


--
-- Data for Name: ab_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ab_permission (id, name) FROM stdin;
1	can_edit
2	can_delete
3	can_read
4	menu_access
5	can_create
\.


--
-- Data for Name: ab_permission_view; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ab_permission_view (id, permission_id, view_menu_id) FROM stdin;
1	1	1
2	2	1
3	3	1
4	3	2
5	3	3
6	3	4
7	3	5
8	3	6
9	3	7
10	3	8
11	3	9
12	3	10
13	3	11
14	3	12
15	3	13
16	3	14
17	1	14
18	3	15
19	1	15
20	3	16
21	3	17
22	3	18
23	3	19
24	3	20
25	3	21
26	4	22
27	4	1
28	4	2
29	4	4
30	4	7
31	4	10
32	4	23
33	4	24
34	4	13
35	4	16
36	4	17
37	5	17
38	1	17
39	2	17
40	5	4
41	1	4
42	2	4
43	1	20
44	5	7
45	4	25
46	4	26
47	4	27
48	4	11
49	4	28
50	4	29
51	4	30
52	4	19
53	4	20
54	3	26
55	5	27
56	3	27
57	1	27
58	2	27
59	5	11
60	1	11
61	2	11
62	3	28
63	3	30
64	5	29
65	3	29
66	1	29
67	2	29
68	2	19
69	2	7
70	5	9
71	1	9
72	2	9
73	3	31
74	4	31
75	3	32
76	4	32
77	3	33
78	4	33
79	3	34
80	1	34
81	3	35
82	1	35
83	5	40
84	3	40
85	1	40
86	2	40
87	4	41
88	4	42
89	5	35
90	2	35
91	4	43
92	3	44
93	4	45
94	3	46
95	4	47
96	3	48
97	4	49
98	3	50
99	4	51
100	2	52
101	3	52
102	1	52
103	2	53
104	3	53
105	4	53
106	5	53
107	3	54
108	1	54
109	2	54
110	3	55
111	4	55
112	5	55
113	2	55
\.


--
-- Data for Name: ab_permission_view_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ab_permission_view_role (id, permission_view_id, role_id) FROM stdin;
1	3	3
2	4	3
3	5	3
4	6	3
5	7	3
6	8	3
7	9	3
8	10	3
9	11	3
10	12	3
11	13	3
12	14	3
13	15	3
14	16	3
15	17	3
16	18	3
17	19	3
18	20	3
19	21	3
20	22	3
21	23	3
22	24	3
23	25	3
24	26	3
25	27	3
26	28	3
27	29	3
28	30	3
29	31	3
30	32	3
31	33	3
32	34	3
33	35	3
34	36	3
35	3	4
36	4	4
37	5	4
38	6	4
39	7	4
40	8	4
41	9	4
42	10	4
43	11	4
44	12	4
45	13	4
46	14	4
47	15	4
48	16	4
49	17	4
50	18	4
51	19	4
52	20	4
53	21	4
54	22	4
55	23	4
56	24	4
57	25	4
58	26	4
59	27	4
60	28	4
61	29	4
62	30	4
63	31	4
64	32	4
65	33	4
66	34	4
67	35	4
68	36	4
69	1	4
70	2	4
71	37	4
72	38	4
73	39	4
74	40	4
75	41	4
76	42	4
77	43	4
78	44	4
79	3	5
80	4	5
81	5	5
82	6	5
83	7	5
84	8	5
85	9	5
86	10	5
87	11	5
88	12	5
89	13	5
90	14	5
91	15	5
92	16	5
93	17	5
94	18	5
95	19	5
96	20	5
97	21	5
98	22	5
99	23	5
100	24	5
101	25	5
102	26	5
103	27	5
104	28	5
105	29	5
106	30	5
107	31	5
108	32	5
109	33	5
110	34	5
111	35	5
112	36	5
113	1	5
114	2	5
115	37	5
116	38	5
117	39	5
118	40	5
119	41	5
120	42	5
121	43	5
122	44	5
123	45	5
124	46	5
125	47	5
126	48	5
127	49	5
128	50	5
129	51	5
130	52	5
131	53	5
132	54	5
133	55	5
134	56	5
135	57	5
136	58	5
137	59	5
138	60	5
139	61	5
140	62	5
141	63	5
142	64	5
143	65	5
144	66	5
145	67	5
146	68	5
147	69	5
148	70	5
149	71	5
150	72	5
151	3	1
152	4	1
153	5	1
154	6	1
155	7	1
156	8	1
157	9	1
158	10	1
159	11	1
160	12	1
161	13	1
162	14	1
163	15	1
164	16	1
165	17	1
166	18	1
167	19	1
168	20	1
169	21	1
170	22	1
171	23	1
172	24	1
173	25	1
174	26	1
175	27	1
176	28	1
177	29	1
178	30	1
179	31	1
180	32	1
181	33	1
182	34	1
183	35	1
184	36	1
185	1	1
186	2	1
187	37	1
188	38	1
189	39	1
190	40	1
191	41	1
192	42	1
193	43	1
194	44	1
195	45	1
196	46	1
197	47	1
198	48	1
199	49	1
200	50	1
201	51	1
202	52	1
203	53	1
204	54	1
205	55	1
206	56	1
207	57	1
208	58	1
209	59	1
210	60	1
211	61	1
212	62	1
213	63	1
214	64	1
215	65	1
216	66	1
217	67	1
218	68	1
219	69	1
220	70	1
221	71	1
222	72	1
223	73	1
224	74	1
225	75	1
226	76	1
227	77	1
228	78	1
229	79	1
230	80	1
231	81	1
232	82	1
233	83	1
234	84	1
235	85	1
236	86	1
237	87	1
238	88	1
239	89	1
240	90	1
241	91	1
242	92	1
243	93	1
244	94	1
245	95	1
246	96	1
247	97	1
248	98	1
249	99	1
\.


--
-- Data for Name: ab_register_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ab_register_user (id, first_name, last_name, username, password, email, registration_date, registration_hash) FROM stdin;
\.


--
-- Data for Name: ab_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ab_role (id, name) FROM stdin;
1	Admin
2	Public
3	Viewer
4	User
5	Op
\.


--
-- Data for Name: ab_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ab_user (id, first_name, last_name, username, password, active, email, last_login, login_count, fail_login_count, created_on, changed_on, created_by_fk, changed_by_fk) FROM stdin;
1	Admin	User	admin	pbkdf2:sha256:260000$DBWKRfZ4Y5yAGRoo$bc8f505391ae826b929a48d21567ee629151c1b66131a478b64a530a8f0e6a73	t	admin@example.com	2025-09-26 08:50:43.292705	1	0	2025-09-26 08:38:52.886727	2025-09-26 08:38:52.886735	\N	\N
\.


--
-- Data for Name: ab_user_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ab_user_group (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: ab_user_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ab_user_role (id, user_id, role_id) FROM stdin;
1	1	1
\.


--
-- Data for Name: ab_view_menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ab_view_menu (id, name) FROM stdin;
1	DAGs
2	DAG Dependencies
3	DAG Code
4	DAG Runs
5	DAG Versions
6	DAG Warnings
7	Assets
8	Asset Aliases
9	Backfills
10	Cluster Activity
11	Pools
12	ImportError
13	Jobs
14	My Password
15	My Profile
16	SLA Misses
17	Task Instances
18	Task Logs
19	XComs
20	HITL Detail
21	Website
22	Browse
23	Documentation
24	Docs
25	Admin
26	Configurations
27	Connections
28	Plugins
29	Variables
30	Providers
31	Audit Logs
32	Task Reschedules
33	Triggers
34	Passwords
35	Roles
36	FabIndexView
37	UtilView
38	SecurityApi
39	AuthDBView
40	Users
41	List Users
42	Security
43	List Roles
44	User Stats Chart
45	User's Statistics
46	Permissions
47	Actions
48	View Menus
49	Resources
50	Permission Views
51	Permission Pairs
52	DAG:working_test
53	DAG Run:working_test
54	DAG:dotodo_daily_analytics
55	DAG Run:dotodo_daily_analytics
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
fe199e1abd77
\.


--
-- Data for Name: alembic_version_fab; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version_fab (version_num) FROM stdin;
6709f7a774b9
\.


--
-- Data for Name: asset; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asset (id, name, uri, "group", extra, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: asset_active; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asset_active (name, uri) FROM stdin;
\.


--
-- Data for Name: asset_alias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asset_alias (id, name, "group") FROM stdin;
\.


--
-- Data for Name: asset_alias_asset; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asset_alias_asset (alias_id, asset_id) FROM stdin;
\.


--
-- Data for Name: asset_alias_asset_event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asset_alias_asset_event (alias_id, event_id) FROM stdin;
\.


--
-- Data for Name: asset_dag_run_queue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asset_dag_run_queue (asset_id, target_dag_id, created_at) FROM stdin;
\.


--
-- Data for Name: asset_event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asset_event (id, asset_id, extra, source_task_id, source_dag_id, source_run_id, source_map_index, "timestamp") FROM stdin;
\.


--
-- Data for Name: asset_trigger; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asset_trigger (asset_id, trigger_id) FROM stdin;
\.


--
-- Data for Name: backfill; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backfill (id, dag_id, from_date, to_date, dag_run_conf, is_paused, reprocess_behavior, max_active_runs, created_at, completed_at, updated_at) FROM stdin;
\.


--
-- Data for Name: backfill_dag_run; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backfill_dag_run (id, backfill_id, dag_run_id, exception_reason, logical_date, sort_ordinal) FROM stdin;
\.


--
-- Data for Name: callback_request; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.callback_request (id, created_at, priority_weight, callback_data, callback_type) FROM stdin;
\.


--
-- Data for Name: connection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.connection (id, conn_id, conn_type, description, host, schema, login, password, port, is_encrypted, is_extra_encrypted, extra) FROM stdin;
1	postgres_default	postgres	\N	db	dotodo	postgres	gAAAAABo2OQbXwu888ANo9C2csUbeW9UoeCidtS5VgJBeN6kTOyofVmdD5oFdz41jQdZ3re2g9s3LAaP6OlGpLyfqsN_CHVMGQ==	5432	t	f	\N
\.


--
-- Data for Name: dag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dag (dag_id, is_paused, is_stale, last_parsed_time, last_expired, fileloc, relative_fileloc, bundle_name, bundle_version, owners, dag_display_name, description, timetable_summary, timetable_description, asset_expression, max_active_tasks, max_active_runs, max_consecutive_failed_dag_runs, has_task_concurrency_limits, has_import_errors, next_dagrun, next_dagrun_data_interval_start, next_dagrun_data_interval_end, next_dagrun_create_after) FROM stdin;
working_test	t	f	2025-09-28 11:45:56.420743+00	\N	/opt/airflow/dags/working_test.py	working_test.py	dags-folder	\N	airflow	\N	\N	None	Never, external triggers only	null	16	16	0	f	f	\N	\N	\N	\N
dotodo_daily_analytics	t	f	2025-09-28 11:45:56.937319+00	\N	/opt/airflow/dags/dotodo_analytics.py	dotodo_analytics.py	dags-folder	\N	dotodo-team	\N	DoTodo 일일 데이터 분석 파이프라인	0 1 * * *	At 01:00	null	16	1	0	f	f	2025-09-28 01:00:00+00	2025-09-28 01:00:00+00	2025-09-28 01:00:00+00	\N
\.


--
-- Data for Name: dag_bundle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dag_bundle (name, active, version, last_refreshed) FROM stdin;
dags-folder	t	\N	2025-09-28 11:45:50.276928+00
\.


--
-- Data for Name: dag_code; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dag_code (id, dag_id, fileloc, created_at, last_updated, source_code, source_code_hash, dag_version_id) FROM stdin;
01998f1e-b033-71b5-8bb2-c91729c62ee3	working_test	/opt/airflow/dags/working_test.py	2025-09-28 06:59:37.139853+00	2025-09-28 06:59:37.139859+00	from datetime import datetime\nfrom airflow import DAG\nfrom airflow.operators.bash import BashOperator\n\ndag = DAG(\n    'working_test',\n    start_date=datetime(2025, 9, 26),\n    schedule=None,\n    catchup=False,\n    tags=['test']\n)\n\ntest_task = BashOperator(\n    task_id='hello_world',\n    bash_command='echo "Airflow 3.0 Working!"',\n    dag=dag\n)\n	650548d7f770e0d3a092c2e56d43f194	01998f1e-b032-7971-9b48-e30ccac657ca
01998f37-be09-784c-a89e-c4ddf94f73a1	dotodo_daily_analytics	/opt/airflow/dags/dotodo_analytics.py	2025-09-28 07:26:59.081308+00	2025-09-28 07:26:59.081313+00	from datetime import datetime, timedelta\nfrom airflow import DAG\nfrom airflow.operators.python import PythonOperator\nfrom airflow.providers.postgres.hooks.postgres import PostgresHook\nimport pandas as pd\nimport json\nfrom typing import Dict, Any\n\n\ndef create_analytics_table_func(**context):\n    """분석용 테이블 생성"""\n    postgres_hook = PostgresHook(postgres_conn_id='postgres_default')\n    \n    sql = """\n    CREATE TABLE IF NOT EXISTS daily_analytics (\n        id SERIAL PRIMARY KEY,\n        analysis_date DATE NOT NULL UNIQUE,\n        total_users INTEGER,\n        avg_completion_rate NUMERIC(5,2),\n        most_popular_category VARCHAR(100),\n        active_users_last_week INTEGER,\n        report_data JSONB,\n        created_at TIMESTAMP DEFAULT NOW()\n    );\n    \n    CREATE INDEX IF NOT EXISTS idx_daily_analytics_date \n    ON daily_analytics(analysis_date);\n    """\n    \n    postgres_hook.run(sql)\n    print("Analytics table created successfully")\n\n\ndef extract_user_activity_data(**context):\n    """사용자 활동 데이터 추출"""\n    postgres_hook = PostgresHook(postgres_conn_id='postgres_default')\n    \n    # 어제 날짜 기준으로 데이터 추출\n    yesterday = context['ds']\n    \n    # 전체 사용자 활동 통계\n    query = """\n    SELECT \n        user_id,\n        COUNT(*) as total_todos,\n        COUNT(CASE WHEN completed = true THEN 1 END) as completed_todos,\n        COUNT(CASE WHEN completed = false THEN 1 END) as pending_todos,\n        COUNT(DISTINCT category) as unique_categories,\n        MIN(created_at) as first_activity,\n        MAX(updated_at) as last_activity\n    FROM todos \n    WHERE DATE(created_at) <= %s\n    GROUP BY user_id\n    """\n    \n    df = postgres_hook.get_pandas_df(query, parameters=[yesterday])\n    \n    # 결과를 XCom에 저장\n    return df.to_json(orient='records')\n\n\ndef calculate_completion_rates(**context):\n    """완료율 계산 및 분석"""\n    # 이전 태스크에서 데이터 가져오기\n    ti = context['task_instance']\n    user_data_json = ti.xcom_pull(task_ids='extract_user_activity')\n    \n    if not user_data_json or user_data_json == '[]':\n        print("No user data found")\n        return {\n            'total_users': 0,\n            'avg_completion_rate': 0,\n            'median_completion_rate': 0,\n            'high_performers': 0,\n            'low_performers': 0\n        }\n    \n    user_data = pd.read_json(user_data_json)\n    \n    # 완료율 계산\n    user_data['completion_rate'] = (\n        user_data['completed_todos'] / user_data['total_todos'] * 100\n    ).fillna(0)\n    \n    # 전체 통계\n    analytics = {\n        'total_users': len(user_data),\n        'avg_completion_rate': user_data['completion_rate'].mean(),\n        'median_completion_rate': user_data['completion_rate'].median(),\n        'high_performers': len(user_data[user_data['completion_rate'] >= 80]),\n        'low_performers': len(user_data[user_data['completion_rate'] < 30])\n    }\n    \n    print(f"Analytics Summary: {analytics}")\n    return analytics\n\n\ndef analyze_category_trends(**context):\n    """카테고리별 트렌드 분석"""\n    postgres_hook = PostgresHook(postgres_conn_id='postgres_default')\n    yesterday = context['ds']\n    \n    # 카테고리별 통계\n    query = """\n    SELECT \n        category,\n        COUNT(*) as total_tasks,\n        COUNT(CASE WHEN completed = true THEN 1 END) as completed_tasks,\n        ROUND(\n            COUNT(CASE WHEN completed = true THEN 1 END)::numeric / \n            COUNT(*)::numeric * 100, 2\n        ) as completion_rate,\n        COUNT(DISTINCT user_id) as unique_users\n    FROM todos \n    WHERE DATE(created_at) <= %s \n        AND category IS NOT NULL\n    GROUP BY category\n    ORDER BY total_tasks DESC\n    """\n    \n    df = postgres_hook.get_pandas_df(query, parameters=[yesterday])\n    \n    # 인사이트 생성\n    if len(df) > 0:\n        insights = {\n            'most_popular_category': df.iloc[0]['category'],\n            'highest_completion_category': df.loc[df['completion_rate'].idxmax()]['category'],\n            'categories_analysis': df.to_dict('records')\n        }\n    else:\n        insights = {\n            'most_popular_category': 'unknown',\n            'highest_completion_category': 'unknown',\n            'categories_analysis': []\n        }\n    \n    return insights\n\n\ndef detect_user_patterns(**context):\n    """사용자 패턴 및 이상치 감지"""\n    postgres_hook = PostgresHook(postgres_conn_id='postgres_default')\n    yesterday = context['ds']\n    \n    # 일주일간 활동 패턴 분석\n    query = """\n    WITH daily_activity AS (\n        SELECT \n            user_id,\n            DATE(created_at) as activity_date,\n            COUNT(*) as daily_todos,\n            COUNT(CASE WHEN completed = true THEN 1 END) as daily_completed\n        FROM todos \n        WHERE created_at >= %s::date - INTERVAL '7 days'\n            AND created_at <= %s::date\n        GROUP BY user_id, DATE(created_at)\n    )\n    SELECT \n        user_id,\n        COUNT(*) as active_days,\n        AVG(daily_todos) as avg_daily_todos,\n        AVG(daily_completed) as avg_daily_completed,\n        MAX(daily_todos) as max_daily_todos,\n        STDDEV(daily_todos) as stddev_daily_todos\n    FROM daily_activity\n    GROUP BY user_id\n    HAVING COUNT(*) >= 3  -- 최소 3일 이상 활동한 사용자만\n    """\n    \n    df = postgres_hook.get_pandas_df(query, parameters=[yesterday, yesterday])\n    \n    # 이상치 감지 (평균보다 3 표준편차 이상 차이나는 사용자)\n    if len(df) > 0:\n        mean_todos = df['avg_daily_todos'].mean()\n        std_todos = df['avg_daily_todos'].std()\n        \n        if std_todos > 0:\n            outliers = df[\n                (df['avg_daily_todos'] > mean_todos + 3 * std_todos) |\n                (df['avg_daily_todos'] < mean_todos - 3 * std_todos)\n            ]\n        else:\n            outliers = pd.DataFrame()\n        \n        patterns = {\n            'total_active_users': len(df),\n            'avg_activity_days': df['active_days'].mean(),\n            'super_users': len(df[df['avg_daily_todos'] > 10]),\n            'potential_outliers': len(outliers),\n            'outlier_users': outliers['user_id'].tolist() if len(outliers) > 0 else []\n        }\n    else:\n        patterns = {\n            'total_active_users': 0,\n            'avg_activity_days': 0,\n            'super_users': 0,\n            'potential_outliers': 0,\n            'outlier_users': [],\n            'message': 'Insufficient data for pattern analysis'\n        }\n    \n    return patterns\n\n\ndef generate_daily_summary(**context):\n    """일일 요약 리포트 생성"""\n    ti = context['task_instance']\n    \n    # 이전 태스크들의 결과 수집\n    completion_stats = ti.xcom_pull(task_ids='calculate_completion_rates')\n    category_insights = ti.xcom_pull(task_ids='analyze_category_trends')\n    user_patterns = ti.xcom_pull(task_ids='detect_user_patterns')\n    \n    # 종합 리포트 생성\n    daily_report = {\n        'date': context['ds'],\n        'summary': {\n            'total_users': completion_stats.get('total_users', 0),\n            'avg_completion_rate': round(completion_stats.get('avg_completion_rate', 0), 2),\n            'most_popular_category': category_insights.get('most_popular_category'),\n            'active_users_last_week': user_patterns.get('total_active_users', 0)\n        },\n        'completion_analysis': completion_stats,\n        'category_trends': category_insights,\n        'user_behavior': user_patterns,\n        'recommendations': generate_recommendations(completion_stats, category_insights, user_patterns)\n    }\n    \n    # 결과를 로그에 출력\n    print("=" * 60)\n    print(f"DoTodo Daily Analytics Report - {context['ds']}")\n    print("=" * 60)\n    print(json.dumps(daily_report['summary'], indent=2))\n    print("\\nRecommendations:")\n    for rec in daily_report['recommendations']:\n        print(f"- {rec}")\n    print("=" * 60)\n    \n    return daily_report\n\n\ndef generate_recommendations(completion_stats, category_insights, user_patterns):\n    """비즈니스 추천사항 생성"""\n    recommendations = []\n    \n    # 완료율 기반 추천\n    avg_completion = completion_stats.get('avg_completion_rate', 0)\n    if avg_completion < 50:\n        recommendations.append("전체 완료율이 낮습니다. 사용자 경험 개선이 필요합니다.")\n    elif avg_completion > 80:\n        recommendations.append("높은 완료율을 보이고 있습니다. 현재 전략을 유지하세요.")\n    \n    # 카테고리 기반 추천\n    if category_insights.get('most_popular_category') and category_insights.get('most_popular_category') != 'unknown':\n        recommendations.append(\n            f"'{category_insights['most_popular_category']}' 카테고리가 가장 인기입니다. "\n            "관련 기능 강화를 고려하세요."\n        )\n    \n    # 사용자 활동 기반 추천\n    super_users = user_patterns.get('super_users', 0)\n    total_users = user_patterns.get('total_active_users', 1)\n    if total_users > 0 and super_users / total_users > 0.1:  # 10% 이상이 파워유저\n        recommendations.append("파워유저 비율이 높습니다. 고급 기능 개발을 고려하세요.")\n    \n    if not recommendations:\n        recommendations.append("모든 지표가 정상 범위입니다.")\n    \n    return recommendations\n\n\ndef save_analytics_results(**context):\n    """분석 결과를 데이터베이스에 저장"""\n    ti = context['task_instance']\n    postgres_hook = PostgresHook(postgres_conn_id='postgres_default')\n    \n    completion_stats = ti.xcom_pull(task_ids='calculate_completion_rates')\n    category_insights = ti.xcom_pull(task_ids='analyze_category_trends')\n    user_patterns = ti.xcom_pull(task_ids='detect_user_patterns')\n    daily_report = ti.xcom_pull(task_ids='generate_daily_summary')\n    \n    sql = """\n    INSERT INTO daily_analytics (\n        analysis_date, total_users, avg_completion_rate, \n        most_popular_category, active_users_last_week, report_data\n    ) VALUES (%s, %s, %s, %s, %s, %s)\n    ON CONFLICT (analysis_date) DO UPDATE SET\n        total_users = EXCLUDED.total_users,\n        avg_completion_rate = EXCLUDED.avg_completion_rate,\n        most_popular_category = EXCLUDED.most_popular_category,\n        active_users_last_week = EXCLUDED.active_users_last_week,\n        report_data = EXCLUDED.report_data,\n        created_at = NOW();\n    """\n    \n    postgres_hook.run(sql, parameters=[\n        context['ds'],\n        completion_stats.get('total_users', 0),\n        completion_stats.get('avg_completion_rate', 0),\n        category_insights.get('most_popular_category', 'unknown'),\n        user_patterns.get('total_active_users', 0),\n        json.dumps(daily_report)\n    ])\n    \n    print(f"Analytics results saved for {context['ds']}")\n\n\n# DAG 정의\ndefault_args = {\n    'owner': 'dotodo-team',\n    'depends_on_past': False,\n    'start_date': datetime(2025, 9, 26),\n    'email_on_failure': False,\n    'email_on_retry': False,\n    'retries': 1,\n    'retry_delay': timedelta(minutes=5),\n}\n\ndag = DAG(\n    'dotodo_daily_analytics',\n    default_args=default_args,\n    description='DoTodo 일일 데이터 분석 파이프라인',\n    schedule='0 1 * * *',  # 매일 새벽 1시 실행\n    catchup=False,\n    max_active_runs=1,\n    tags=['analytics', 'daily', 'dotodo']\n)\n\n# 집계 테이블 생성\ncreate_analytics_table = PythonOperator(\n    task_id='create_analytics_table',\n    python_callable=create_analytics_table_func,\n    dag=dag\n)\n\n# 데이터 추출\nextract_data = PythonOperator(\n    task_id='extract_user_activity',\n    python_callable=extract_user_activity_data,\n    dag=dag\n)\n\n# 완료율 분석\nanalyze_completion = PythonOperator(\n    task_id='calculate_completion_rates',\n    python_callable=calculate_completion_rates,\n    dag=dag\n)\n\n# 카테고리 트렌드 분석\nanalyze_categories = PythonOperator(\n    task_id='analyze_category_trends',\n    python_callable=analyze_category_trends,\n    dag=dag\n)\n\n# 사용자 패턴 분석\nanalyze_patterns = PythonOperator(\n    task_id='detect_user_patterns',\n    python_callable=detect_user_patterns,\n    dag=dag\n)\n\n# 일일 요약 생성\ngenerate_summary = PythonOperator(\n    task_id='generate_daily_summary',\n    python_callable=generate_daily_summary,\n    dag=dag\n)\n\n# 결과를 데이터베이스에 저장\nsave_analytics = PythonOperator(\n    task_id='save_analytics_results',\n    python_callable=save_analytics_results,\n    dag=dag\n)\n\n# 태스크 의존성 설정\ncreate_analytics_table >> extract_data\nextract_data >> [analyze_completion, analyze_categories, analyze_patterns]\n[analyze_completion, analyze_categories, analyze_patterns] >> generate_summary\ngenerate_summary >> save_analytics\n	f91cd390f757df08e48a6b39c1bb0bb5	01998f37-be07-7d26-98db-6cc791837d3f
\.


--
-- Data for Name: dag_owner_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dag_owner_attributes (dag_id, owner, link) FROM stdin;
\.


--
-- Data for Name: dag_priority_parsing_request; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dag_priority_parsing_request (id, bundle_name, relative_fileloc) FROM stdin;
\.


--
-- Data for Name: dag_run; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dag_run (id, dag_id, queued_at, logical_date, start_date, end_date, state, run_id, creating_job_id, run_type, triggered_by, conf, data_interval_start, data_interval_end, run_after, last_scheduling_decision, log_template_id, updated_at, clear_number, backfill_id, bundle_version, scheduled_by_job_id, context_carrier, span_status, created_dag_version_id) FROM stdin;
3	working_test	\N	2025-09-28 06:59:50.61566+00	2025-09-28 06:59:50.61566+00	2025-09-28 06:59:53.092546+00	success	manual__2025-09-28T06:59:50.712179+00:00	\N	manual	TEST	{}	2025-09-28 06:59:50.61566+00	2025-09-28 06:59:50.61566+00	2025-09-28 06:59:50.712179+00	2025-09-28 06:59:53.090152+00	2	2025-09-28 06:59:53.093738+00	0	\N	\N	\N	{"__var": {}, "__type": "dict"}	ended	01998f1e-b032-7971-9b48-e30ccac657ca
4	dotodo_daily_analytics	2025-09-28 07:31:50.704137+00	2025-09-28 01:00:00+00	2025-09-28 07:31:50.727985+00	\N	running	scheduled__2025-09-28T01:00:00+00:00	16	scheduled	TIMETABLE	{}	2025-09-28 01:00:00+00	2025-09-28 01:00:00+00	2025-09-28 01:00:00+00	2025-09-28 07:33:45.36977+00	2	2025-09-28 07:33:45.37354+00	0	\N	\N	16	{"__var": {}, "__type": "dict"}	active	01998f37-be07-7d26-98db-6cc791837d3f
5	dotodo_daily_analytics	2025-09-28 07:32:14.169338+00	2025-09-28 07:32:10.189+00	\N	\N	queued	manual__2025-09-28T07:32:14.161483+00:00	\N	manual	REST_API	{}	2025-09-28 07:32:10.189+00	2025-09-28 07:32:10.189+00	2025-09-28 07:32:10.189+00	\N	2	2025-09-28 07:32:14.17254+00	0	\N	\N	\N	{"__var": {}, "__type": "dict"}	not_started	01998f37-be07-7d26-98db-6cc791837d3f
\.


--
-- Data for Name: dag_run_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dag_run_note (user_id, dag_run_id, content, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: dag_schedule_asset_alias_reference; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dag_schedule_asset_alias_reference (alias_id, dag_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: dag_schedule_asset_name_reference; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dag_schedule_asset_name_reference (name, dag_id, created_at) FROM stdin;
\.


--
-- Data for Name: dag_schedule_asset_reference; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dag_schedule_asset_reference (asset_id, dag_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: dag_schedule_asset_uri_reference; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dag_schedule_asset_uri_reference (uri, dag_id, created_at) FROM stdin;
\.


--
-- Data for Name: dag_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dag_tag (name, dag_id) FROM stdin;
test	working_test
daily	dotodo_daily_analytics
analytics	dotodo_daily_analytics
dotodo	dotodo_daily_analytics
\.


--
-- Data for Name: dag_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dag_version (id, version_number, dag_id, bundle_name, bundle_version, created_at, last_updated) FROM stdin;
01998f1e-b032-7971-9b48-e30ccac657ca	1	working_test	dags-folder	\N	2025-09-28 06:59:37.138849+00	2025-09-28 06:59:37.138854+00
01998f37-be07-7d26-98db-6cc791837d3f	1	dotodo_daily_analytics	dags-folder	\N	2025-09-28 07:26:59.079495+00	2025-09-28 07:26:59.0795+00
\.


--
-- Data for Name: dag_warning; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dag_warning (dag_id, warning_type, message, "timestamp") FROM stdin;
\.


--
-- Data for Name: dagrun_asset_event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dagrun_asset_event (dag_run_id, event_id) FROM stdin;
\.


--
-- Data for Name: deadline; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deadline (id, dag_id, dagrun_id, deadline, callback, callback_kwargs) FROM stdin;
\.


--
-- Data for Name: import_error; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.import_error (id, "timestamp", filename, bundle_name, stacktrace) FROM stdin;
\.


--
-- Data for Name: job; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job (id, dag_id, state, job_type, start_date, end_date, latest_heartbeat, executor_class, hostname, unixname) FROM stdin;
2	\N	success	SchedulerJob	2025-09-26 08:39:21.455909+00	2025-09-26 08:39:27.219907+00	2025-09-26 08:39:26.702738+00	\N	8845431419ef	airflow
1	\N	success	DagProcessorJob	2025-09-26 08:39:16.11574+00	2025-09-26 08:39:27.37652+00	2025-09-26 08:39:25.725254+00	\N	ee09243422c0	airflow
4	\N	success	SchedulerJob	2025-09-26 08:40:26.254562+00	2025-09-26 08:40:42.866213+00	2025-09-26 08:40:41.402937+00	\N	5e33cb42048a	airflow
3	\N	success	DagProcessorJob	2025-09-26 08:40:20.49055+00	2025-09-26 08:40:43.026714+00	2025-09-26 08:40:39.84392+00	\N	839272d311c4	airflow
7	\N	success	DagProcessorJob	2025-09-26 08:48:55.654892+00	2025-09-28 06:52:04.562938+00	2025-09-28 06:52:03.178806+00	\N	1ab2ebdc9462	airflow
8	\N	failed	SchedulerJob	2025-09-26 08:49:00.488532+00	\N	2025-09-28 06:51:55.160616+00	\N	dbdeba4a27d0	airflow
10	\N	success	SchedulerJob	2025-09-28 06:53:20.710401+00	2025-09-28 06:56:06.076115+00	2025-09-28 06:56:05.981993+00	\N	38a0158cb364	airflow
9	\N	success	DagProcessorJob	2025-09-28 06:53:17.197896+00	2025-09-28 06:56:06.209031+00	2025-09-28 06:56:02.697121+00	\N	ea11e72023a2	airflow
15	\N	success	DagProcessorJob	2025-09-28 07:17:42.977718+00	2025-09-28 07:35:48.464889+00	2025-09-28 07:35:47.316977+00	\N	f26459aedac5	airflow
16	\N	failed	SchedulerJob	2025-09-28 07:17:45.014474+00	\N	2025-09-28 07:35:42.195942+00	\N	3f8fbbc0fc9a	airflow
14	\N	success	SchedulerJob	2025-09-28 07:15:11.9393+00	2025-09-28 07:17:35.467568+00	2025-09-28 07:17:32.276985+00	\N	3f8fbbc0fc9a	airflow
13	\N	success	DagProcessorJob	2025-09-28 07:15:05.588595+00	2025-09-28 07:17:35.568102+00	2025-09-28 07:17:30.811486+00	\N	f26459aedac5	airflow
12	\N	success	SchedulerJob	2025-09-28 06:58:09.355058+00	2025-09-28 07:14:04.766944+00	2025-09-28 07:14:04.305519+00	\N	5e7a4963df15	airflow
11	\N	success	DagProcessorJob	2025-09-28 06:58:02.728667+00	2025-09-28 07:14:04.882242+00	2025-09-28 07:14:04.590032+00	\N	6c405aa1d5dc	airflow
6	\N	success	SchedulerJob	2025-09-26 08:41:42.547564+00	2025-09-26 08:43:44.561598+00	2025-09-26 08:43:40.990081+00	\N	610f7e4ed91a	airflow
5	\N	success	DagProcessorJob	2025-09-26 08:41:37.032904+00	2025-09-26 08:43:44.693523+00	2025-09-26 08:43:42.47487+00	\N	6baba1d87e6a	airflow
18	\N	success	SchedulerJob	2025-09-28 07:38:28.668846+00	2025-09-28 11:46:10.710846+00	2025-09-28 11:46:07.892543+00	\N	22f56049b7d8	airflow
17	\N	success	DagProcessorJob	2025-09-28 07:38:23.863975+00	2025-09-28 11:46:10.878485+00	2025-09-28 11:46:05.978089+00	\N	7670bfc71c7c	airflow
\.


--
-- Data for Name: log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.log (id, dttm, dag_id, task_id, map_index, event, logical_date, run_id, owner, owner_display_name, extra, try_number) FROM stdin;
1	2025-09-26 08:38:50.404419+00	\N	\N	\N	cli_users_create	\N	\N	airflow	\N	{"host_name": "3ff7e588eabe", "full_command": "['/home/airflow/.local/bin/airflow', 'users', 'create', '-u', 'admin', '-f', 'Admin', '-l', 'User', '-r', 'Admin', '-e', 'admin@example.com', '-p', '********']"}	\N
2	2025-09-26 08:39:04.012659+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "ee09243422c0", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
3	2025-09-26 08:39:04.075473+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "c1adbd50350d", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
4	2025-09-26 08:39:04.205089+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "8845431419ef", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
5	2025-09-26 08:39:14.668958+00	\N	\N	\N	cli_dag_processor	\N	\N	airflow	\N	{"host_name": "ee09243422c0", "full_command": "['/home/airflow/.local/bin/airflow', 'dag-processor']"}	\N
6	2025-09-26 08:39:20.406262+00	\N	\N	\N	cli_scheduler	\N	\N	airflow	\N	{"host_name": "8845431419ef", "full_command": "['/home/airflow/.local/bin/airflow', 'scheduler']"}	\N
7	2025-09-26 08:39:20.782679+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "c1adbd50350d", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
8	2025-09-26 08:39:49.384293+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "a570a94a7d3a", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
9	2025-09-26 08:39:51.949796+00	\N	\N	\N	cli_migratedb	\N	\N	airflow	\N	{"host_name": "a570a94a7d3a", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'migrate']"}	\N
10	2025-09-26 08:39:54.547849+00	\N	\N	\N	cli_users_create	\N	\N	airflow	\N	{"host_name": "a570a94a7d3a", "full_command": "['/home/airflow/.local/bin/airflow', 'users', 'create', '-u', 'admin', '-f', 'Admin', '-l', 'User', '-r', 'Admin', '-e', 'admin@example.com', '-p', '********']"}	\N
11	2025-09-26 08:40:06.692729+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "f3654bd48a7b", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
12	2025-09-26 08:40:06.752162+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "5e33cb42048a", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
13	2025-09-26 08:40:06.983631+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "839272d311c4", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
14	2025-09-26 08:40:19.00804+00	\N	\N	\N	cli_dag_processor	\N	\N	airflow	\N	{"host_name": "839272d311c4", "full_command": "['/home/airflow/.local/bin/airflow', 'dag-processor']"}	\N
15	2025-09-26 08:40:24.997585+00	\N	\N	\N	cli_scheduler	\N	\N	airflow	\N	{"host_name": "5e33cb42048a", "full_command": "['/home/airflow/.local/bin/airflow', 'scheduler']"}	\N
16	2025-09-26 08:40:26.258291+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "f3654bd48a7b", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
17	2025-09-26 08:40:34.268001+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "f3654bd48a7b", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
18	2025-09-26 08:40:41.601714+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "f3654bd48a7b", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
19	2025-09-26 08:41:04.624314+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "4adc2175db90", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
20	2025-09-26 08:41:07.705308+00	\N	\N	\N	cli_migratedb	\N	\N	airflow	\N	{"host_name": "4adc2175db90", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'migrate']"}	\N
21	2025-09-26 08:41:10.919751+00	\N	\N	\N	cli_users_create	\N	\N	airflow	\N	{"host_name": "4adc2175db90", "full_command": "['/home/airflow/.local/bin/airflow', 'users', 'create', '-u', 'admin', '-f', 'Admin', '-l', 'User', '-r', 'Admin', '-e', 'admin@example.com', '-p', '********']"}	\N
22	2025-09-26 08:41:24.927264+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "0bd95c26b275", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
23	2025-09-26 08:41:25.396965+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "6baba1d87e6a", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
24	2025-09-26 08:41:25.566199+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "610f7e4ed91a", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
25	2025-09-26 08:41:35.835338+00	\N	\N	\N	cli_dag_processor	\N	\N	airflow	\N	{"host_name": "6baba1d87e6a", "full_command": "['/home/airflow/.local/bin/airflow', 'dag-processor']"}	\N
26	2025-09-26 08:41:41.409124+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "0bd95c26b275", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
27	2025-09-26 08:41:41.41357+00	\N	\N	\N	cli_scheduler	\N	\N	airflow	\N	{"host_name": "610f7e4ed91a", "full_command": "['/home/airflow/.local/bin/airflow', 'scheduler']"}	\N
28	2025-09-26 08:41:49.802597+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "0bd95c26b275", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
29	2025-09-26 08:41:57.787877+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "0bd95c26b275", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
30	2025-09-26 08:42:05.42863+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "0bd95c26b275", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
31	2025-09-26 08:42:14.334435+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "0bd95c26b275", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
32	2025-09-26 08:42:24.763724+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "0bd95c26b275", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
33	2025-09-26 08:42:38.132196+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "0bd95c26b275", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
34	2025-09-26 08:42:57.56064+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "0bd95c26b275", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
35	2025-09-26 08:43:29.685364+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "0bd95c26b275", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
36	2025-09-26 08:46:19.385351+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "c34d44a42b02", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
37	2025-09-26 08:46:21.952203+00	\N	\N	\N	cli_migratedb	\N	\N	airflow	\N	{"host_name": "c34d44a42b02", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'migrate']"}	\N
38	2025-09-26 08:46:24.663503+00	\N	\N	\N	cli_users_create	\N	\N	airflow	\N	{"host_name": "c34d44a42b02", "full_command": "['/home/airflow/.local/bin/airflow', 'users', 'create', '-u', 'admin', '-f', 'Admin', '-l', 'User', '-r', 'Admin', '-e', 'admin@example.com', '-p', '********']"}	\N
39	2025-09-26 08:46:36.07745+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "927f7b919d2a", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
40	2025-09-26 08:46:36.510831+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "fa416370de13", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
41	2025-09-26 08:46:36.645238+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "fe214c788a06", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
42	2025-09-26 08:48:24.211438+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "15bdfa66e68c", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
43	2025-09-26 08:48:26.680555+00	\N	\N	\N	cli_migratedb	\N	\N	airflow	\N	{"host_name": "15bdfa66e68c", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'migrate']"}	\N
163	2025-09-28 07:32:49.107697+00	dotodo_daily_analytics	\N	\N	patch_dag	\N	\N	admin	admin	{"is_paused": false, "method": "PATCH"}	\N
44	2025-09-26 08:48:29.301625+00	\N	\N	\N	cli_users_create	\N	\N	airflow	\N	{"host_name": "15bdfa66e68c", "full_command": "['/home/airflow/.local/bin/airflow', 'users', 'create', '-u', 'admin', '-f', 'Admin', '-l', 'User', '-r', 'Admin', '-e', 'admin@example.com', '-p', '********']"}	\N
45	2025-09-26 08:48:42.591534+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "2b2762a5a07e", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
46	2025-09-26 08:48:42.748647+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "dbdeba4a27d0", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
47	2025-09-26 08:48:43.131821+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "1ab2ebdc9462", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
48	2025-09-26 08:48:53.415074+00	\N	\N	\N	cli_api_server	\N	\N	airflow	\N	{"host_name": "2b2762a5a07e", "full_command": "['/home/airflow/.local/bin/airflow', 'api-server']"}	\N
49	2025-09-26 08:48:54.145636+00	\N	\N	\N	cli_dag_processor	\N	\N	airflow	\N	{"host_name": "1ab2ebdc9462", "full_command": "['/home/airflow/.local/bin/airflow', 'dag-processor']"}	\N
50	2025-09-26 08:48:59.102977+00	\N	\N	\N	cli_scheduler	\N	\N	airflow	\N	{"host_name": "dbdeba4a27d0", "full_command": "['/home/airflow/.local/bin/airflow', 'scheduler']"}	\N
51	2025-09-28 06:38:34.042394+00	working_test	\N	\N	patch_dag	\N	\N	admin	admin	{"is_paused": false, "method": "PATCH"}	\N
52	2025-09-28 06:38:34.042359+00	working_test	\N	\N	trigger_dag_run	\N	\N	admin	admin	{"conf": {}, "logical_date": "2025-09-28T06:38:28.675Z", "method": "POST"}	\N
53	2025-09-28 06:38:44.720859+00	working_test	hello_world	-1	state mismatch	\N	manual__2025-09-28T06:38:34.045714+00:00	\N	\N	Executor LocalExecutor(parallelism=32) reported that the task instance <TaskInstance: working_test.hello_world manual__2025-09-28T06:38:34.045714+00:00 [queued]> finished with state failed, but the task instance's state attribute is queued. Learn more: https://airflow.apache.org/docs/apache-airflow/stable/troubleshooting.html#task-state-changed-externally	1
54	2025-09-28 06:38:44.723572+00	working_test	hello_world	-1	failed	2025-09-28 06:38:28.675+00	manual__2025-09-28T06:38:34.045714+00:00	airflow	\N	\N	1
55	2025-09-28 06:41:12.820428+00	working_test	\N	\N	cli_task_clear	\N	\N	airflow	\N	{"host_name": "dbdeba4a27d0", "full_command": "['/home/airflow/.local/bin/airflow', 'tasks', 'clear', 'working_test']"}	\N
56	2025-09-28 06:42:00.849776+00	working_test	\N	\N	cli_task_clear	\N	\N	airflow	\N	{"host_name": "dbdeba4a27d0", "full_command": "['/home/airflow/.local/bin/airflow', 'tasks', 'clear', 'working_test']"}	\N
57	2025-09-28 06:42:01.890305+00	working_test	hello_world	-1	state mismatch	\N	manual__2025-09-28T06:38:34.045714+00:00	\N	\N	Executor LocalExecutor(parallelism=32) reported that the task instance <TaskInstance: working_test.hello_world manual__2025-09-28T06:38:34.045714+00:00 [queued]> finished with state failed, but the task instance's state attribute is queued. Learn more: https://airflow.apache.org/docs/apache-airflow/stable/troubleshooting.html#task-state-changed-externally	2
58	2025-09-28 06:42:01.893317+00	working_test	hello_world	-1	failed	2025-09-28 06:38:28.675+00	manual__2025-09-28T06:38:34.045714+00:00	airflow	\N	\N	2
59	2025-09-28 06:42:10.299376+00	working_test	hello_world	-1	state mismatch	\N	manual__2025-09-28T06:38:34.045714+00:00	\N	\N	Executor LocalExecutor(parallelism=32) reported that the task instance <TaskInstance: working_test.hello_world manual__2025-09-28T06:38:34.045714+00:00 [queued]> finished with state failed, but the task instance's state attribute is queued. Learn more: https://airflow.apache.org/docs/apache-airflow/stable/troubleshooting.html#task-state-changed-externally	3
60	2025-09-28 06:42:10.301363+00	working_test	hello_world	-1	failed	2025-09-28 06:38:28.675+00	manual__2025-09-28T06:38:34.045714+00:00	airflow	\N	\N	3
61	2025-09-28 06:42:52.239932+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "dbdeba4a27d0", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
62	2025-09-28 06:43:18.337739+00	working_test	hello_world	\N	cli_task_state	\N	\N	airflow	\N	{"host_name": "dbdeba4a27d0", "full_command": "['/home/airflow/.local/bin/airflow', 'tasks', 'state', 'working_test', 'hello_world', 'manual__2025-09-28T06:38:34.045714+00:00']"}	\N
63	2025-09-28 06:44:16.106018+00	working_test	\N	\N	cli_task_clear	\N	\N	airflow	\N	{"host_name": "dbdeba4a27d0", "full_command": "['/home/airflow/.local/bin/airflow', 'tasks', 'clear', 'working_test', '-t', 'hello_world', '--only-failed']"}	\N
64	2025-09-28 06:44:30.042827+00	working_test	hello_world	-1	state mismatch	\N	manual__2025-09-28T06:38:34.045714+00:00	\N	\N	Executor LocalExecutor(parallelism=32) reported that the task instance <TaskInstance: working_test.hello_world manual__2025-09-28T06:38:34.045714+00:00 [queued]> finished with state failed, but the task instance's state attribute is queued. Learn more: https://airflow.apache.org/docs/apache-airflow/stable/troubleshooting.html#task-state-changed-externally	4
65	2025-09-28 06:44:30.045529+00	working_test	hello_world	-1	failed	2025-09-28 06:38:28.675+00	manual__2025-09-28T06:38:34.045714+00:00	airflow	\N	\N	4
66	2025-09-28 06:44:30.750733+00	working_test	\N	\N	patch_dag	\N	\N	admin	admin	{"is_paused": false, "method": "PATCH"}	\N
67	2025-09-28 06:44:45.368882+00	working_test	\N	\N	cli_task_clear	\N	\N	airflow	\N	{"host_name": "dbdeba4a27d0", "full_command": "['/home/airflow/.local/bin/airflow', 'tasks', 'clear', 'working_test', '-t', 'hello_world', '--only-failed']"}	\N
68	2025-09-28 06:44:55.893831+00	working_test	hello_world	\N	cli_task_state	\N	\N	airflow	\N	{"host_name": "dbdeba4a27d0", "full_command": "['/home/airflow/.local/bin/airflow', 'tasks', 'state', 'working_test', 'hello_world', 'manual__2025-09-28T06:38:34.045714+00:00']"}	\N
69	2025-09-28 06:45:02.267215+00	working_test	\N	\N	cli_task_clear	\N	\N	airflow	\N	{"host_name": "dbdeba4a27d0", "full_command": "['/home/airflow/.local/bin/airflow', 'tasks', 'clear', 'working_test', '-t', 'hello_world', '--only-failed']"}	\N
70	2025-09-28 06:52:48.838105+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "b5619ce3fa6b", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
71	2025-09-28 06:52:51.380232+00	\N	\N	\N	cli_migratedb	\N	\N	airflow	\N	{"host_name": "b5619ce3fa6b", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'migrate']"}	\N
72	2025-09-28 06:52:54.001643+00	\N	\N	\N	cli_users_create	\N	\N	airflow	\N	{"host_name": "b5619ce3fa6b", "full_command": "['/home/airflow/.local/bin/airflow', 'users', 'create', '-u', 'admin', '-f', 'Admin', '-l', 'User', '-r', 'Admin', '-e', 'admin@example.com', '-p', '********']"}	\N
73	2025-09-28 06:53:06.998293+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "ea11e72023a2", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
74	2025-09-28 06:53:07.158214+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "1a703ba91371", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
75	2025-09-28 06:53:07.650866+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "38a0158cb364", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
76	2025-09-28 06:53:16.026677+00	\N	\N	\N	cli_api_server	\N	\N	airflow	\N	{"host_name": "1a703ba91371", "full_command": "['/home/airflow/.local/bin/airflow', 'api-server']"}	\N
77	2025-09-28 06:53:16.080316+00	\N	\N	\N	cli_dag_processor	\N	\N	airflow	\N	{"host_name": "ea11e72023a2", "full_command": "['/home/airflow/.local/bin/airflow', 'dag-processor']"}	\N
78	2025-09-28 06:53:19.86841+00	\N	\N	\N	cli_scheduler	\N	\N	airflow	\N	{"host_name": "38a0158cb364", "full_command": "['/home/airflow/.local/bin/airflow', 'scheduler']"}	\N
79	2025-09-28 06:54:38.186775+00	working_test	\N	\N	post_clear_task_instances	\N	manual__2025-09-28T06:38:34.045714+00:00	admin	admin	{"dry_run": true, "dag_run_id": "manual__2025-09-28T06:38:34.045714+00:00", "include_downstream": true, "include_future": false, "include_past": false, "include_upstream": false, "only_failed": false, "task_ids": [["hello_world", -1]], "method": "POST"}	\N
80	2025-09-28 06:54:38.34303+00	working_test	\N	\N	post_clear_task_instances	\N	manual__2025-09-28T06:38:34.045714+00:00	admin	admin	{"dry_run": true, "dag_run_id": "manual__2025-09-28T06:38:34.045714+00:00", "include_downstream": false, "include_future": false, "include_past": false, "include_upstream": false, "only_failed": false, "task_ids": [["hello_world", -1]], "method": "POST"}	\N
81	2025-09-28 06:54:41.085937+00	working_test	\N	\N	post_clear_task_instances	\N	manual__2025-09-28T06:38:34.045714+00:00	admin	admin	{"dag_run_id": "manual__2025-09-28T06:38:34.045714+00:00", "dry_run": false, "include_downstream": true, "include_future": false, "include_past": false, "include_upstream": false, "only_failed": false, "task_ids": [["hello_world", -1]], "method": "POST"}	\N
82	2025-09-28 06:54:41.138121+00	working_test	\N	\N	post_clear_task_instances	\N	manual__2025-09-28T06:38:34.045714+00:00	admin	admin	{"dry_run": true, "dag_run_id": "manual__2025-09-28T06:38:34.045714+00:00", "include_downstream": true, "include_future": false, "include_past": false, "include_upstream": false, "only_failed": false, "task_ids": [["hello_world", -1]], "method": "POST"}	\N
83	2025-09-28 06:54:43.927714+00	working_test	\N	\N	post_clear_task_instances	\N	manual__2025-09-28T06:38:34.045714+00:00	admin	admin	{"dry_run": true, "dag_run_id": "manual__2025-09-28T06:38:34.045714+00:00", "include_downstream": false, "include_future": false, "include_past": false, "include_upstream": false, "only_failed": false, "task_ids": [["hello_world", -1]], "method": "POST"}	\N
84	2025-09-28 06:54:46.144665+00	working_test	\N	\N	post_clear_task_instances	\N	manual__2025-09-28T06:38:34.045714+00:00	admin	admin	{"dry_run": true, "dag_run_id": "manual__2025-09-28T06:38:34.045714+00:00", "include_downstream": true, "include_future": false, "include_past": false, "include_upstream": false, "only_failed": true, "task_ids": [["hello_world", -1]], "method": "POST"}	\N
85	2025-09-28 06:54:47.124058+00	working_test	\N	\N	post_clear_task_instances	\N	manual__2025-09-28T06:38:34.045714+00:00	admin	admin	{"dry_run": true, "dag_run_id": "manual__2025-09-28T06:38:34.045714+00:00", "include_downstream": false, "include_future": false, "include_past": false, "include_upstream": false, "only_failed": true, "task_ids": [["hello_world", -1]], "method": "POST"}	\N
86	2025-09-28 06:54:48.722977+00	working_test	\N	\N	post_clear_task_instances	\N	manual__2025-09-28T06:38:34.045714+00:00	admin	admin	{"dry_run": true, "dag_run_id": "manual__2025-09-28T06:38:34.045714+00:00", "include_downstream": true, "include_future": false, "include_past": false, "include_upstream": true, "only_failed": true, "task_ids": [["hello_world", -1]], "method": "POST"}	\N
87	2025-09-28 06:54:53.90603+00	working_test	\N	\N	post_clear_task_instances	\N	manual__2025-09-28T06:38:34.045714+00:00	admin	admin	{"dry_run": true, "dag_run_id": "manual__2025-09-28T06:38:34.045714+00:00", "include_downstream": false, "include_future": false, "include_past": false, "include_upstream": false, "only_failed": false, "task_ids": [["hello_world", -1]], "method": "POST"}	\N
88	2025-09-28 06:54:53.927157+00	working_test	\N	\N	post_clear_task_instances	\N	manual__2025-09-28T06:38:34.045714+00:00	admin	admin	{"dry_run": true, "dag_run_id": "manual__2025-09-28T06:38:34.045714+00:00", "include_downstream": true, "include_future": false, "include_past": false, "include_upstream": false, "only_failed": false, "task_ids": [["hello_world", -1]], "method": "POST"}	\N
89	2025-09-28 06:54:54.834609+00	working_test	\N	\N	post_clear_task_instances	\N	manual__2025-09-28T06:38:34.045714+00:00	admin	admin	{"dag_run_id": "manual__2025-09-28T06:38:34.045714+00:00", "dry_run": false, "include_downstream": true, "include_future": false, "include_past": false, "include_upstream": false, "only_failed": false, "task_ids": [["hello_world", -1]], "method": "POST"}	\N
90	2025-09-28 06:54:55.077849+00	working_test	\N	\N	post_clear_task_instances	\N	manual__2025-09-28T06:38:34.045714+00:00	admin	admin	{"dry_run": true, "dag_run_id": "manual__2025-09-28T06:38:34.045714+00:00", "include_downstream": true, "include_future": false, "include_past": false, "include_upstream": false, "only_failed": false, "task_ids": [["hello_world", -1]], "method": "POST"}	\N
91	2025-09-28 06:54:59.209605+00	working_test	\N	\N	trigger_dag_run	\N	\N	admin	admin	{"conf": {}, "logical_date": "2025-09-28T06:54:56.024Z", "method": "POST"}	\N
92	2025-09-28 06:54:59.21092+00	working_test	\N	\N	patch_dag	\N	\N	admin	admin	{"is_paused": false, "method": "PATCH"}	\N
93	2025-09-28 06:55:11.003359+00	working_test	hello_world	-1	state mismatch	\N	manual__2025-09-28T06:54:59.211968+00:00	\N	\N	Executor LocalExecutor(parallelism=32) reported that the task instance <TaskInstance: working_test.hello_world manual__2025-09-28T06:54:59.211968+00:00 [queued]> finished with state failed, but the task instance's state attribute is queued. Learn more: https://airflow.apache.org/docs/apache-airflow/stable/troubleshooting.html#task-state-changed-externally	1
94	2025-09-28 06:55:11.006847+00	working_test	hello_world	-1	failed	2025-09-28 06:54:56.024+00	manual__2025-09-28T06:54:59.211968+00:00	airflow	\N	\N	1
95	2025-09-28 06:55:12.060513+00	working_test	hello_world	-1	state mismatch	\N	manual__2025-09-28T06:38:34.045714+00:00	\N	\N	Executor LocalExecutor(parallelism=32) reported that the task instance <TaskInstance: working_test.hello_world manual__2025-09-28T06:38:34.045714+00:00 [queued]> finished with state failed, but the task instance's state attribute is queued. Learn more: https://airflow.apache.org/docs/apache-airflow/stable/troubleshooting.html#task-state-changed-externally	5
96	2025-09-28 06:55:12.06568+00	working_test	hello_world	-1	failed	2025-09-28 06:38:28.675+00	manual__2025-09-28T06:38:34.045714+00:00	airflow	\N	\N	5
97	2025-09-28 06:57:36.035469+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "41610413e57d", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
98	2025-09-28 06:57:38.454966+00	\N	\N	\N	cli_migratedb	\N	\N	airflow	\N	{"host_name": "41610413e57d", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'migrate']"}	\N
99	2025-09-28 06:57:41.026818+00	\N	\N	\N	cli_users_create	\N	\N	airflow	\N	{"host_name": "41610413e57d", "full_command": "['/home/airflow/.local/bin/airflow', 'users', 'create', '-u', 'admin', '-f', 'Admin', '-l', 'User', '-r', 'Admin', '-e', 'admin@example.com', '-p', '********']"}	\N
100	2025-09-28 06:57:51.640207+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "6c405aa1d5dc", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
101	2025-09-28 06:57:52.6527+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "9e46b6e08719", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
102	2025-09-28 06:57:53.018608+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "5e7a4963df15", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
103	2025-09-28 06:58:01.277535+00	\N	\N	\N	cli_dag_processor	\N	\N	airflow	\N	{"host_name": "6c405aa1d5dc", "full_command": "['/home/airflow/.local/bin/airflow', 'dag-processor']"}	\N
104	2025-09-28 06:58:02.613097+00	\N	\N	\N	cli_api_server	\N	\N	airflow	\N	{"host_name": "9e46b6e08719", "full_command": "['/home/airflow/.local/bin/airflow', 'api-server']"}	\N
105	2025-09-28 06:58:08.302489+00	\N	\N	\N	cli_scheduler	\N	\N	airflow	\N	{"host_name": "5e7a4963df15", "full_command": "['/home/airflow/.local/bin/airflow', 'scheduler']"}	\N
106	2025-09-28 06:59:10.338957+00	working_test	\N	\N	cli_dag_delete	\N	\N	airflow	\N	{"host_name": "5e7a4963df15", "full_command": "['/home/airflow/.local/bin/airflow', 'dags', 'delete', 'working_test']"}	\N
107	2025-09-28 06:59:50.525325+00	working_test	\N	\N	cli_dag_test	\N	\N	airflow	\N	{"host_name": "5e7a4963df15", "full_command": "['/home/airflow/.local/bin/airflow', 'dags', 'test', 'working_test']"}	\N
108	2025-09-28 07:14:33.123494+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "6aaee2d64667", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
109	2025-09-28 07:14:35.926455+00	\N	\N	\N	cli_migratedb	\N	\N	airflow	\N	{"host_name": "6aaee2d64667", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'migrate']"}	\N
110	2025-09-28 07:14:38.938642+00	\N	\N	\N	cli_users_create	\N	\N	airflow	\N	{"host_name": "6aaee2d64667", "full_command": "['/home/airflow/.local/bin/airflow', 'users', 'create', '-u', 'admin', '-f', 'Admin', '-l', 'User', '-r', 'Admin', '-e', 'admin@example.com', '-p', '********']"}	\N
111	2025-09-28 07:14:52.991541+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "f26459aedac5", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
112	2025-09-28 07:14:53.191139+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "281367bf767b", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
113	2025-09-28 07:14:53.380225+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "3f8fbbc0fc9a", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
114	2025-09-28 07:15:03.814173+00	\N	\N	\N	cli_dag_processor	\N	\N	airflow	\N	{"host_name": "f26459aedac5", "full_command": "['/home/airflow/.local/bin/airflow', 'dag-processor']"}	\N
115	2025-09-28 07:15:04.836211+00	\N	\N	\N	cli_api_server	\N	\N	airflow	\N	{"host_name": "281367bf767b", "full_command": "['/home/airflow/.local/bin/airflow', 'api-server']"}	\N
116	2025-09-28 07:15:10.548402+00	\N	\N	\N	cli_scheduler	\N	\N	airflow	\N	{"host_name": "3f8fbbc0fc9a", "full_command": "['/home/airflow/.local/bin/airflow', 'scheduler']"}	\N
117	2025-09-28 07:17:38.648483+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "3f8fbbc0fc9a", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
118	2025-09-28 07:17:38.723196+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "f26459aedac5", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
119	2025-09-28 07:17:42.509611+00	\N	\N	\N	cli_dag_processor	\N	\N	airflow	\N	{"host_name": "f26459aedac5", "full_command": "['/home/airflow/.local/bin/airflow', 'dag-processor']"}	\N
120	2025-09-28 07:17:44.597679+00	\N	\N	\N	cli_scheduler	\N	\N	airflow	\N	{"host_name": "3f8fbbc0fc9a", "full_command": "['/home/airflow/.local/bin/airflow', 'scheduler']"}	\N
121	2025-09-28 07:27:21.653564+00	\N	\N	\N	cli_dag_list_dags	\N	\N	airflow	\N	{"host_name": "3f8fbbc0fc9a", "full_command": "['/home/airflow/.local/bin/airflow', 'dags', 'list']"}	\N
154	2025-09-28 07:30:35.760724+00	\N	\N	\N	post_connection	\N	\N	admin	admin	{"conn_type": "***", "connection_id": "***_default", "host": "db", "login": "***", "password": "***", "port": 5432, "schema": "dotodo", "method": "POST"}	\N
155	2025-09-28 07:31:31.074107+00	\N	\N	\N	cli_dag_list_dags	\N	\N	airflow	\N	{"host_name": "3f8fbbc0fc9a", "full_command": "['/home/airflow/.local/bin/airflow', 'dags', 'list']"}	\N
156	2025-09-28 07:31:49.997384+00	dotodo_daily_analytics	\N	\N	patch_dag	\N	\N	admin	admin	{"is_paused": false, "method": "PATCH"}	\N
157	2025-09-28 07:31:51.854906+00	dotodo_daily_analytics	create_analytics_table	-1	state mismatch	\N	scheduled__2025-09-28T01:00:00+00:00	\N	\N	Executor LocalExecutor(parallelism=32) reported that the task instance <TaskInstance: dotodo_daily_analytics.create_analytics_table scheduled__2025-09-28T01:00:00+00:00 [queued]> finished with state failed, but the task instance's state attribute is queued. Learn more: https://airflow.apache.org/docs/apache-airflow/stable/troubleshooting.html#task-state-changed-externally	1
158	2025-09-28 07:31:51.858433+00	dotodo_daily_analytics	create_analytics_table	-1	failed	2025-09-28 01:00:00+00	scheduled__2025-09-28T01:00:00+00:00	dotodo-team	\N	\N	1
159	2025-09-28 07:32:14.159524+00	dotodo_daily_analytics	\N	\N	trigger_dag_run	\N	\N	admin	admin	{"conf": {}, "logical_date": "2025-09-28T07:32:10.189Z", "method": "POST"}	\N
160	2025-09-28 07:32:44.012881+00	dotodo_daily_analytics	\N	\N	clear_dag_run	\N	manual__2025-09-28T07:32:14.161483+00:00	admin	admin	{"dry_run": true, "only_failed": false, "method": "POST"}	\N
161	2025-09-28 07:32:46.918378+00	dotodo_daily_analytics	\N	\N	clear_dag_run	\N	manual__2025-09-28T07:32:14.161483+00:00	admin	admin	{"dry_run": false, "only_failed": false, "method": "POST"}	\N
162	2025-09-28 07:32:47.020392+00	dotodo_daily_analytics	\N	\N	clear_dag_run	\N	manual__2025-09-28T07:32:14.161483+00:00	admin	admin	{"dry_run": true, "only_failed": false, "method": "POST"}	\N
164	2025-09-28 07:33:08.268643+00	dotodo_daily_analytics	\N	\N	clear_dag_run	\N	scheduled__2025-09-28T01:00:00+00:00	admin	admin	{"dry_run": true, "only_failed": false, "method": "POST"}	\N
165	2025-09-28 07:33:10.521902+00	dotodo_daily_analytics	\N	\N	clear_dag_run	\N	scheduled__2025-09-28T01:00:00+00:00	admin	admin	{"dry_run": false, "only_failed": false, "method": "POST"}	\N
166	2025-09-28 07:33:10.604085+00	dotodo_daily_analytics	\N	\N	clear_dag_run	\N	scheduled__2025-09-28T01:00:00+00:00	admin	admin	{"dry_run": true, "only_failed": false, "method": "POST"}	\N
187	2025-09-28 07:37:54.655358+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "e2f567647a05", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
188	2025-09-28 07:37:56.983006+00	\N	\N	\N	cli_migratedb	\N	\N	airflow	\N	{"host_name": "e2f567647a05", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'migrate']"}	\N
189	2025-09-28 07:37:59.429804+00	\N	\N	\N	cli_users_create	\N	\N	airflow	\N	{"host_name": "e2f567647a05", "full_command": "['/home/airflow/.local/bin/airflow', 'users', 'create', '-u', 'admin', '-f', 'Admin', '-l', 'User', '-r', 'Admin', '-e', 'admin@example.com', '-p', '********']"}	\N
190	2025-09-28 07:38:11.589837+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "bb2167535190", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
191	2025-09-28 07:38:11.731408+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "22f56049b7d8", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
192	2025-09-28 07:38:12.50204+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "7670bfc71c7c", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
193	2025-09-28 07:38:21.617874+00	\N	\N	\N	cli_api_server	\N	\N	airflow	\N	{"host_name": "bb2167535190", "full_command": "['/home/airflow/.local/bin/airflow', 'api-server']"}	\N
194	2025-09-28 07:38:22.418299+00	\N	\N	\N	cli_dag_processor	\N	\N	airflow	\N	{"host_name": "7670bfc71c7c", "full_command": "['/home/airflow/.local/bin/airflow', 'dag-processor']"}	\N
195	2025-09-28 07:38:26.940013+00	\N	\N	\N	cli_scheduler	\N	\N	airflow	\N	{"host_name": "22f56049b7d8", "full_command": "['/home/airflow/.local/bin/airflow', 'scheduler']"}	\N
\.


--
-- Data for Name: log_template; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.log_template (id, filename, elasticsearch_id, created_at) FROM stdin;
1	{{ ti.dag_id }}/{{ ti.task_id }}/{{ ts }}/{{ try_number }}.log	{dag_id}-{task_id}-{logical_date}-{try_number}	2025-09-26 08:38:47.944774+00
2	dag_id={{ ti.dag_id }}/run_id={{ ti.run_id }}/task_id={{ ti.task_id }}/{% if ti.map_index >= 0 %}map_index={{ ti.map_index }}/{% endif %}attempt={{ try_number|default(ti.try_number) }}.log	{dag_id}-{task_id}-{run_id}-{map_index}-{try_number}	2025-09-26 08:38:47.944782+00
\.


--
-- Data for Name: rendered_task_instance_fields; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rendered_task_instance_fields (dag_id, task_id, run_id, map_index, rendered_fields, k8s_pod_yaml) FROM stdin;
working_test	hello_world	manual__2025-09-28T06:59:50.712179+00:00	-1	{"bash_command": "echo \\"Airflow 3.0 Working!\\"", "env": null, "cwd": null}	null
\.


--
-- Data for Name: serialized_dag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.serialized_dag (id, dag_id, data, data_compressed, created_at, last_updated, dag_hash, dag_version_id) FROM stdin;
01998f1e-b034-7f1a-81f6-a96ece7890d2	working_test	{"__version": 2, "dag": {"disable_bundle_versioning": false, "dag_id": "working_test", "relative_fileloc": "working_test.py", "catchup": false, "timezone": "UTC", "edge_info": {}, "start_date": 1758844800.0, "fileloc": "/opt/airflow/dags/working_test.py", "tags": ["test"], "task_group": {"_group_id": null, "group_display_name": "", "prefix_group_id": true, "tooltip": "", "ui_color": "CornflowerBlue", "ui_fgcolor": "#000", "children": {"hello_world": ["operator", "hello_world"]}, "upstream_group_ids": [], "downstream_group_ids": [], "upstream_task_ids": [], "downstream_task_ids": []}, "timetable": {"__type": "airflow.timetables.simple.NullTimetable", "__var": {}}, "_processor_dags_folder": "/opt/airflow/dags", "tasks": [{"__var": {"ui_fgcolor": "#000", "is_teardown": false, "pool": "default_pool", "task_id": "hello_world", "is_setup": false, "template_fields": ["bash_command", "env", "cwd"], "template_ext": [".sh", ".bash"], "weight_rule": "downstream", "on_failure_fail_dagrun": false, "template_fields_renderers": {"bash_command": "bash", "env": "json"}, "start_from_trigger": false, "_needs_expansion": false, "downstream_task_ids": [], "task_type": "BashOperator", "ui_color": "#f0ede4", "_task_module": "airflow.providers.standard.operators.bash", "start_trigger_args": null, "bash_command": "echo \\"Airflow 3.0 Working!\\""}, "__type": "operator"}], "dag_dependencies": [], "params": []}}	\N	2025-09-28 06:59:37.140934+00	2025-09-28 06:59:37.14094+00	633141563eea9d3798ce1c0d2a8a6232	01998f1e-b032-7971-9b48-e30ccac657ca
01998f37-be0a-7a4b-b403-5451b7b3ad76	dotodo_daily_analytics	{"__version": 2, "dag": {"fileloc": "/opt/airflow/dags/dotodo_analytics.py", "relative_fileloc": "dotodo_analytics.py", "dag_id": "dotodo_daily_analytics", "max_active_runs": 1, "edge_info": {}, "start_date": 1758844800.0, "timetable": {"__type": "airflow.timetables.trigger.CronTriggerTimetable", "__var": {"expression": "0 1 * * *", "timezone": "UTC", "interval": 0.0, "run_immediately": false}}, "timezone": "UTC", "description": "DoTodo \\uc77c\\uc77c \\ub370\\uc774\\ud130 \\ubd84\\uc11d \\ud30c\\uc774\\ud504\\ub77c\\uc778", "disable_bundle_versioning": false, "catchup": false, "default_args": {"__var": {"owner": "dotodo-team", "depends_on_past": false, "start_date": {"__var": 1758844800.0, "__type": "datetime"}, "email_on_failure": false, "email_on_retry": false, "retries": 1, "retry_delay": {"__var": 300.0, "__type": "timedelta"}}, "__type": "dict"}, "task_group": {"_group_id": null, "group_display_name": "", "prefix_group_id": true, "tooltip": "", "ui_color": "CornflowerBlue", "ui_fgcolor": "#000", "children": {"create_analytics_table": ["operator", "create_analytics_table"], "extract_user_activity": ["operator", "extract_user_activity"], "calculate_completion_rates": ["operator", "calculate_completion_rates"], "analyze_category_trends": ["operator", "analyze_category_trends"], "detect_user_patterns": ["operator", "detect_user_patterns"], "generate_daily_summary": ["operator", "generate_daily_summary"], "save_analytics_results": ["operator", "save_analytics_results"]}, "upstream_group_ids": [], "downstream_group_ids": [], "upstream_task_ids": [], "downstream_task_ids": []}, "tags": ["analytics", "daily", "dotodo"], "_processor_dags_folder": "/opt/airflow/dags", "tasks": [{"__var": {"_needs_expansion": false, "template_fields_renderers": {"templates_dict": "json", "op_args": "py", "op_kwargs": "py"}, "pool": "default_pool", "retry_delay": 300.0, "template_ext": [], "weight_rule": "downstream", "template_fields": ["templates_dict", "op_args", "op_kwargs"], "task_id": "create_analytics_table", "email_on_retry": false, "owner": "dotodo-team", "email_on_failure": false, "downstream_task_ids": ["extract_user_activity"], "is_teardown": false, "on_failure_fail_dagrun": false, "is_setup": false, "retries": 1, "start_from_trigger": false, "ui_fgcolor": "#000", "ui_color": "#ffefeb", "task_type": "PythonOperator", "python_callable_name": "unusual_prefix_d139a1ad77b87dedc023bb144006c78a5c283ad7_dotodo_analytics.create_analytics_table_func", "_task_module": "airflow.providers.standard.operators.python", "start_trigger_args": null, "op_args": [], "op_kwargs": {}}, "__type": "operator"}, {"__var": {"_needs_expansion": false, "template_fields_renderers": {"templates_dict": "json", "op_args": "py", "op_kwargs": "py"}, "pool": "default_pool", "retry_delay": 300.0, "template_ext": [], "weight_rule": "downstream", "template_fields": ["templates_dict", "op_args", "op_kwargs"], "task_id": "extract_user_activity", "email_on_retry": false, "owner": "dotodo-team", "email_on_failure": false, "downstream_task_ids": ["analyze_category_trends", "calculate_completion_rates", "detect_user_patterns"], "is_teardown": false, "on_failure_fail_dagrun": false, "is_setup": false, "retries": 1, "start_from_trigger": false, "ui_fgcolor": "#000", "ui_color": "#ffefeb", "task_type": "PythonOperator", "python_callable_name": "unusual_prefix_d139a1ad77b87dedc023bb144006c78a5c283ad7_dotodo_analytics.extract_user_activity_data", "_task_module": "airflow.providers.standard.operators.python", "start_trigger_args": null, "op_args": [], "op_kwargs": {}}, "__type": "operator"}, {"__var": {"_needs_expansion": false, "template_fields_renderers": {"templates_dict": "json", "op_args": "py", "op_kwargs": "py"}, "pool": "default_pool", "retry_delay": 300.0, "template_ext": [], "weight_rule": "downstream", "template_fields": ["templates_dict", "op_args", "op_kwargs"], "task_id": "calculate_completion_rates", "email_on_retry": false, "owner": "dotodo-team", "email_on_failure": false, "downstream_task_ids": ["generate_daily_summary"], "is_teardown": false, "on_failure_fail_dagrun": false, "is_setup": false, "retries": 1, "start_from_trigger": false, "ui_fgcolor": "#000", "ui_color": "#ffefeb", "task_type": "PythonOperator", "python_callable_name": "unusual_prefix_d139a1ad77b87dedc023bb144006c78a5c283ad7_dotodo_analytics.calculate_completion_rates", "_task_module": "airflow.providers.standard.operators.python", "start_trigger_args": null, "op_args": [], "op_kwargs": {}}, "__type": "operator"}, {"__var": {"_needs_expansion": false, "template_fields_renderers": {"templates_dict": "json", "op_args": "py", "op_kwargs": "py"}, "pool": "default_pool", "retry_delay": 300.0, "template_ext": [], "weight_rule": "downstream", "template_fields": ["templates_dict", "op_args", "op_kwargs"], "task_id": "analyze_category_trends", "email_on_retry": false, "owner": "dotodo-team", "email_on_failure": false, "downstream_task_ids": ["generate_daily_summary"], "is_teardown": false, "on_failure_fail_dagrun": false, "is_setup": false, "retries": 1, "start_from_trigger": false, "ui_fgcolor": "#000", "ui_color": "#ffefeb", "task_type": "PythonOperator", "python_callable_name": "unusual_prefix_d139a1ad77b87dedc023bb144006c78a5c283ad7_dotodo_analytics.analyze_category_trends", "_task_module": "airflow.providers.standard.operators.python", "start_trigger_args": null, "op_args": [], "op_kwargs": {}}, "__type": "operator"}, {"__var": {"_needs_expansion": false, "template_fields_renderers": {"templates_dict": "json", "op_args": "py", "op_kwargs": "py"}, "pool": "default_pool", "retry_delay": 300.0, "template_ext": [], "weight_rule": "downstream", "template_fields": ["templates_dict", "op_args", "op_kwargs"], "task_id": "detect_user_patterns", "email_on_retry": false, "owner": "dotodo-team", "email_on_failure": false, "downstream_task_ids": ["generate_daily_summary"], "is_teardown": false, "on_failure_fail_dagrun": false, "is_setup": false, "retries": 1, "start_from_trigger": false, "ui_fgcolor": "#000", "ui_color": "#ffefeb", "task_type": "PythonOperator", "python_callable_name": "unusual_prefix_d139a1ad77b87dedc023bb144006c78a5c283ad7_dotodo_analytics.detect_user_patterns", "_task_module": "airflow.providers.standard.operators.python", "start_trigger_args": null, "op_args": [], "op_kwargs": {}}, "__type": "operator"}, {"__var": {"_needs_expansion": false, "template_fields_renderers": {"templates_dict": "json", "op_args": "py", "op_kwargs": "py"}, "pool": "default_pool", "retry_delay": 300.0, "template_ext": [], "weight_rule": "downstream", "template_fields": ["templates_dict", "op_args", "op_kwargs"], "task_id": "generate_daily_summary", "email_on_retry": false, "owner": "dotodo-team", "email_on_failure": false, "downstream_task_ids": ["save_analytics_results"], "is_teardown": false, "on_failure_fail_dagrun": false, "is_setup": false, "retries": 1, "start_from_trigger": false, "ui_fgcolor": "#000", "ui_color": "#ffefeb", "task_type": "PythonOperator", "python_callable_name": "unusual_prefix_d139a1ad77b87dedc023bb144006c78a5c283ad7_dotodo_analytics.generate_daily_summary", "_task_module": "airflow.providers.standard.operators.python", "start_trigger_args": null, "op_args": [], "op_kwargs": {}}, "__type": "operator"}, {"__var": {"_needs_expansion": false, "template_fields_renderers": {"templates_dict": "json", "op_args": "py", "op_kwargs": "py"}, "pool": "default_pool", "retry_delay": 300.0, "template_ext": [], "weight_rule": "downstream", "template_fields": ["templates_dict", "op_args", "op_kwargs"], "task_id": "save_analytics_results", "email_on_retry": false, "owner": "dotodo-team", "email_on_failure": false, "downstream_task_ids": [], "is_teardown": false, "on_failure_fail_dagrun": false, "is_setup": false, "retries": 1, "start_from_trigger": false, "ui_fgcolor": "#000", "ui_color": "#ffefeb", "task_type": "PythonOperator", "python_callable_name": "unusual_prefix_d139a1ad77b87dedc023bb144006c78a5c283ad7_dotodo_analytics.save_analytics_results", "_task_module": "airflow.providers.standard.operators.python", "start_trigger_args": null, "op_args": [], "op_kwargs": {}}, "__type": "operator"}], "dag_dependencies": [], "params": []}}	\N	2025-09-28 07:26:59.08282+00	2025-09-28 07:26:59.082825+00	138151d212d5881bbcbbc4dd3b9a78a5	01998f37-be07-7d26-98db-6cc791837d3f
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.session (id, session_id, data, expiry) FROM stdin;
1	d4fffa12-f3a7-447b-b177-d902f1705270	\\x80049563000000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894898c0a637372665f746f6b656e948c2861656261326132623332326430343163323938653764313465356136643234373362653130643531948c066c6f63616c65948c02656e94752e	2025-10-26 08:50:39.909167
2	1523cc1b-64a6-4b15-ac6a-20477ce5e194	\\x800495f9000000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894888c0a637372665f746f6b656e948c2861656261326132623332326430343163323938653764313465356136643234373362653130643531948c066c6f63616c65948c02656e948c085f757365725f6964944b018c035f6964948c80323861383236643062333433666139613565663432323762653033306232353262613630336238303636333738633039623632623466663966663961373234383939343562363965363562313331343433396534626330666238346530643034323039653430613230396539373961306634313864346331373237666364386694752e	2025-10-28 06:38:24.304212
\.


--
-- Data for Name: slot_pool; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.slot_pool (id, pool, slots, description, include_deferred) FROM stdin;
1	default_pool	128	Default pool	f
\.


--
-- Data for Name: task_instance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_instance (id, task_id, dag_id, run_id, map_index, start_date, end_date, duration, state, try_number, max_tries, hostname, unixname, pool, pool_slots, queue, priority_weight, operator, custom_operator_name, queued_dttm, scheduled_dttm, queued_by_job_id, last_heartbeat_at, pid, executor, executor_config, updated_at, rendered_map_index, context_carrier, span_status, external_executor_id, trigger_id, trigger_timeout, next_method, next_kwargs, task_display_name, dag_version_id) FROM stdin;
01998f1e-e62b-79f3-9705-4efefc00e9e4	hello_world	working_test	manual__2025-09-28T06:59:50.712179+00:00	-1	2025-09-28 06:59:51.165348+00	2025-09-28 06:59:53.058917+00	1.893569	success	1	0	5e7a4963df15	airflow	default_pool	1	default	1	BashOperator	\N	\N	2025-09-28 06:59:50.963084+00	\N	2025-09-28 06:59:51.856795+00	45	\N	\\x80057d942e	2025-09-28 06:59:53.080991+00	\N	\N	not_started	\N	\N	\N	\N	\N	hello_world	01998f1e-b032-7971-9b48-e30ccac657ca
01998f3d-0ccd-72e7-b741-b6deaebd7d7b	create_analytics_table	dotodo_daily_analytics	manual__2025-09-28T07:32:14.161483+00:00	-1	\N	2025-09-28 07:32:46.924035+00	\N	\N	0	1		airflow	default_pool	1	default	7	PythonOperator	\N	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:32:46.947171+00	\N	\N	not_started	\N	\N	\N	\N	\N	create_analytics_table	01998f37-be07-7d26-98db-6cc791837d3f
01998f3d-0cd2-7c1b-bf14-e59092fac113	extract_user_activity	dotodo_daily_analytics	manual__2025-09-28T07:32:14.161483+00:00	-1	\N	2025-09-28 07:32:46.930283+00	\N	\N	0	1		airflow	default_pool	1	default	6	PythonOperator	\N	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:32:46.947175+00	\N	\N	not_started	\N	\N	\N	\N	\N	extract_user_activity	01998f37-be07-7d26-98db-6cc791837d3f
01998f3d-0cd4-7ff9-b464-3325962aa19e	calculate_completion_rates	dotodo_daily_analytics	manual__2025-09-28T07:32:14.161483+00:00	-1	\N	2025-09-28 07:32:46.932015+00	\N	\N	0	1		airflow	default_pool	1	default	3	PythonOperator	\N	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:32:46.947176+00	\N	\N	not_started	\N	\N	\N	\N	\N	calculate_completion_rates	01998f37-be07-7d26-98db-6cc791837d3f
01998f3d-0cd5-7027-b0a2-26c0aca99972	analyze_category_trends	dotodo_daily_analytics	manual__2025-09-28T07:32:14.161483+00:00	-1	\N	2025-09-28 07:32:46.933501+00	\N	\N	0	1		airflow	default_pool	1	default	3	PythonOperator	\N	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:32:46.947178+00	\N	\N	not_started	\N	\N	\N	\N	\N	analyze_category_trends	01998f37-be07-7d26-98db-6cc791837d3f
01998f3d-0cd7-7e49-95f2-89d299f0c110	detect_user_patterns	dotodo_daily_analytics	manual__2025-09-28T07:32:14.161483+00:00	-1	\N	2025-09-28 07:32:46.935027+00	\N	\N	0	1		airflow	default_pool	1	default	3	PythonOperator	\N	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:32:46.94718+00	\N	\N	not_started	\N	\N	\N	\N	\N	detect_user_patterns	01998f37-be07-7d26-98db-6cc791837d3f
01998f3d-0cd8-7fa9-834a-5fb864c8a49d	generate_daily_summary	dotodo_daily_analytics	manual__2025-09-28T07:32:14.161483+00:00	-1	\N	2025-09-28 07:32:46.93651+00	\N	\N	0	1		airflow	default_pool	1	default	2	PythonOperator	\N	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:32:46.94718+00	\N	\N	not_started	\N	\N	\N	\N	\N	generate_daily_summary	01998f37-be07-7d26-98db-6cc791837d3f
01998f3d-0cda-7389-a1b4-e88504bec2ca	save_analytics_results	dotodo_daily_analytics	manual__2025-09-28T07:32:14.161483+00:00	-1	\N	2025-09-28 07:32:46.937931+00	\N	\N	0	1		airflow	default_pool	1	default	1	PythonOperator	\N	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:32:46.947181+00	\N	\N	not_started	\N	\N	\N	\N	\N	save_analytics_results	01998f37-be07-7d26-98db-6cc791837d3f
01998f3d-6904-72c8-98b4-e8820c2f99e9	create_analytics_table	dotodo_daily_analytics	scheduled__2025-09-28T01:00:00+00:00	-1	\N	2025-09-28 07:33:10.53054+00	\N	\N	1	2		airflow	default_pool	1	default	7	PythonOperator	\N	2025-09-28 07:31:50.757766+00	2025-09-28 07:31:50.745505+00	16	\N	\N	\N	\\x80057d942e	2025-09-28 07:33:10.556556+00	\N	\N	not_started	\N	\N	\N	\N	\N	create_analytics_table	01998f37-be07-7d26-98db-6cc791837d3f
01998f3d-690b-76f2-b31d-0f57df0f9e63	extract_user_activity	dotodo_daily_analytics	scheduled__2025-09-28T01:00:00+00:00	-1	\N	2025-09-28 07:33:10.538223+00	\N	\N	0	1		airflow	default_pool	1	default	6	PythonOperator	\N	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:33:10.557478+00	\N	\N	not_started	\N	\N	\N	\N	\N	extract_user_activity	01998f37-be07-7d26-98db-6cc791837d3f
01998f3d-690d-7ba7-8f6a-c6058ae0b3f1	calculate_completion_rates	dotodo_daily_analytics	scheduled__2025-09-28T01:00:00+00:00	-1	\N	2025-09-28 07:33:10.54044+00	\N	\N	0	1		airflow	default_pool	1	default	3	PythonOperator	\N	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:33:10.557481+00	\N	\N	not_started	\N	\N	\N	\N	\N	calculate_completion_rates	01998f37-be07-7d26-98db-6cc791837d3f
01998f3d-690f-7b57-a6e0-af64936cd3b9	analyze_category_trends	dotodo_daily_analytics	scheduled__2025-09-28T01:00:00+00:00	-1	\N	2025-09-28 07:33:10.543202+00	\N	\N	0	1		airflow	default_pool	1	default	3	PythonOperator	\N	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:33:10.557482+00	\N	\N	not_started	\N	\N	\N	\N	\N	analyze_category_trends	01998f37-be07-7d26-98db-6cc791837d3f
01998f3d-6911-7eeb-9e76-59f18e762029	detect_user_patterns	dotodo_daily_analytics	scheduled__2025-09-28T01:00:00+00:00	-1	\N	2025-09-28 07:33:10.544536+00	\N	\N	0	1		airflow	default_pool	1	default	3	PythonOperator	\N	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:33:10.557483+00	\N	\N	not_started	\N	\N	\N	\N	\N	detect_user_patterns	01998f37-be07-7d26-98db-6cc791837d3f
01998f3d-6913-74dd-b0e6-bd8b87375590	generate_daily_summary	dotodo_daily_analytics	scheduled__2025-09-28T01:00:00+00:00	-1	\N	2025-09-28 07:33:10.546631+00	\N	\N	0	1		airflow	default_pool	1	default	2	PythonOperator	\N	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:33:10.557484+00	\N	\N	not_started	\N	\N	\N	\N	\N	generate_daily_summary	01998f37-be07-7d26-98db-6cc791837d3f
01998f3d-6916-7c0d-b785-b66dee4dc1fc	save_analytics_results	dotodo_daily_analytics	scheduled__2025-09-28T01:00:00+00:00	-1	\N	2025-09-28 07:33:10.549169+00	\N	\N	0	1		airflow	default_pool	1	default	1	PythonOperator	\N	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:33:10.557485+00	\N	\N	not_started	\N	\N	\N	\N	\N	save_analytics_results	01998f37-be07-7d26-98db-6cc791837d3f
\.


--
-- Data for Name: task_instance_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_instance_history (task_instance_id, task_id, dag_id, run_id, map_index, try_number, start_date, end_date, duration, state, max_tries, hostname, unixname, pool, pool_slots, queue, priority_weight, operator, custom_operator_name, queued_dttm, scheduled_dttm, queued_by_job_id, pid, executor, executor_config, updated_at, rendered_map_index, context_carrier, span_status, external_executor_id, trigger_id, trigger_timeout, next_method, next_kwargs, task_display_name, dag_version_id) FROM stdin;
01998f3c-8ce8-7ccd-a65e-0e0294493b88	create_analytics_table	dotodo_daily_analytics	manual__2025-09-28T07:32:14.161483+00:00	-1	0	\N	2025-09-28 07:32:46.924035+00	\N	failed	1		airflow	default_pool	1	default	7	PythonOperator	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:32:14.178032+00	\N	null	not_started	\N	\N	\N	\N	null	create_analytics_table	01998f37-be07-7d26-98db-6cc791837d3f
01998f3c-8ce9-7f8b-9c74-a106edd3ba58	extract_user_activity	dotodo_daily_analytics	manual__2025-09-28T07:32:14.161483+00:00	-1	0	\N	2025-09-28 07:32:46.930283+00	\N	failed	1		airflow	default_pool	1	default	6	PythonOperator	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:32:14.178043+00	\N	null	not_started	\N	\N	\N	\N	null	extract_user_activity	01998f37-be07-7d26-98db-6cc791837d3f
01998f3c-8cea-71c8-955f-941dc7fb89ce	calculate_completion_rates	dotodo_daily_analytics	manual__2025-09-28T07:32:14.161483+00:00	-1	0	\N	2025-09-28 07:32:46.932015+00	\N	failed	1		airflow	default_pool	1	default	3	PythonOperator	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:32:14.17805+00	\N	null	not_started	\N	\N	\N	\N	null	calculate_completion_rates	01998f37-be07-7d26-98db-6cc791837d3f
01998f3c-8ceb-7927-98cf-ab0d56a6fae7	analyze_category_trends	dotodo_daily_analytics	manual__2025-09-28T07:32:14.161483+00:00	-1	0	\N	2025-09-28 07:32:46.933501+00	\N	failed	1		airflow	default_pool	1	default	3	PythonOperator	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:32:14.178061+00	\N	null	not_started	\N	\N	\N	\N	null	analyze_category_trends	01998f37-be07-7d26-98db-6cc791837d3f
01998f3c-8cec-7a31-9830-42b8853a078b	detect_user_patterns	dotodo_daily_analytics	manual__2025-09-28T07:32:14.161483+00:00	-1	0	\N	2025-09-28 07:32:46.935027+00	\N	failed	1		airflow	default_pool	1	default	3	PythonOperator	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:32:14.178067+00	\N	null	not_started	\N	\N	\N	\N	null	detect_user_patterns	01998f37-be07-7d26-98db-6cc791837d3f
01998f3c-8ced-7d84-846d-0fffc6d57a93	generate_daily_summary	dotodo_daily_analytics	manual__2025-09-28T07:32:14.161483+00:00	-1	0	\N	2025-09-28 07:32:46.93651+00	\N	failed	1		airflow	default_pool	1	default	2	PythonOperator	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:32:14.178072+00	\N	null	not_started	\N	\N	\N	\N	null	generate_daily_summary	01998f37-be07-7d26-98db-6cc791837d3f
01998f3c-8cee-7814-8de1-fe2a8366123b	save_analytics_results	dotodo_daily_analytics	manual__2025-09-28T07:32:14.161483+00:00	-1	0	\N	2025-09-28 07:32:46.937931+00	\N	failed	1		airflow	default_pool	1	default	1	PythonOperator	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:32:14.178076+00	\N	null	not_started	\N	\N	\N	\N	null	save_analytics_results	01998f37-be07-7d26-98db-6cc791837d3f
01998f3c-313e-7c9f-b881-b59c3c24d698	create_analytics_table	dotodo_daily_analytics	scheduled__2025-09-28T01:00:00+00:00	-1	1	\N	2025-09-28 07:33:10.53054+00	\N	failed	1		airflow	default_pool	1	default	7	PythonOperator	\N	2025-09-28 07:31:50.757766+00	2025-09-28 07:31:50.745505+00	16	\N	\N	\\x80057d942e	2025-09-28 07:31:51.864602+00	\N	null	not_started	\N	\N	\N	\N	null	create_analytics_table	01998f37-be07-7d26-98db-6cc791837d3f
01998f3c-313f-7aa1-ac6f-d62993469ee4	extract_user_activity	dotodo_daily_analytics	scheduled__2025-09-28T01:00:00+00:00	-1	0	\N	2025-09-28 07:33:10.538223+00	\N	failed	1		airflow	default_pool	1	default	6	PythonOperator	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:31:50.712322+00	\N	null	not_started	\N	\N	\N	\N	null	extract_user_activity	01998f37-be07-7d26-98db-6cc791837d3f
01998f3c-3140-7e50-91e9-cf09d83fc66f	calculate_completion_rates	dotodo_daily_analytics	scheduled__2025-09-28T01:00:00+00:00	-1	0	\N	2025-09-28 07:33:10.54044+00	\N	failed	1		airflow	default_pool	1	default	3	PythonOperator	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:31:50.71233+00	\N	null	not_started	\N	\N	\N	\N	null	calculate_completion_rates	01998f37-be07-7d26-98db-6cc791837d3f
01998f3c-3141-7859-93c6-9d04388b062d	analyze_category_trends	dotodo_daily_analytics	scheduled__2025-09-28T01:00:00+00:00	-1	0	\N	2025-09-28 07:33:10.543202+00	\N	failed	1		airflow	default_pool	1	default	3	PythonOperator	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:31:50.71234+00	\N	null	not_started	\N	\N	\N	\N	null	analyze_category_trends	01998f37-be07-7d26-98db-6cc791837d3f
01998f3c-3142-7de4-9a18-981ab384ea33	detect_user_patterns	dotodo_daily_analytics	scheduled__2025-09-28T01:00:00+00:00	-1	0	\N	2025-09-28 07:33:10.544536+00	\N	failed	1		airflow	default_pool	1	default	3	PythonOperator	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:31:50.712346+00	\N	null	not_started	\N	\N	\N	\N	null	detect_user_patterns	01998f37-be07-7d26-98db-6cc791837d3f
01998f3c-3143-74e9-a7b8-e91e715ef213	generate_daily_summary	dotodo_daily_analytics	scheduled__2025-09-28T01:00:00+00:00	-1	0	\N	2025-09-28 07:33:10.546631+00	\N	failed	1		airflow	default_pool	1	default	2	PythonOperator	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:31:50.712351+00	\N	null	not_started	\N	\N	\N	\N	null	generate_daily_summary	01998f37-be07-7d26-98db-6cc791837d3f
01998f3c-3144-707c-94d0-22f40d8bc2d1	save_analytics_results	dotodo_daily_analytics	scheduled__2025-09-28T01:00:00+00:00	-1	0	\N	2025-09-28 07:33:10.549169+00	\N	failed	1		airflow	default_pool	1	default	1	PythonOperator	\N	\N	\N	\N	\N	\N	\\x80057d942e	2025-09-28 07:31:50.712356+00	\N	null	not_started	\N	\N	\N	\N	null	save_analytics_results	01998f37-be07-7d26-98db-6cc791837d3f
\.


--
-- Data for Name: task_instance_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_instance_note (ti_id, user_id, content, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: task_map; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_map (dag_id, task_id, run_id, map_index, length, keys) FROM stdin;
\.


--
-- Data for Name: task_outlet_asset_reference; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_outlet_asset_reference (asset_id, dag_id, task_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: task_reschedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_reschedule (id, ti_id, start_date, end_date, duration, reschedule_date) FROM stdin;
\.


--
-- Data for Name: trigger; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trigger (id, classpath, kwargs, created_date, triggerer_id) FROM stdin;
\.


--
-- Data for Name: variable; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.variable (id, key, val, description, is_encrypted) FROM stdin;
\.


--
-- Data for Name: xcom; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.xcom (dag_run_id, task_id, map_index, key, dag_id, run_id, value, "timestamp") FROM stdin;
3	hello_world	-1	return_value	working_test	manual__2025-09-28T06:59:50.712179+00:00	"Airflow 3.0 Working!"	2025-09-28 06:59:53.055103+00
\.


--
-- Name: ab_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ab_group_id_seq', 1, false);


--
-- Name: ab_group_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ab_group_role_id_seq', 1, false);


--
-- Name: ab_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ab_permission_id_seq', 5, true);


--
-- Name: ab_permission_view_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ab_permission_view_id_seq', 139, true);


--
-- Name: ab_permission_view_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ab_permission_view_role_id_seq', 249, true);


--
-- Name: ab_register_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ab_register_user_id_seq', 1, false);


--
-- Name: ab_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ab_role_id_seq', 5, true);


--
-- Name: ab_user_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ab_user_group_id_seq', 1, false);


--
-- Name: ab_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ab_user_id_seq', 1, true);


--
-- Name: ab_user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ab_user_role_id_seq', 1, true);


--
-- Name: ab_view_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ab_view_menu_id_seq', 86, true);


--
-- Name: asset_alias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.asset_alias_id_seq', 1, false);


--
-- Name: asset_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.asset_event_id_seq', 1, false);


--
-- Name: asset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.asset_id_seq', 1, false);


--
-- Name: backfill_dag_run_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backfill_dag_run_id_seq', 1, false);


--
-- Name: backfill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backfill_id_seq', 1, false);


--
-- Name: callback_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.callback_request_id_seq', 1, false);


--
-- Name: connection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.connection_id_seq', 33, true);


--
-- Name: dag_run_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dag_run_id_seq', 36, true);


--
-- Name: import_error_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.import_error_id_seq', 2, true);


--
-- Name: job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.job_id_seq', 18, true);


--
-- Name: log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.log_id_seq', 195, true);


--
-- Name: log_template_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.log_template_id_seq', 2, true);


--
-- Name: session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.session_id_seq', 2, true);


--
-- Name: slot_pool_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.slot_pool_id_seq', 1, true);


--
-- Name: task_reschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_reschedule_id_seq', 1, false);


--
-- Name: trigger_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trigger_id_seq', 1, false);


--
-- Name: variable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.variable_id_seq', 1, false);


--
-- Name: ab_group ab_group_name_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_group
    ADD CONSTRAINT ab_group_name_uq UNIQUE (name);


--
-- Name: ab_group ab_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_group
    ADD CONSTRAINT ab_group_pkey PRIMARY KEY (id);


--
-- Name: ab_group_role ab_group_role_group_id_role_id_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_group_role
    ADD CONSTRAINT ab_group_role_group_id_role_id_uq UNIQUE (group_id, role_id);


--
-- Name: ab_group_role ab_group_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_group_role
    ADD CONSTRAINT ab_group_role_pkey PRIMARY KEY (id);


--
-- Name: ab_permission ab_permission_name_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_permission
    ADD CONSTRAINT ab_permission_name_uq UNIQUE (name);


--
-- Name: ab_permission ab_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_permission
    ADD CONSTRAINT ab_permission_pkey PRIMARY KEY (id);


--
-- Name: ab_permission_view ab_permission_view_permission_id_view_menu_id_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_permission_view
    ADD CONSTRAINT ab_permission_view_permission_id_view_menu_id_uq UNIQUE (permission_id, view_menu_id);


--
-- Name: ab_permission_view ab_permission_view_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_permission_view
    ADD CONSTRAINT ab_permission_view_pkey PRIMARY KEY (id);


--
-- Name: ab_permission_view_role ab_permission_view_role_permission_view_id_role_id_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_permission_view_role
    ADD CONSTRAINT ab_permission_view_role_permission_view_id_role_id_uq UNIQUE (permission_view_id, role_id);


--
-- Name: ab_permission_view_role ab_permission_view_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_permission_view_role
    ADD CONSTRAINT ab_permission_view_role_pkey PRIMARY KEY (id);


--
-- Name: ab_register_user ab_register_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_register_user
    ADD CONSTRAINT ab_register_user_pkey PRIMARY KEY (id);


--
-- Name: ab_register_user ab_register_user_username_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_register_user
    ADD CONSTRAINT ab_register_user_username_uq UNIQUE (username);


--
-- Name: ab_role ab_role_name_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_role
    ADD CONSTRAINT ab_role_name_uq UNIQUE (name);


--
-- Name: ab_role ab_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_role
    ADD CONSTRAINT ab_role_pkey PRIMARY KEY (id);


--
-- Name: ab_user ab_user_email_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user
    ADD CONSTRAINT ab_user_email_uq UNIQUE (email);


--
-- Name: ab_user_group ab_user_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user_group
    ADD CONSTRAINT ab_user_group_pkey PRIMARY KEY (id);


--
-- Name: ab_user_group ab_user_group_user_id_group_id_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user_group
    ADD CONSTRAINT ab_user_group_user_id_group_id_uq UNIQUE (user_id, group_id);


--
-- Name: ab_user ab_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user
    ADD CONSTRAINT ab_user_pkey PRIMARY KEY (id);


--
-- Name: ab_user_role ab_user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user_role
    ADD CONSTRAINT ab_user_role_pkey PRIMARY KEY (id);


--
-- Name: ab_user_role ab_user_role_user_id_role_id_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user_role
    ADD CONSTRAINT ab_user_role_user_id_role_id_uq UNIQUE (user_id, role_id);


--
-- Name: ab_user ab_user_username_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user
    ADD CONSTRAINT ab_user_username_uq UNIQUE (username);


--
-- Name: ab_view_menu ab_view_menu_name_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_view_menu
    ADD CONSTRAINT ab_view_menu_name_uq UNIQUE (name);


--
-- Name: ab_view_menu ab_view_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_view_menu
    ADD CONSTRAINT ab_view_menu_pkey PRIMARY KEY (id);


--
-- Name: alembic_version_fab alembic_version_fab_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version_fab
    ADD CONSTRAINT alembic_version_fab_pkc PRIMARY KEY (version_num);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: asset_active asset_active_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_active
    ADD CONSTRAINT asset_active_pkey PRIMARY KEY (name, uri);


--
-- Name: asset_alias_asset_event asset_alias_asset_event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_alias_asset_event
    ADD CONSTRAINT asset_alias_asset_event_pkey PRIMARY KEY (alias_id, event_id);


--
-- Name: asset_alias_asset asset_alias_asset_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_alias_asset
    ADD CONSTRAINT asset_alias_asset_pkey PRIMARY KEY (alias_id, asset_id);


--
-- Name: asset_alias asset_alias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_alias
    ADD CONSTRAINT asset_alias_pkey PRIMARY KEY (id);


--
-- Name: asset_event asset_event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_event
    ADD CONSTRAINT asset_event_pkey PRIMARY KEY (id);


--
-- Name: asset asset_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset
    ADD CONSTRAINT asset_pkey PRIMARY KEY (id);


--
-- Name: asset_trigger asset_trigger_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_trigger
    ADD CONSTRAINT asset_trigger_pkey PRIMARY KEY (asset_id, trigger_id);


--
-- Name: asset_dag_run_queue assetdagrunqueue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_dag_run_queue
    ADD CONSTRAINT assetdagrunqueue_pkey PRIMARY KEY (asset_id, target_dag_id);


--
-- Name: backfill_dag_run backfill_dag_run_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backfill_dag_run
    ADD CONSTRAINT backfill_dag_run_pkey PRIMARY KEY (id);


--
-- Name: backfill backfill_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backfill
    ADD CONSTRAINT backfill_pkey PRIMARY KEY (id);


--
-- Name: callback_request callback_request_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.callback_request
    ADD CONSTRAINT callback_request_pkey PRIMARY KEY (id);


--
-- Name: connection connection_conn_id_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.connection
    ADD CONSTRAINT connection_conn_id_uq UNIQUE (conn_id);


--
-- Name: connection connection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.connection
    ADD CONSTRAINT connection_pkey PRIMARY KEY (id);


--
-- Name: dag_bundle dag_bundle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_bundle
    ADD CONSTRAINT dag_bundle_pkey PRIMARY KEY (name);


--
-- Name: dag_code dag_code_dag_version_id_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_code
    ADD CONSTRAINT dag_code_dag_version_id_uq UNIQUE (dag_version_id);


--
-- Name: dag_code dag_code_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_code
    ADD CONSTRAINT dag_code_pkey PRIMARY KEY (id);


--
-- Name: dag_version dag_id_v_name_v_number_unique_constraint; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_version
    ADD CONSTRAINT dag_id_v_name_v_number_unique_constraint UNIQUE (dag_id, version_number);


--
-- Name: dag_owner_attributes dag_owner_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_owner_attributes
    ADD CONSTRAINT dag_owner_attributes_pkey PRIMARY KEY (dag_id, owner);


--
-- Name: dag dag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag
    ADD CONSTRAINT dag_pkey PRIMARY KEY (dag_id);


--
-- Name: dag_priority_parsing_request dag_priority_parsing_request_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_priority_parsing_request
    ADD CONSTRAINT dag_priority_parsing_request_pkey PRIMARY KEY (id);


--
-- Name: dag_run dag_run_dag_id_logical_date_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_run
    ADD CONSTRAINT dag_run_dag_id_logical_date_key UNIQUE (dag_id, logical_date);


--
-- Name: dag_run dag_run_dag_id_run_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_run
    ADD CONSTRAINT dag_run_dag_id_run_id_key UNIQUE (dag_id, run_id);


--
-- Name: dag_run_note dag_run_note_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_run_note
    ADD CONSTRAINT dag_run_note_pkey PRIMARY KEY (dag_run_id);


--
-- Name: dag_run dag_run_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_run
    ADD CONSTRAINT dag_run_pkey PRIMARY KEY (id);


--
-- Name: dag_tag dag_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_tag
    ADD CONSTRAINT dag_tag_pkey PRIMARY KEY (name, dag_id);


--
-- Name: dag_version dag_version_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_version
    ADD CONSTRAINT dag_version_pkey PRIMARY KEY (id);


--
-- Name: dag_warning dag_warning_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_warning
    ADD CONSTRAINT dag_warning_pkey PRIMARY KEY (dag_id, warning_type);


--
-- Name: dagrun_asset_event dagrun_asset_event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dagrun_asset_event
    ADD CONSTRAINT dagrun_asset_event_pkey PRIMARY KEY (dag_run_id, event_id);


--
-- Name: deadline deadline_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deadline
    ADD CONSTRAINT deadline_pkey PRIMARY KEY (id);


--
-- Name: dag_schedule_asset_alias_reference dsaar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_schedule_asset_alias_reference
    ADD CONSTRAINT dsaar_pkey PRIMARY KEY (alias_id, dag_id);


--
-- Name: dag_schedule_asset_name_reference dsanr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_schedule_asset_name_reference
    ADD CONSTRAINT dsanr_pkey PRIMARY KEY (name, dag_id);


--
-- Name: dag_schedule_asset_reference dsar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_schedule_asset_reference
    ADD CONSTRAINT dsar_pkey PRIMARY KEY (asset_id, dag_id);


--
-- Name: dag_schedule_asset_uri_reference dsaur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_schedule_asset_uri_reference
    ADD CONSTRAINT dsaur_pkey PRIMARY KEY (uri, dag_id);


--
-- Name: import_error import_error_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.import_error
    ADD CONSTRAINT import_error_pkey PRIMARY KEY (id);


--
-- Name: backfill_dag_run ix_bdr_backfill_id_dag_run_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backfill_dag_run
    ADD CONSTRAINT ix_bdr_backfill_id_dag_run_id UNIQUE (backfill_id, dag_run_id);


--
-- Name: job job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job
    ADD CONSTRAINT job_pkey PRIMARY KEY (id);


--
-- Name: log log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log
    ADD CONSTRAINT log_pkey PRIMARY KEY (id);


--
-- Name: log_template log_template_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_template
    ADD CONSTRAINT log_template_pkey PRIMARY KEY (id);


--
-- Name: rendered_task_instance_fields rendered_task_instance_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rendered_task_instance_fields
    ADD CONSTRAINT rendered_task_instance_fields_pkey PRIMARY KEY (dag_id, task_id, run_id, map_index);


--
-- Name: serialized_dag serialized_dag_dag_version_id_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serialized_dag
    ADD CONSTRAINT serialized_dag_dag_version_id_uq UNIQUE (dag_version_id);


--
-- Name: serialized_dag serialized_dag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serialized_dag
    ADD CONSTRAINT serialized_dag_pkey PRIMARY KEY (id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (id);


--
-- Name: session session_session_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_session_id_key UNIQUE (session_id);


--
-- Name: slot_pool slot_pool_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.slot_pool
    ADD CONSTRAINT slot_pool_pkey PRIMARY KEY (id);


--
-- Name: slot_pool slot_pool_pool_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.slot_pool
    ADD CONSTRAINT slot_pool_pool_uq UNIQUE (pool);


--
-- Name: task_instance task_instance_composite_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_instance
    ADD CONSTRAINT task_instance_composite_key UNIQUE (dag_id, task_id, run_id, map_index);


--
-- Name: task_instance_history task_instance_history_dtrt_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_instance_history
    ADD CONSTRAINT task_instance_history_dtrt_uq UNIQUE (dag_id, task_id, run_id, map_index, try_number);


--
-- Name: task_instance_history task_instance_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_instance_history
    ADD CONSTRAINT task_instance_history_pkey PRIMARY KEY (task_instance_id);


--
-- Name: task_instance_note task_instance_note_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_instance_note
    ADD CONSTRAINT task_instance_note_pkey PRIMARY KEY (ti_id);


--
-- Name: task_instance task_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_instance
    ADD CONSTRAINT task_instance_pkey PRIMARY KEY (id);


--
-- Name: task_map task_map_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_map
    ADD CONSTRAINT task_map_pkey PRIMARY KEY (dag_id, task_id, run_id, map_index);


--
-- Name: task_reschedule task_reschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_reschedule
    ADD CONSTRAINT task_reschedule_pkey PRIMARY KEY (id);


--
-- Name: task_outlet_asset_reference toar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_outlet_asset_reference
    ADD CONSTRAINT toar_pkey PRIMARY KEY (asset_id, dag_id, task_id);


--
-- Name: trigger trigger_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trigger
    ADD CONSTRAINT trigger_pkey PRIMARY KEY (id);


--
-- Name: variable variable_key_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variable
    ADD CONSTRAINT variable_key_uq UNIQUE (key);


--
-- Name: variable variable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variable
    ADD CONSTRAINT variable_pkey PRIMARY KEY (id);


--
-- Name: xcom xcom_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xcom
    ADD CONSTRAINT xcom_pkey PRIMARY KEY (dag_run_id, task_id, map_index, key);


--
-- Name: dag_id_state; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dag_id_state ON public.dag_run USING btree (dag_id, state);


--
-- Name: deadline_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX deadline_idx ON public.deadline USING btree (deadline);


--
-- Name: idx_ab_register_user_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_ab_register_user_username ON public.ab_register_user USING btree (lower((username)::text));


--
-- Name: idx_ab_user_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_ab_user_username ON public.ab_user USING btree (lower((username)::text));


--
-- Name: idx_asset_active_name_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_asset_active_name_unique ON public.asset_active USING btree (name);


--
-- Name: idx_asset_active_uri_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_asset_active_uri_unique ON public.asset_active USING btree (uri);


--
-- Name: idx_asset_alias_asset_alias_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_asset_alias_asset_alias_id ON public.asset_alias_asset USING btree (alias_id);


--
-- Name: idx_asset_alias_asset_asset_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_asset_alias_asset_asset_id ON public.asset_alias_asset USING btree (asset_id);


--
-- Name: idx_asset_alias_asset_event_alias_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_asset_alias_asset_event_alias_id ON public.asset_alias_asset_event USING btree (alias_id);


--
-- Name: idx_asset_alias_asset_event_event_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_asset_alias_asset_event_event_id ON public.asset_alias_asset_event USING btree (event_id);


--
-- Name: idx_asset_alias_name_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_asset_alias_name_unique ON public.asset_alias USING btree (name);


--
-- Name: idx_asset_dag_run_queue_target_dag_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_asset_dag_run_queue_target_dag_id ON public.asset_dag_run_queue USING btree (target_dag_id);


--
-- Name: idx_asset_id_timestamp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_asset_id_timestamp ON public.asset_event USING btree (asset_id, "timestamp");


--
-- Name: idx_asset_name_uri_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_asset_name_uri_unique ON public.asset USING btree (name, uri);


--
-- Name: idx_asset_trigger_asset_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_asset_trigger_asset_id ON public.asset_trigger USING btree (asset_id);


--
-- Name: idx_asset_trigger_trigger_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_asset_trigger_trigger_id ON public.asset_trigger USING btree (trigger_id);


--
-- Name: idx_dag_run_dag_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dag_run_dag_id ON public.dag_run USING btree (dag_id);


--
-- Name: idx_dag_run_queued_dags; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dag_run_queued_dags ON public.dag_run USING btree (state, dag_id) WHERE ((state)::text = 'queued'::text);


--
-- Name: idx_dag_run_run_after; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dag_run_run_after ON public.dag_run USING btree (run_after);


--
-- Name: idx_dag_run_running_dags; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dag_run_running_dags ON public.dag_run USING btree (state, dag_id) WHERE ((state)::text = 'running'::text);


--
-- Name: idx_dag_schedule_asset_alias_reference_dag_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dag_schedule_asset_alias_reference_dag_id ON public.dag_schedule_asset_alias_reference USING btree (dag_id);


--
-- Name: idx_dag_schedule_asset_name_reference_dag_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dag_schedule_asset_name_reference_dag_id ON public.dag_schedule_asset_name_reference USING btree (dag_id);


--
-- Name: idx_dag_schedule_asset_reference_dag_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dag_schedule_asset_reference_dag_id ON public.dag_schedule_asset_reference USING btree (dag_id);


--
-- Name: idx_dag_schedule_asset_uri_reference_dag_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dag_schedule_asset_uri_reference_dag_id ON public.dag_schedule_asset_uri_reference USING btree (dag_id);


--
-- Name: idx_dag_tag_dag_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dag_tag_dag_id ON public.dag_tag USING btree (dag_id);


--
-- Name: idx_dag_warning_dag_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dag_warning_dag_id ON public.dag_warning USING btree (dag_id);


--
-- Name: idx_dagrun_asset_events_dag_run_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dagrun_asset_events_dag_run_id ON public.dagrun_asset_event USING btree (dag_run_id);


--
-- Name: idx_dagrun_asset_events_event_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dagrun_asset_events_event_id ON public.dagrun_asset_event USING btree (event_id);


--
-- Name: idx_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_id ON public.ab_group_role USING btree (group_id);


--
-- Name: idx_group_role_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_id ON public.ab_group_role USING btree (role_id);


--
-- Name: idx_job_dag_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_dag_id ON public.job USING btree (dag_id);


--
-- Name: idx_job_state_heartbeat; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_state_heartbeat ON public.job USING btree (state, latest_heartbeat);


--
-- Name: idx_log_dttm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_log_dttm ON public.log USING btree (dttm);


--
-- Name: idx_log_event; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_log_event ON public.log USING btree (event);


--
-- Name: idx_log_task_instance; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_log_task_instance ON public.log USING btree (dag_id, task_id, run_id, map_index, try_number);


--
-- Name: idx_next_dagrun_create_after; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_next_dagrun_create_after ON public.dag USING btree (next_dagrun_create_after);


--
-- Name: idx_task_outlet_asset_reference_dag_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_task_outlet_asset_reference_dag_id ON public.task_outlet_asset_reference USING btree (dag_id);


--
-- Name: idx_tih_dag_run; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tih_dag_run ON public.task_instance_history USING btree (dag_id, run_id);


--
-- Name: idx_user_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_id ON public.ab_user_group USING btree (group_id);


--
-- Name: idx_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_id ON public.ab_user_group USING btree (user_id);


--
-- Name: idx_xcom_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_xcom_key ON public.xcom USING btree (key);


--
-- Name: idx_xcom_task_instance; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_xcom_task_instance ON public.xcom USING btree (dag_id, task_id, run_id, map_index);


--
-- Name: job_type_heart; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX job_type_heart ON public.job USING btree (job_type, latest_heartbeat);


--
-- Name: ti_dag_run; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ti_dag_run ON public.task_instance USING btree (dag_id, run_id);


--
-- Name: ti_dag_state; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ti_dag_state ON public.task_instance USING btree (dag_id, state);


--
-- Name: ti_heartbeat; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ti_heartbeat ON public.task_instance USING btree (last_heartbeat_at);


--
-- Name: ti_pool; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ti_pool ON public.task_instance USING btree (pool, state, priority_weight);


--
-- Name: ti_state; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ti_state ON public.task_instance USING btree (state);


--
-- Name: ti_state_lkp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ti_state_lkp ON public.task_instance USING btree (dag_id, task_id, run_id, state);


--
-- Name: ti_trigger_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ti_trigger_id ON public.task_instance USING btree (trigger_id);


--
-- Name: ab_group_role ab_group_role_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_group_role
    ADD CONSTRAINT ab_group_role_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.ab_group(id) ON DELETE CASCADE;


--
-- Name: ab_group_role ab_group_role_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_group_role
    ADD CONSTRAINT ab_group_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.ab_role(id) ON DELETE CASCADE;


--
-- Name: ab_permission_view ab_permission_view_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_permission_view
    ADD CONSTRAINT ab_permission_view_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.ab_permission(id);


--
-- Name: ab_permission_view_role ab_permission_view_role_permission_view_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_permission_view_role
    ADD CONSTRAINT ab_permission_view_role_permission_view_id_fkey FOREIGN KEY (permission_view_id) REFERENCES public.ab_permission_view(id) ON DELETE CASCADE;


--
-- Name: ab_permission_view_role ab_permission_view_role_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_permission_view_role
    ADD CONSTRAINT ab_permission_view_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.ab_role(id) ON DELETE CASCADE;


--
-- Name: ab_permission_view ab_permission_view_view_menu_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_permission_view
    ADD CONSTRAINT ab_permission_view_view_menu_id_fkey FOREIGN KEY (view_menu_id) REFERENCES public.ab_view_menu(id);


--
-- Name: ab_user ab_user_changed_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user
    ADD CONSTRAINT ab_user_changed_by_fk_fkey FOREIGN KEY (changed_by_fk) REFERENCES public.ab_user(id);


--
-- Name: ab_user ab_user_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user
    ADD CONSTRAINT ab_user_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: ab_user_group ab_user_group_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user_group
    ADD CONSTRAINT ab_user_group_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.ab_group(id) ON DELETE CASCADE;


--
-- Name: ab_user_group ab_user_group_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user_group
    ADD CONSTRAINT ab_user_group_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.ab_user(id) ON DELETE CASCADE;


--
-- Name: ab_user_role ab_user_role_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user_role
    ADD CONSTRAINT ab_user_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.ab_role(id) ON DELETE CASCADE;


--
-- Name: ab_user_role ab_user_role_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_user_role
    ADD CONSTRAINT ab_user_role_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.ab_user(id) ON DELETE CASCADE;


--
-- Name: asset_dag_run_queue adrq_asset_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_dag_run_queue
    ADD CONSTRAINT adrq_asset_fkey FOREIGN KEY (asset_id) REFERENCES public.asset(id) ON DELETE CASCADE;


--
-- Name: asset_dag_run_queue adrq_dag_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_dag_run_queue
    ADD CONSTRAINT adrq_dag_fkey FOREIGN KEY (target_dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: asset_active asset_active_asset_name_uri_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_active
    ADD CONSTRAINT asset_active_asset_name_uri_fkey FOREIGN KEY (name, uri) REFERENCES public.asset(name, uri) ON DELETE CASCADE;


--
-- Name: asset_alias_asset asset_alias_asset_alias_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_alias_asset
    ADD CONSTRAINT asset_alias_asset_alias_id_fkey FOREIGN KEY (alias_id) REFERENCES public.asset_alias(id) ON DELETE CASCADE;


--
-- Name: asset_alias_asset asset_alias_asset_asset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_alias_asset
    ADD CONSTRAINT asset_alias_asset_asset_id_fkey FOREIGN KEY (asset_id) REFERENCES public.asset(id) ON DELETE CASCADE;


--
-- Name: asset_alias_asset_event asset_alias_asset_event_alias_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_alias_asset_event
    ADD CONSTRAINT asset_alias_asset_event_alias_id_fkey FOREIGN KEY (alias_id) REFERENCES public.asset_alias(id) ON DELETE CASCADE;


--
-- Name: asset_alias_asset_event asset_alias_asset_event_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_alias_asset_event
    ADD CONSTRAINT asset_alias_asset_event_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.asset_event(id) ON DELETE CASCADE;


--
-- Name: asset_trigger asset_trigger_asset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_trigger
    ADD CONSTRAINT asset_trigger_asset_id_fkey FOREIGN KEY (asset_id) REFERENCES public.asset(id) ON DELETE CASCADE;


--
-- Name: asset_trigger asset_trigger_trigger_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_trigger
    ADD CONSTRAINT asset_trigger_trigger_id_fkey FOREIGN KEY (trigger_id) REFERENCES public.trigger(id) ON DELETE CASCADE;


--
-- Name: backfill_dag_run bdr_backfill_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backfill_dag_run
    ADD CONSTRAINT bdr_backfill_fkey FOREIGN KEY (backfill_id) REFERENCES public.backfill(id) ON DELETE CASCADE;


--
-- Name: backfill_dag_run bdr_dag_run_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backfill_dag_run
    ADD CONSTRAINT bdr_dag_run_fkey FOREIGN KEY (dag_run_id) REFERENCES public.dag_run(id) ON DELETE SET NULL;


--
-- Name: dag_run created_dag_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_run
    ADD CONSTRAINT created_dag_version_id_fkey FOREIGN KEY (created_dag_version_id) REFERENCES public.dag_version(id) ON DELETE SET NULL;


--
-- Name: dag_owner_attributes dag.dag_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_owner_attributes
    ADD CONSTRAINT "dag.dag_id" FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: dag dag_bundle_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag
    ADD CONSTRAINT dag_bundle_name_fkey FOREIGN KEY (bundle_name) REFERENCES public.dag_bundle(name);


--
-- Name: dag_code dag_code_dag_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_code
    ADD CONSTRAINT dag_code_dag_version_id_fkey FOREIGN KEY (dag_version_id) REFERENCES public.dag_version(id) ON DELETE CASCADE;


--
-- Name: dag_run dag_run_backfill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_run
    ADD CONSTRAINT dag_run_backfill_id_fkey FOREIGN KEY (backfill_id) REFERENCES public.backfill(id);


--
-- Name: dag_run_note dag_run_note_dr_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_run_note
    ADD CONSTRAINT dag_run_note_dr_fkey FOREIGN KEY (dag_run_id) REFERENCES public.dag_run(id) ON DELETE CASCADE;


--
-- Name: dag_tag dag_tag_dag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_tag
    ADD CONSTRAINT dag_tag_dag_id_fkey FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: dag_version dag_version_dag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_version
    ADD CONSTRAINT dag_version_dag_id_fkey FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: dagrun_asset_event dagrun_asset_event_dag_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dagrun_asset_event
    ADD CONSTRAINT dagrun_asset_event_dag_run_id_fkey FOREIGN KEY (dag_run_id) REFERENCES public.dag_run(id) ON DELETE CASCADE;


--
-- Name: dagrun_asset_event dagrun_asset_event_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dagrun_asset_event
    ADD CONSTRAINT dagrun_asset_event_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.asset_event(id) ON DELETE CASCADE;


--
-- Name: dag_warning dcw_dag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_warning
    ADD CONSTRAINT dcw_dag_id_fkey FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: deadline deadline_dag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deadline
    ADD CONSTRAINT deadline_dag_id_fkey FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: deadline deadline_dagrun_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deadline
    ADD CONSTRAINT deadline_dagrun_id_fkey FOREIGN KEY (dagrun_id) REFERENCES public.dag_run(id) ON DELETE CASCADE;


--
-- Name: dag_schedule_asset_alias_reference dsaar_asset_alias_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_schedule_asset_alias_reference
    ADD CONSTRAINT dsaar_asset_alias_fkey FOREIGN KEY (alias_id) REFERENCES public.asset_alias(id) ON DELETE CASCADE;


--
-- Name: dag_schedule_asset_alias_reference dsaar_dag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_schedule_asset_alias_reference
    ADD CONSTRAINT dsaar_dag_id_fkey FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: dag_schedule_asset_name_reference dsanr_dag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_schedule_asset_name_reference
    ADD CONSTRAINT dsanr_dag_id_fkey FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: dag_schedule_asset_reference dsar_asset_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_schedule_asset_reference
    ADD CONSTRAINT dsar_asset_fkey FOREIGN KEY (asset_id) REFERENCES public.asset(id) ON DELETE CASCADE;


--
-- Name: dag_schedule_asset_reference dsar_dag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_schedule_asset_reference
    ADD CONSTRAINT dsar_dag_id_fkey FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: dag_schedule_asset_uri_reference dsaur_dag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_schedule_asset_uri_reference
    ADD CONSTRAINT dsaur_dag_id_fkey FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: rendered_task_instance_fields rtif_ti_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rendered_task_instance_fields
    ADD CONSTRAINT rtif_ti_fkey FOREIGN KEY (dag_id, task_id, run_id, map_index) REFERENCES public.task_instance(dag_id, task_id, run_id, map_index) ON DELETE CASCADE;


--
-- Name: serialized_dag serialized_dag_dag_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serialized_dag
    ADD CONSTRAINT serialized_dag_dag_version_id_fkey FOREIGN KEY (dag_version_id) REFERENCES public.dag_version(id) ON DELETE CASCADE;


--
-- Name: task_instance task_instance_dag_run_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_instance
    ADD CONSTRAINT task_instance_dag_run_fkey FOREIGN KEY (dag_id, run_id) REFERENCES public.dag_run(dag_id, run_id) ON DELETE CASCADE;


--
-- Name: task_instance task_instance_dag_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_instance
    ADD CONSTRAINT task_instance_dag_version_id_fkey FOREIGN KEY (dag_version_id) REFERENCES public.dag_version(id) ON DELETE CASCADE;


--
-- Name: task_instance_history task_instance_history_ti_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_instance_history
    ADD CONSTRAINT task_instance_history_ti_fkey FOREIGN KEY (dag_id, task_id, run_id, map_index) REFERENCES public.task_instance(dag_id, task_id, run_id, map_index) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dag_run task_instance_log_template_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dag_run
    ADD CONSTRAINT task_instance_log_template_id_fkey FOREIGN KEY (log_template_id) REFERENCES public.log_template(id);


--
-- Name: task_instance_note task_instance_note_ti_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_instance_note
    ADD CONSTRAINT task_instance_note_ti_fkey FOREIGN KEY (ti_id) REFERENCES public.task_instance(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: task_instance task_instance_trigger_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_instance
    ADD CONSTRAINT task_instance_trigger_id_fkey FOREIGN KEY (trigger_id) REFERENCES public.trigger(id) ON DELETE CASCADE;


--
-- Name: task_map task_map_task_instance_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_map
    ADD CONSTRAINT task_map_task_instance_fkey FOREIGN KEY (dag_id, task_id, run_id, map_index) REFERENCES public.task_instance(dag_id, task_id, run_id, map_index) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: task_reschedule task_reschedule_ti_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_reschedule
    ADD CONSTRAINT task_reschedule_ti_fkey FOREIGN KEY (ti_id) REFERENCES public.task_instance(id) ON DELETE CASCADE;


--
-- Name: task_outlet_asset_reference toar_asset_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_outlet_asset_reference
    ADD CONSTRAINT toar_asset_fkey FOREIGN KEY (asset_id) REFERENCES public.asset(id) ON DELETE CASCADE;


--
-- Name: task_outlet_asset_reference toar_dag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_outlet_asset_reference
    ADD CONSTRAINT toar_dag_id_fkey FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: xcom xcom_task_instance_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xcom
    ADD CONSTRAINT xcom_task_instance_fkey FOREIGN KEY (dag_id, task_id, run_id, map_index) REFERENCES public.task_instance(dag_id, task_id, run_id, map_index) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict 1GUACJkFGE6lK6MOOReC3FBIW464Wmt6Ig5G96FxghXT3owKlsnv8I7v9HT5mca

--
-- Database "dotodo" dump
--

--
-- PostgreSQL database dump
--

\restrict vBSFPUEMzXZh4hoUyKzZkrRjvrQgSHOFkGnel7xJCYPpTwPoiiyDXey4aKRjuhE

-- Dumped from database version 15.14 (Debian 15.14-1.pgdg13+1)
-- Dumped by pg_dump version 15.14 (Debian 15.14-1.pgdg13+1)

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
-- Name: dotodo; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE dotodo WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE dotodo OWNER TO postgres;

\unrestrict vBSFPUEMzXZh4hoUyKzZkrRjvrQgSHOFkGnel7xJCYPpTwPoiiyDXey4aKRjuhE
\connect dotodo
\restrict vBSFPUEMzXZh4hoUyKzZkrRjvrQgSHOFkGnel7xJCYPpTwPoiiyDXey4aKRjuhE

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
-- PostgreSQL database dump complete
--

\unrestrict vBSFPUEMzXZh4hoUyKzZkrRjvrQgSHOFkGnel7xJCYPpTwPoiiyDXey4aKRjuhE

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

\restrict gU7h93qHqkwxlMn2aqXy7NzQJM3BRLX0s0h3vq0gcIwPhZhynBfai2j0N06l02k

-- Dumped from database version 15.14 (Debian 15.14-1.pgdg13+1)
-- Dumped by pg_dump version 15.14 (Debian 15.14-1.pgdg13+1)

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
-- PostgreSQL database dump complete
--

\unrestrict gU7h93qHqkwxlMn2aqXy7NzQJM3BRLX0s0h3vq0gcIwPhZhynBfai2j0N06l02k

--
-- PostgreSQL database cluster dump complete
--

