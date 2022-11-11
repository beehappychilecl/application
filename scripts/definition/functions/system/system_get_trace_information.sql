drop function if exists system_get_trace_information;

create or replace function system_get_trace_information (
    in in_jsn_incoming json
)
returns json as $body$
declare
    var_arr_finalize text [];
    var_arr_initialize text [];
    var_arr_lines text [];
    var_jsn_incoming json;
    var_jsn_outgoing json;
    var_jsn_trace json;
    var_num_level numeric;
    var_rec_traces record;
    var_txt_line_1 text;
    var_txt_thread text;
    xxx text;
begin

    var_arr_finalize = array ['METHOD_FINALIZE', 'FUNCTION_SUCCESS', 'FUNCTION_NULL', 'FUNCTION_FAILED', 'SERVICE_SUCCESS', 'SERVICE_NULL', 'SERVICE_FAILED', 'SCRIPT_SUCCESS', 'SCRIPT_FAILED'];
    var_arr_initialize = array ['METHOD_INITIALIZE', 'FUNCTION_INVOCATION', 'SERVICE_INVOCATION', 'SCRIPT_EXECUTION'];
    var_arr_lines = '{}' :: text [];

    var_num_level = 0;

    var_txt_thread = core_get_json_text (in_jsn_incoming, 'txt_thread');

    for var_rec_traces in
        select
            trc.sys_timestamp,
            trc.txt_thread,
            trc.txt_offset,
            trc.jsn_trace
        from
            dat_traces trc
        where
            trc.txt_thread = var_txt_thread
        order by
            trc.sys_timestamp
    loop
raise notice '++* %', var_rec_traces.jsn_trace;
        --var_jsn_trace = var_rec_traces.jsn_trace :: json;
/*
        var_jsn_incoming = core_get_json_json (var_jsn_trace, 'jsn_incoming');
        var_jsn_outgoing = core_get_json_json (var_jsn_trace, 'jsn_outgoing');
*/
    end loop;
/*
    xxx = '';

    foreach var_txt_line_1 in array var_arr_lines loop

        xxx = xxx || var_txt_line_1;

    end loop;
*/
    raise notice '%', xxx;

    delete from tmp_traces
    where
        txt_thread = var_txt_thread;

    return '{}';

end;
$body$ language plpgsql;