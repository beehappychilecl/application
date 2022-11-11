drop function if exists system_set_deploy_information;

create or replace function system_set_deploy_information (
    in in_jsn_incoming json
)
returns json as $body$
declare
    var_num_timezone_difference numeric;
    var_tim_datetime timestamp;
    var_txt_datetime text;
    var_txt_version text;
begin

    in_jsn_incoming = result_get_initial (in_jsn_incoming);

    if (system_get_maintenance_mode () is true) then

        return result_get_maintenance (in_jsn_incoming);

    end if;

    var_txt_datetime = core_get_json_text ((in_jsn_incoming ->> 'incoming') :: json, 'txt_deploy');

    var_tim_datetime = (date (var_txt_datetime) || ' ' || split_part (split_part (var_txt_datetime, 'T', 2), 'Z', 1)) :: timestamp;

    select
        cst.txt_value :: numeric
    into
        var_num_timezone_difference
    from
        dat_constants cst
    where
        cst.txt_key = 'timezone_difference';

    var_tim_datetime = var_tim_datetime + (var_num_timezone_difference || ' hour') :: interval;

    var_txt_version = core_get_json_text ((in_jsn_incoming ->> 'incoming') :: json, 'txt_version');

    insert into dat_constants (
        idf_constant,
        txt_key,
        txt_value
    ) values (
        1011,
        'deploy_datetime',
        var_tim_datetime
    )
    on conflict (idf_constant)
    do update set
        txt_key = 'deploy_datetime',
        txt_value = var_tim_datetime;

    insert into dat_constants (
        idf_constant,
        txt_key,
        txt_value
    ) values (
        1012,
        'deploy_version',
        var_txt_version
    )
    on conflict (idf_constant)
    do update set
        txt_key = 'deploy_version',
        txt_value = var_txt_version;

    return result_get_success (in_jsn_incoming);

exception
    when others then
        return result_get_failed (in_jsn_incoming);

end;
$body$ language plpgsql;