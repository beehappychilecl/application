drop function if exists core_get_sequence_last;

create or replace function core_get_sequence_last (
    in in_txt_key text
)
returns numeric as $body$
begin

    return setval (lower (in_txt_key), nextval (lower (in_txt_key)) - 1);

end;
$body$ language plpgsql;