drop trigger if exists trg_before_update_workshifts on dat_workshifts cascade;
drop trigger if exists trg_before_insert_workshifts on dat_workshifts cascade;
drop function if exists action_before_update_workshifts cascade;
drop function if exists action_before_insert_workshifts cascade;
drop sequence if exists seq_workshifts cascade;
drop table if exists aud_workshifts cascade;
drop table if exists dat_workshifts cascade;

create table if not exists dat_workshifts (
    idf_organization numeric,
    idf_workshift    numeric,
    num_day          numeric,
    tim_final        time,
    tim_initial      time,
    constraint dat_workshifts_pk primary key (idf_workshift),
    constraint dat_workshifts_fk1 foreign key (idf_organization) references dat_organizations (idf_organization)
) inherits (sys_default);

comment on table dat_workshifts is 'wrk';

create table if not exists aud_workshifts
as table dat_workshifts;

alter table aud_workshifts
add constraint aud_workshifts_fk0 foreign key (idf_workshift) references dat_workshifts (idf_workshift),
add constraint aud_workshifts_fk1 foreign key (idf_organization) references dat_organizations (idf_organization);

create index if not exists aud_workshifts_ix0 on aud_workshifts (idf_workshift);

create sequence if not exists seq_workshifts
start with 1 increment by 1;

create or replace function action_before_insert_workshifts ()
returns trigger as $body$
begin

    new.sys_timestamp = core_get_timestamp_value ();
    new.sys_status = true;
    new.sys_version = 0;

    return new;

end;
$body$ language plpgsql;

create trigger trg_before_insert_workshifts
before insert on dat_workshifts
for each row execute procedure action_before_insert_workshifts ();

create or replace function action_before_update_workshifts ()
returns trigger as $body$
begin

    insert into aud_workshifts (
        sys_status,
        sys_timestamp,
        sys_user,
        sys_version,
        idf_organization,
        idf_workshift,
        tim_day,
        tim_final,
        tim_initial
    ) values (
        old.sys_status,
        old.sys_timestamp,
        old.sys_user,
        old.sys_version,
        old.idf_organization,
        old.idf_workshift,
        old.tim_day,
        old.tim_final,
        old.tim_initial
    );

    new.sys_timestamp = core_get_timestamp_value ();
    new.sys_version = old.sys_version + 1;

    return new;

end;
$body$ language plpgsql;

create trigger trg_before_update_workshifts
before update on dat_workshifts
for each row execute procedure action_before_update_workshifts ();