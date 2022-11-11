drop function if exists website_get_name_information;

create or replace function website_get_name_information (
    in in_jsn_incoming json
)
returns json as $body$
declare
    var_jsn_incoming json;
    var_jsn_outgoing json;
    var_num_count numeric;
    var_txt_first_name text;
    var_txt_icon text;
    var_txt_name text;
    var_txt_full_name text;
    var_txt_last_name text;
    var_txt_mail text;
    var_txt_phone_1 text;
    var_txt_phone_2 text;
    var_txt_profile text;
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
        dat_profiles_users pfu,
        dat_profiles prf
    where
        usr.sys_status = true
        and lower (usr.txt_first_name) = var_txt_first_name
        and pfu.idf_user = usr.idf_user
        and pfu.idf_profile in (10, 11, 12, 21, 31, 32, 41, 51)
        and prf.idf_profile = pfu.idf_profile;

    if (var_num_count = 0) then

        return result_get_failed (in_jsn_incoming);

    end if;

    select
        lower (usr.txt_first_name),
        usr.txt_first_name,
        coalesce (usr.txt_last_name, ''),
        prf.txt_icon,
        usr.txt_mail,
        usr.num_phone,
        prf.txt_profile
    into
        var_txt_name,
        var_txt_first_name,
        var_txt_last_name,
        var_txt_icon,
        var_txt_mail,
        var_txt_phone_2,
        var_txt_profile
    from
        dat_users usr,
        dat_profiles_users pfu,
        dat_profiles prf
    where
        usr.sys_status = true
        and lower (usr.txt_first_name) = var_txt_first_name
        and pfu.idf_user = usr.idf_user
        and pfu.idf_profile in (10, 11, 12, 21, 31, 32, 41, 51)
        and prf.idf_profile = pfu.idf_profile;

    var_txt_full_name = trim (var_txt_first_name || ' ' || var_txt_last_name);

    select
        '+' || substring (var_txt_phone_2, 1, 2) || ' ' || substring (var_txt_phone_2, 3, 1) || ' ' || substring (var_txt_phone_2, 4, 4) || ' ' || substring (var_txt_phone_2, 8, 4)
    into
        var_txt_phone_1;

    var_jsn_outgoing = core_set_json_text (var_jsn_outgoing, 'txt_name', var_txt_name);
    var_jsn_outgoing = core_set_json_text (var_jsn_outgoing, 'txt_full_name', var_txt_full_name);
    var_jsn_outgoing = core_set_json_text (var_jsn_outgoing, 'txt_icon', var_txt_icon);
    var_jsn_outgoing = core_set_json_text (var_jsn_outgoing, 'txt_phone_1', var_txt_phone_1);
    var_jsn_outgoing = core_set_json_text (var_jsn_outgoing, 'txt_phone_2', var_txt_phone_2);
    var_jsn_outgoing = core_set_json_text (var_jsn_outgoing, 'txt_mail', var_txt_mail);
    var_jsn_outgoing = core_set_json_text (var_jsn_outgoing, 'txt_profile', var_txt_profile);

    in_jsn_incoming = core_set_json_json (in_jsn_incoming, 'outgoing', var_jsn_outgoing);

    return result_get_success (in_jsn_incoming);

exception
    when others then
        return result_get_failed (in_jsn_incoming);

end;
$body$ language plpgsql;