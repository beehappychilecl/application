drop function if exists system_get_traces_list;

create or replace function system_get_traces_list (
    in in_obj_array json
)
    returns json as $body$
declare
    var_obj_trace json;
    var_rec_traces record;
    var_tim_timestamp_1 timestamp;
    var_tim_timestamp_2 timestamp;
    var_txt_date text;
    var_txt_elapsed text;
    var_txt_method text;
    var_txt_time text;
    var_txt_trace text;
begin

    in_obj_array = request_get_timestamp (  in_obj_array);

    var_txt_trace = '';

    for var_rec_traces in
        select
            trc.sys_timestamp,
            trc.txt_thread
        from
            dat_traces trc
        order by
            trc.sys_timestamp
        loop

            if (var_txt_trace != var_rec_traces.txt_thread) then

                var_txt_trace = var_rec_traces.txt_thread;

                var_txt_date = split_part (var_rec_traces.sys_timestamp :: text, ' ' , 1);
                var_txt_time = split_part (var_rec_traces.sys_timestamp :: text, ' ' , 2);
                var_txt_time = split_part (var_txt_time, '.', 1) || '.' || rpad (split_part (var_txt_time, '.', 2), 3, '0');

                select
                    trc.sys_timestamp
                into
                    var_tim_timestamp_1
                from
                    dat_traces trc
                where
                        core_get_json_text (trc.obj_trace :: json, 'txt_thread') = var_rec_traces.txt_thread
                order by
                    trc.sys_timestamp
                limit 1;

                select
                    trc.sys_timestamp
                into
                    var_tim_timestamp_2
                from
                    dat_traces trc
                where
                        core_get_json_text (trc.obj_trace :: json, 'txt_thread') = var_rec_traces.txt_thread
                order by
                    trc.sys_timestamp desc
                limit 1;

                var_txt_elapsed = round (extract (epoch from (var_tim_timestamp_2 - var_tim_timestamp_1)) :: text :: numeric, 3) :: text;
                var_txt_elapsed = split_part (var_txt_elapsed, '.', 1) || '.' || rpad (split_part (var_txt_elapsed, '.', 2), 3, '0');

                select
                    trc.obj_trace
                into
                    var_obj_trace
                from
                    dat_traces trc
                where
                        trc.sys_timestamp = var_tim_timestamp_1;

                raise notice '% * % * % * % * %', var_txt_date, var_txt_time, var_rec_traces.txt_thread, var_txt_elapsed, upper (core_get_json_text (var_obj_trace, 'txt_method'));

            end if;

        end loop;

    return null;

/*
    return result_get_success (in_obj_array);

exception
    when others then
        return result_get_failed (in_obj_array);
*/
end;
$body$ language plpgsql;