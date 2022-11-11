drop function if exists chatbot_get_authentication;

create or replace function chatbot_get_authentication (
    in in_jsn_incoming json
)
returns json as $body$
declare
    var_jsn_incoming json;
    var_jsn_outgoing json;
    var_idf_profile numeric;
    var_idf_unknowable numeric;
    var_idf_user numeric;
    var_txt_first_name text;
    var_txt_full_name text;
    var_txt_last_name text;
    var_txt_sender text;
begin

    var_jsn_incoming = core_get_json_empty ((in_jsn_incoming ->> 'incoming') :: json);
    var_jsn_outgoing = core_get_json_empty ((in_jsn_incoming ->> 'outgoing') :: json);
    in_jsn_incoming = core_del_json_node (in_jsn_incoming, 'incoming');
    in_jsn_incoming = core_del_json_node (in_jsn_incoming, 'outgoing');

    var_idf_unknowable = core_get_action_unknowable ();
    var_txt_sender = core_get_json_text (var_jsn_incoming, 'txt_sender');
    var_txt_sender = replace (var_txt_sender, ' ', '');
    var_txt_sender = replace (var_txt_sender, '+', '');
    var_txt_sender = replace (var_txt_sender, '(', '');
    var_txt_sender = replace (var_txt_sender, ')', '');
    var_txt_sender = replace (var_txt_sender, '-', '');
    var_txt_sender = lower (var_txt_sender);

    if (var_txt_sender = '0') then

        select
            usr.idf_user,
            usr.txt_first_name,
            usr.txt_last_name,
            pfu.idf_profile
        into
            var_idf_user,
            var_txt_first_name,
            var_txt_last_name,
            var_idf_profile
        from
            dat_users usr,
            dat_profiles_users pfu
        where
            pfu.idf_profile = 0
            and usr.idf_user = pfu.idf_user;

        if (var_txt_last_name is null) then

            var_txt_last_name = '';

        end if;

        var_jsn_incoming = core_del_json_node (var_jsn_incoming, 'txt_message');
        var_jsn_incoming = core_set_json_text (var_jsn_incoming, 'txt_message', 'about me');

    else

        select
            usr.idf_user,
            usr.txt_first_name,
            usr.txt_last_name,
            pfu.idf_profile
        into
            var_idf_user,
            var_txt_first_name,
            var_txt_last_name,
            var_idf_profile
        from
            dat_users usr,
            dat_profiles_users pfu
        where
            usr.sys_status = true
            and usr.num_phone = var_txt_sender :: numeric
            and pfu.idf_user = usr.idf_user;

        if (var_txt_first_name is null) then

            var_idf_profile = var_idf_unknowable;
            var_idf_user = null;
            var_txt_first_name = '';
            var_txt_last_name = '';

        end if;

        if (var_txt_last_name is null) then

            var_txt_last_name = '';

        end if;

    end if;

    var_txt_full_name = trim (var_txt_first_name || ' ' || var_txt_last_name);

    var_jsn_outgoing = core_set_json_numeric (var_jsn_outgoing, 'idf_profile', var_idf_profile);
    var_jsn_outgoing = core_set_json_numeric (var_jsn_outgoing, 'idf_user', var_idf_user);
    var_jsn_outgoing = core_set_json_text (var_jsn_outgoing, 'txt_first_name', var_txt_first_name);
    var_jsn_outgoing = core_set_json_text (var_jsn_outgoing, 'txt_full_name', var_txt_full_name);
    var_jsn_outgoing = core_set_json_text (var_jsn_outgoing, 'txt_last_name', var_txt_last_name);

    return result_set_return (in_jsn_incoming, var_jsn_incoming, var_jsn_outgoing);

end;
$body$ language plpgsql;