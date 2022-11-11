drop table if exists dat_reports cascade;

create table if not exists dat_reports (
    uid_report uuid,
    txt_report text,
    idf_view   numeric,
    tim_report timestamp
);

comment on table dat_reports is 'rep';