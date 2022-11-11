drop function if exists gateway_set_activation;

create or replace function gateway_set_activation (
    in in_obj_array json
)
returns json as $body$
declare
    var_boo_active_flow boolean;
begin

    in_obj_array = request_get_timestamp (in_obj_array);

    select
        cst.txt_value :: boolean
    into
        var_boo_active_flow
    from
        dat_constants cst
    where
        cst.txt_key = 'active_flow';

    if (var_boo_active_flow = true) then

        var_boo_active_flow = false;

    else

        var_boo_active_flow = true;

    end if;

    update dat_constants set
        txt_value = var_boo_active_flow
    where
        txt_key = 'active_flow';

    in_obj_array = core_set_json_boolean (in_obj_array, 'boo_active', var_boo_active_flow);

    return gateway_get_success (in_obj_array);

exception
    when others then
        return gateway_get_failed (in_obj_array);

end;
$body$ language plpgsql;