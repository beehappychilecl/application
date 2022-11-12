drop function if exists core_get_action_unavailable;

create or replace function core_get_action_unavailable ()
returns numeric as $body$
begin

    return 9020;

end;
$body$ language plpgsql;