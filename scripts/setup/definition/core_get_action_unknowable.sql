drop function if exists core_get_action_unknowable;

create or replace function core_get_action_unknowable ()
returns numeric as $body$
begin

    return 91;

end;
$body$ language plpgsql;