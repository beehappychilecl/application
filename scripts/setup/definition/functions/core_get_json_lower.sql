drop function if exists core_get_json_lower;

create or replace function core_get_json_lower (
    in in_jsn_object json
)
returns text as $body$
declare
    var_jsn_object json;
begin

    select
        jsonb_object_agg (lower (key), value)
    from
        jsonb_each (in_jsn_object :: jsonb)
    into
        var_jsn_object;

    return var_jsn_object;

end;
$body$ language plpgsql;