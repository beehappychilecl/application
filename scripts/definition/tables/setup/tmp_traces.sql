drop table if exists tmp_traces cascade;

create table tmp_traces (
    jsn_incoming json,
    jsn_outgoing json,
    num_level numeric,
    num_type numeric,
    tim_final timestamp,
    tim_initial timestamp,
    txt_action text,
    txt_class text,
    txt_difference text,
    txt_function text,
    txt_method text,
    txt_offset text,
    txt_package text,
    txt_result text,
    txt_thread text
);