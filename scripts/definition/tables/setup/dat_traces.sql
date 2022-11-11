drop table if exists dat_traces cascade;

create table dat_traces (
    sys_timestamp timestamp,
    jsn_trace     jsonb,
    txt_offset    text,
    txt_thread    text
);

comment on table dat_traces is 'trc';