drop function if exists gateway_exe_chatbot;

create or replace function gateway_exe_chatbot (
    in in_jsn_incoming json
)
returns json as $body$
begin

    in_jsn_incoming = result_get_initial (in_jsn_incoming);

    in_jsn_incoming = chatbot_get_authentication (in_jsn_incoming);
    in_jsn_incoming = chatbot_get_message (in_jsn_incoming);
    in_jsn_incoming = chatbot_get_flow (in_jsn_incoming);
    in_jsn_incoming = chatbot_get_intention (in_jsn_incoming);
    in_jsn_incoming = chatbot_get_authorization (in_jsn_incoming);
    in_jsn_incoming = chatbot_get_condition (in_jsn_incoming);

    raise notice 'chatbot_set_function';
    raise notice '%', in_jsn_incoming;
    in_jsn_incoming = chatbot_set_function (in_jsn_incoming);

    raise notice 'chatbot_set_expression';
    raise notice '%', in_jsn_incoming;
    in_jsn_incoming = chatbot_set_expression (in_jsn_incoming);

    raise notice 'chatbot_set_message';
    raise notice '%', in_jsn_incoming;
    in_jsn_incoming = chatbot_set_message (in_jsn_incoming);

    raise notice 'chatbot_set_condition';
    raise notice '%', in_jsn_incoming;
    in_jsn_incoming = chatbot_set_condition (in_jsn_incoming);

    raise notice 'result_get_success';
    raise notice '%', in_jsn_incoming;

    return result_get_success (in_jsn_incoming);
/*
exception
    when others then
        return result_get_failed (in_jsn_incoming);
*/
end;
$body$ language plpgsql;