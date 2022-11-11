drop table if exists dat_redirects cascade;

create table dat_redirects (
    txt_request text,
    txt_response text
);

comment on table dat_redirects is 'rdr';