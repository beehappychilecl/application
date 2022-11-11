drop function if exists core_set_json_boolean;

create or replace function core_set_json_boolean (
    in in_jsn_object json,
    in in_txt_key text,
    in in_boo_value boolean
)
returns json as $body$
declare
    var_jsn_object json;
begin

    var_jsn_object = json_build_object (in_txt_key, in_boo_value);

    return in_jsn_object :: jsonb || var_jsn_object :: jsonb;

end ;
$body$ language plpgsql;