drop function if exists chatbot_get_flow;

create or replace function chatbot_get_flow (
    in in_jsn_incoming json
)
returns json as $body$
declare
    var_boo_active_flow boolean;
    var_jsn_incoming json;
    var_jsn_outgoing json;
    var_txt_sender text;
begin

    var_jsn_incoming = core_get_json_empty ((in_jsn_incoming ->> 'incoming') :: json);
    var_jsn_outgoing = core_get_json_empty ((in_jsn_incoming ->> 'outgoing') :: json);
    in_jsn_incoming = core_del_json_node (in_jsn_incoming, 'incoming');
    in_jsn_incoming = core_del_json_node (in_jsn_incoming, 'outgoing');

    var_txt_sender = core_get_json_text (var_jsn_incoming, 'txt_sender');

    select
        cst.txt_value
    into
        var_boo_active_flow
    from
        dat_constants cst
    where
        cst.txt_key = 'maintenance_mode';

    if (var_boo_active_flow is true) then

        var_jsn_outgoing = core_del_json_node (var_jsn_outgoing, 'txt_message');
        var_jsn_outgoing = core_set_json_text (var_jsn_outgoing, 'txt_message', 'in maintenance');

    end if;

    return result_set_return (in_jsn_incoming, var_jsn_incoming, var_jsn_outgoing);

end;
$body$ language plpgsql;