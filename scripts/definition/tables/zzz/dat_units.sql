drop trigger if exists trg_before_update_units on dat_units cascade;
drop trigger if exists trg_before_insert_units on dat_units cascade;
drop function if exists action_before_update_units cascade;
drop function if exists action_before_insert_units cascade;
drop sequence if exists seq_units cascade;
drop table if exists aud_units cascade;
drop table if exists dat_units cascade;

create table if not exists dat_units (
    idf_organization numeric,
    idf_unit         numeric,
    num_aliquot      numeric,
    txt_block        text,
    txt_floor        text,
    txt_unit         text,
    constraint dat_units_pk primary key (idf_unit),
    constraint dat_units_fk1 foreign key (idf_organization) references dat_organizations (idf_organization)
) inherits (sys_default);

comment on table dat_units is 'unt';

create table if not exists aud_units
as table dat_units;

alter table aud_units
add constraint aud_units_fk0 foreign key (idf_unit) references dat_units (idf_unit),
add constraint aud_units_fk1 foreign key (idf_organization) references dat_organizations (idf_organization);

create index if not exists aud_units_ix0 on aud_units (idf_unit);

create sequence if not exists seq_units
start with 1 increment by 1;

create or replace function action_before_insert_units ()
returns trigger as $body$
begin

    new.sys_timestamp = core_get_timestamp_value ();
    new.sys_status = true;
    new.sys_version = 0;

    return new;

end;
$body$ language plpgsql;

create trigger trg_before_insert_units
before insert on dat_units
for each row execute procedure action_before_insert_units ();

create or replace function action_before_update_units ()
returns trigger as $body$
begin

    insert into aud_units (
        sys_status,
        sys_timestamp,
        sys_user,
        sys_version,
        idf_organization,
        idf_unit,
        txt_block,
        txt_floor,
        txt_unit
    ) values (
        old.sys_status,
        old.sys_timestamp,
        old.sys_user,
        old.sys_version,
        old.idf_organization,
        old.idf_unit,
        old.txt_block,
        old.txt_floor,
        old.txt_unit
    );

    new.sys_timestamp = core_get_timestamp_value ();
    new.sys_version = old.sys_version + 1;

    return new;

end;
$body$ language plpgsql;

create trigger trg_before_update_units
before update on dat_units
for each row execute procedure action_before_update_units ();