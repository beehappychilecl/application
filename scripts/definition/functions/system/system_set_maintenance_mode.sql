drop function if exists system_set_maintenance_mode;

create or replace function system_set_maintenance_mode (
    in in_jsn_incoming json
)
returns json as $body$
declare
    var_boo_maintenance boolean;
    var_jsn_outgoing json;
begin

    in_jsn_incoming = result_get_initial (in_jsn_incoming);

    select
        cst.txt_value :: boolean
    into
        var_boo_maintenance
    from
        dat_constants cst
    where
        cst.txt_key = 'maintenance_mode';

    if (var_boo_maintenance is true) then

        var_boo_maintenance = false;

    else

        var_boo_maintenance = true;

    end if;

    update dat_constants cst set
        txt_value = var_boo_maintenance
    where
        cst.txt_key = 'maintenance_mode';

    var_jsn_outgoing = core_set_json_boolean (var_jsn_outgoing, 'boo_maintenance', var_boo_maintenance);

    in_jsn_incoming = core_set_json_json (in_jsn_incoming, 'outgoing', var_jsn_outgoing);

    return result_get_success (in_jsn_incoming);

exception
    when others then
        return result_get_failed (in_jsn_incoming);

end;
$body$ language plpgsql;