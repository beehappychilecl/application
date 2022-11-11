drop trigger if exists trg_before_update_issues on dat_issues cascade;
drop trigger if exists trg_before_insert_issues on dat_issues cascade;
drop function if exists action_before_update_issues cascade;
drop function if exists action_before_insert_issues cascade;
drop sequence if exists seq_issues cascade;
drop table if exists aud_issues cascade;
drop table if exists dat_issues cascade;

create table if not exists dat_issues (
    idf_issue        numeric,
    idf_organization numeric,
    idf_user         numeric,
    num_phone        numeric,
    txt_issue        text,
    txt_status       text,
    txt_summary      text,
    txt_type         text,
    constraint dat_issues_pk primary key (idf_issue),
    constraint dat_issues_fk1 foreign key (idf_organization) references dat_organizations (idf_organization),
    constraint dat_issues_fk2 foreign key (idf_user) references dat_users (idf_user)
) inherits (sys_default);

comment on table dat_issues is 'iss';

create table if not exists aud_issues
as table dat_issues;

alter table aud_issues
add constraint dat_issues_fk0 foreign key (idf_issue) references dat_issues (idf_issue),
add constraint dat_issues_fk1 foreign key (idf_organization) references dat_organizations (idf_organization),
add constraint dat_issues_fk2 foreign key (idf_user) references dat_users (idf_user);

create index if not exists aud_issues_ix0 on aud_issues (idf_issue);

create sequence if not exists seq_issues
start with 1 increment by 1;

create or replace function action_before_insert_issues ()
returns trigger as $body$
begin

    new.sys_timestamp = core_get_timestamp_value ();
    new.sys_status = true;
    new.sys_version = 0;

    return new;

end;
$body$ language plpgsql;

create trigger trg_before_insert_issues
before insert on dat_issues
for each row execute procedure action_before_insert_issues ();

create or replace function action_before_update_issues ()
returns trigger as $body$
begin

    insert into aud_issues (
        sys_status,
        sys_timestamp,
        sys_user,
        sys_version,
        idf_issue,
        idf_organization,
        idf_user,
        num_phone,
        txt_issue,
        txt_status,
        txt_summary,
        txt_type
    ) values (
        old.sys_status,
        old.sys_timestamp,
        old.sys_user,
        old.sys_version,
        old.idf_issue,
        old.idf_organization,
        old.idf_user,
        old.num_phone,
        old.txt_issue,
        old.txt_status,
        old.txt_summary,
        old.txt_type
    );

    new.sys_timestamp = core_get_timestamp_value ();
    new.sys_version = old.sys_version + 1;

    return new;

end;
$body$ language plpgsql;

create trigger trg_before_update_issues
before update on dat_issues
for each row execute procedure action_before_update_issues ();