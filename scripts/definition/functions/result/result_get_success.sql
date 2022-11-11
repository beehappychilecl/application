drop function if exists result_get_success;

create or replace function result_get_success (
    in in_jsn_object json
)
returns json as $body$
declare
    var_jsn_incoming json;
    var_jsn_outgoing json;
    var_jsn_status json;
    var_obj_timestamp json;
    var_tim_elapsed text;
    var_tim_timestamp timestamp;
begin

    var_tim_timestamp = core_get_timestamp_value ();

    var_obj_timestamp = core_get_timestamp_object (var_tim_timestamp);

    var_jsn_incoming = core_get_json_empty ((in_jsn_object ->> 'incoming') :: json);

    if (var_jsn_incoming :: text <> '{}') then

        var_jsn_incoming = json_build_object ('incoming', var_jsn_incoming);

    end if;

    var_jsn_outgoing = core_get_json_empty ((in_jsn_object ->> 'outgoing') :: json);

    if (var_jsn_outgoing :: text <> '{}') then

        var_jsn_outgoing = json_build_object ('outgoing', var_jsn_outgoing);

    end if;

    var_jsn_status = core_get_json_text (in_jsn_object, 'status');

    var_tim_elapsed = core_get_timestamp_difference (core_get_json_timestamp (var_jsn_status, 'tim_datetime'), core_get_json_timestamp (var_obj_timestamp, 'tim_datetime'));

    var_jsn_status = (in_jsn_object ->> 'status') :: json;
    var_jsn_status = core_set_json_text (var_jsn_status, 'tim_elapsed', var_tim_elapsed);
    var_jsn_status = core_set_json_numeric (var_jsn_status, 'sys_result', 0);
    var_jsn_status = core_set_json_text (var_jsn_status, 'sys_message', 'OK');

    var_jsn_status = json_build_object ('status', var_jsn_status);

    return var_jsn_incoming :: jsonb || var_jsn_outgoing :: jsonb || var_jsn_status :: jsonb;

end;
$body$ language plpgsql;