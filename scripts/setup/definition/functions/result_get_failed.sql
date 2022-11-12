drop function if exists result_get_failed;

create or replace function result_get_failed (
    in in_jsn_object json
)
returns json as $body$
declare
    var_jsn_incoming json;
    var_jsn_status json;
    var_jsn_timestamp json;
    var_tim_elapsed text;
    var_tim_timestamp timestamp;
begin

    var_tim_timestamp = core_get_timestamp_value ();

    var_jsn_timestamp = core_get_timestamp_object (var_tim_timestamp);

    var_jsn_incoming = core_get_json_empty ((in_jsn_object ->> 'incoming') :: json);

    if (var_jsn_incoming :: text <> '{}') then

        var_jsn_incoming = json_build_object ('incoming', var_jsn_incoming);

    end if;

    var_jsn_status = core_get_json_text (in_jsn_object, 'status');

    var_tim_elapsed = core_get_timestamp_difference (core_get_json_timestamp (var_jsn_status, 'tim_datetime'), core_get_json_timestamp (var_jsn_timestamp, 'tim_datetime'));

    var_jsn_status = (in_jsn_object ->> 'status') :: json;
    var_jsn_status = core_set_json_text (var_jsn_status, 'tim_elapsed', var_tim_elapsed);
    var_jsn_status = core_set_json_numeric (var_jsn_status, 'sys_result', 20);
    var_jsn_status = core_set_json_text (var_jsn_status, 'sys_message', 'Database Error');

    var_jsn_status = json_build_object ('status', var_jsn_status);

    return var_jsn_incoming :: jsonb || var_jsn_status :: jsonb;

end;
$body$ language plpgsql;