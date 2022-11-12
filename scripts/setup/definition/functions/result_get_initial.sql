drop function if exists result_get_initial;

create or replace function result_get_initial (
    in in_jsn_object json
)
returns json as $body$
declare
    var_jsn_incoming json;
    var_jsn_status json;
    var_obj_timestamp json;
    var_tim_timestamp timestamp;
begin

    var_tim_timestamp = core_get_timestamp_value ();

    var_jsn_incoming = core_get_json_empty (in_jsn_object);

    if (var_jsn_incoming :: text <> '{}') then

        var_jsn_incoming = json_build_object ('incoming', in_jsn_object);

    end if;

    var_obj_timestamp = core_get_timestamp_object (var_tim_timestamp);

    var_jsn_status = core_set_json_text (var_jsn_status, 'tim_date', var_obj_timestamp ->> 'tim_date');
    var_jsn_status = core_set_json_text (var_jsn_status, 'tim_datetime', var_obj_timestamp ->> 'tim_datetime');
    var_jsn_status = core_set_json_text (var_jsn_status, 'tim_time', var_obj_timestamp ->> 'tim_time');

    var_jsn_status = json_build_object ('status', var_jsn_status);

    return var_jsn_incoming :: jsonb || var_jsn_status :: jsonb;

end;
$body$ language plpgsql;