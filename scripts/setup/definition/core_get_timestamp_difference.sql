drop function if exists core_get_timestamp_difference;

create or replace function core_get_timestamp_difference (
    in in_tim_timestamp_1 timestamp,
    in in_tim_timestamp_2 timestamp
)
returns text as $body$
begin

    return to_char (in_tim_timestamp_2 - in_tim_timestamp_1, 'ss') :: numeric || '.' || split_part (round (extract (epoch from (in_tim_timestamp_2 - in_tim_timestamp_1)) :: text :: numeric, 3)::text, '.' , 2);

end;
$body$ language plpgsql;