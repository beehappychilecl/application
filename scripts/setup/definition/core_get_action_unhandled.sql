drop function if exists core_get_action_unhandled;

create or replace function core_get_action_unhandled ()
returns numeric as $body$
begin

    return 1050;

end;
$body$ language plpgsql;