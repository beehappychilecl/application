drop table if exists dat_views cascade;

create table if not exists dat_views (
    idf_view numeric,
    txt_view text
);

comment on table dat_views is 'vie';