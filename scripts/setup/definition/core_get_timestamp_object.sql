drop function if exists core_get_timestamp_object;

create or replace function core_get_timestamp_object (
    in in_tim_timestamp timestamp
)
returns json as $body$
declare
    var_tim_date text;
    var_tim_datetime text;
    var_tim_time text;
begin

    var_tim_date = date (in_tim_timestamp) :: text;

    var_tim_time = to_char (in_tim_timestamp, 'hh24:mi:ss') || '.' || split_part (round (extract (epoch from (in_tim_timestamp)) :: text :: numeric, 3)::text, '.' , 2);

    var_tim_datetime = var_tim_date || ' ' || var_tim_time;

    return json_build_object ('tim_date', var_tim_date, 'tim_datetime', var_tim_datetime, 'tim_time', var_tim_time);

end;
$body$ language plpgsql;