drop function if exists core_get_action_unregistered;

create or replace function core_get_action_unregistered ()
returns numeric as $body$
begin

    return 1060;

end;
$body$ language plpgsql;