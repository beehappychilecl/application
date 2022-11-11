drop table if exists dat_provinces cascade;

create table if not exists dat_provinces (
    idf_country  numeric,
    idf_province numeric,
    idf_region   numeric,
    txt_province text,
    constraint dat_provinces_pk primary key (idf_province),
    constraint dat_provinces_fk1 foreign key (idf_country) references dat_countries (idf_country),
    constraint dat_provinces_fk2 foreign key (idf_region) references dat_regions (idf_region)
);

comment on table dat_provinces is 'pvc';