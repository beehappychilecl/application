drop function if exists core_set_json_array;

create or replace function core_set_json_array (
    in in_jsn_object json,
    in in_txt_key text,
    in in_obj_value text []
)
returns json as $body$
declare
    var_arr_node text [];
    var_jsn_object json;
    var_num_length numeric;
begin

    var_jsn_object = json_build_object (in_txt_key, in_obj_value);

    in_jsn_object = core_get_json_empty (in_jsn_object);

    var_arr_node = core_get_json_array (var_jsn_object, in_txt_key);

    var_num_length = array_length (var_arr_node, 1);

    if (var_num_length is null) then

        var_jsn_object = json_build_object (in_txt_key, '{}' :: text []);

        return in_jsn_object :: jsonb || var_jsn_object :: jsonb;

    end if;

    return in_jsn_object :: jsonb || var_jsn_object :: jsonb;

end;
$body$ language plpgsql;