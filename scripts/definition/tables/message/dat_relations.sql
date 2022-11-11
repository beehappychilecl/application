drop table if exists dat_relations cascade;

create table if not exists dat_relations (
    boo_dependency boolean,
    boo_registered boolean,
    idf_intention  numeric,
    txt_function   text
);

comment on table dat_relations is 'rel';