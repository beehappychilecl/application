drop function if exists system_get_maintenance_mode;

create or replace function system_get_maintenance_mode ()
returns boolean as $body$
declare
    var_boo_maintenance boolean;
begin

    select
        cst.txt_value :: boolean
    into
        var_boo_maintenance
    from
        dat_constants cst
    where
        cst.txt_key = 'maintenance_mode';

    return var_boo_maintenance;

end;
$body$ language plpgsql;