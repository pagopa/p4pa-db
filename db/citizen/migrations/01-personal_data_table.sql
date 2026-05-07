CREATE SEQUENCE IF NOT EXISTS  public.personal_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE IF NOT EXISTS public.personal_data (
    id bigint PRIMARY KEY default nextval('personal_data_id_seq'),
    type character varying(255) NOT NULL,
    data bytea NOT NULL,
    create_date timestamp without time zone NOT NULL default now()
);