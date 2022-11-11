drop function if exists system_set_delete_traces;

create or replace function system_set_delete_traces (
    in in_jsn_incoming json
)
returns json as $body$
begin

    in_jsn_incoming = request_get_timestamp (in_jsn_incoming);

    truncate dat_traces;

    return result_get_success (in_jsn_incoming);

exception
    when others then
        return result_get_failed (in_jsn_incoming);

end;
$body$ language plpgsql;