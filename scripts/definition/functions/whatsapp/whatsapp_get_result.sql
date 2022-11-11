drop function if exists whatsapp_get_result;

create or replace function whatsapp_get_result (
    in in_obj_array json
)
returns json as $body$
declare
    var_obj_array json;
begin

    var_obj_array = json_build_object ('sys_result', 0, 'sys_message', 'W');

    in_obj_array = core_set_json_json (in_obj_array, 'whatsapp', var_obj_array);

    return in_obj_array;

end;
$body$ language plpgsql;