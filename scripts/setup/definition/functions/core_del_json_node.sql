drop function if exists core_del_json_node;

create or replace function core_del_json_node (
    in in_jsn_object json,
    in in_txt_key text
)
returns json as $body$
begin

    return in_jsn_object :: jsonb - in_txt_key;

end;
$body$ language plpgsql;