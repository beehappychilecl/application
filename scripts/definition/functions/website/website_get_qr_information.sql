drop function if exists website_get_qr_information;

create or replace function website_get_qr_information (
    in in_jsn_incoming json
)
returns json as $body$
declare
    var_jsn_incoming json;
    var_jsn_outgoing json;
    var_num_count numeric;
    var_txt_first_name text;
    var_txt_link text;
begin

    in_jsn_incoming = result_get_initial (in_jsn_incoming);

    if (system_get_maintenance_mode () is true) then

        return result_get_maintenance (in_jsn_incoming);

    end if;

    var_jsn_incoming = core_get_json_json (in_jsn_incoming, 'incoming');

    var_txt_first_name = core_get_json_text (var_jsn_incoming, 'txt_first_name');
    var_txt_first_name = lower (var_txt_first_name);

    select
        count (*)
    into
        var_num_count
    from
        dat_users usr,
        dat_profiles_users pfu
    where
        usr.sys_status = true
        and lower (usr.txt_first_name) = var_txt_first_name
        and pfu.idf_user = usr.idf_user
        and pfu.idf_profile in (10, 11, 12, 21, 31, 32, 41, 51);

    if (var_num_count = 0) then

        return result_get_failed (in_jsn_incoming);

    end if;

    select
        cst.txt_value || var_txt_first_name
    into
        var_txt_link
    from
        dat_constants cst
    where
        cst.txt_key = 'website_staff';

    var_jsn_outgoing = core_set_json_text (var_jsn_outgoing, 'txt_link', var_txt_link);

    in_jsn_incoming = core_set_json_json (in_jsn_incoming, 'outgoing', var_jsn_outgoing);

    return result_get_success (in_jsn_incoming);

exception
    when others then
        return result_get_failed (in_jsn_incoming);

end;
$body$ language plpgsql;