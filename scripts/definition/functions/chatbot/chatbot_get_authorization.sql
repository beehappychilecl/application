drop function if exists chatbot_get_authorization;

create or replace function chatbot_get_authorization (
    in in_jsn_incoming json
)
returns json as $body$
declare
    var_boo_registered boolean;
    var_idf_profile numeric;
    var_idf_unregistered numeric;
    var_jsn_incoming json;
    var_jsn_outgoing json;
    var_txt_function text;
begin

    var_jsn_incoming = core_get_json_empty ((in_jsn_incoming ->> 'incoming') :: json);
    var_jsn_outgoing = core_get_json_empty ((in_jsn_incoming ->> 'outgoing') :: json);
    in_jsn_incoming = core_del_json_node (in_jsn_incoming, 'incoming');
    in_jsn_incoming = core_del_json_node (in_jsn_incoming, 'outgoing');

    var_boo_registered = core_get_json_boolean (var_jsn_outgoing, 'boo_registered');
    var_idf_profile = core_get_json_numeric (var_jsn_outgoing, 'idf_profile');
    var_idf_unregistered = core_get_action_unregistered ();

    if (var_boo_registered = true and var_idf_profile = 91) then

        select
            rel.txt_function
        into
            var_txt_function
        from
            dat_relations rel
        where
            rel.idf_intention = var_idf_unregistered;

        var_jsn_outgoing = core_del_json_node (var_jsn_outgoing, 'idf_intention');
        var_jsn_outgoing = core_set_json_numeric (var_jsn_outgoing, 'idf_intention', var_idf_unregistered);
        var_jsn_outgoing = core_del_json_node (var_jsn_outgoing, 'txt_function');
        var_jsn_outgoing = core_set_json_text (var_jsn_outgoing, 'txt_function', var_txt_function);

    end if;

    return result_set_return (in_jsn_incoming, var_jsn_incoming, var_jsn_outgoing);

end;
$body$ language plpgsql;