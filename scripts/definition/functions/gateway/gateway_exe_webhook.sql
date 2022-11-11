drop function if exists gateway_exe_webhook;

create or replace function gateway_exe_webhook (
    in in_jsn_incoming json
)
returns json as $body$
begin

    in_jsn_incoming = result_get_initial (in_jsn_incoming);

    in_jsn_incoming = webhook_get_flow (in_jsn_incoming);
    in_jsn_incoming = webhook_set_function (in_jsn_incoming);

    return result_get_success (in_jsn_incoming);

exception
    when others then
        return result_get_failed (in_jsn_incoming);

end;
$body$ language plpgsql;