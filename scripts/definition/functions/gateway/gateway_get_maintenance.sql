drop function if exists gateway_get_maintenance;

create or replace function gateway_get_maintenance (
    in in_jsn_incoming json
)
returns json as $body$
declare
    var_jsn_incoming json;
begin

    var_jsn_incoming = json_build_object ('sys_result', 580, 'sys_message', 'MAINTENANCE_MODE');
    var_jsn_incoming = json_build_object ('status', var_jsn_incoming);

    if (in_jsn_incoming is not null) then

        in_jsn_incoming = json_build_object ('data', in_jsn_incoming);

        var_jsn_incoming = in_jsn_incoming :: jsonb || var_jsn_incoming :: jsonb;

    end if;

    return var_jsn_incoming;

end;
$body$ language plpgsql;