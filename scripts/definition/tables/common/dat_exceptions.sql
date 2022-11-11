drop table if exists dat_exceptions cascade;

create table if not exists dat_exceptions (
    idf_exception numeric,
    txt_exception text,
    constraint dat_exceptions_pk primary key (idf_exception)
);

comment on table dat_exceptions is 'exc';