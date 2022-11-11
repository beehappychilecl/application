drop function if exists core_get_timestamp_value;

create or replace function core_get_timestamp_value ()
returns timestamp as $body$
declare
    var_num_timezone_difference numeric;
begin

    select
        cst.txt_value :: numeric
    into
        var_num_timezone_difference
    from
        dat_constants cst
    where
        cst.txt_key = 'timezone_difference';

    return current_timestamp + (var_num_timezone_difference || ' hour') :: interval;

end;
$body$ language plpgsql;