drop table if exists dat_dependencies cascade;

create table dat_dependencies (
    num_type     numeric,
    txt_artifact text,
    txt_group    text,
    txt_type     text,
    txt_version  text
);

comment on table dat_dependencies is 'dep';