drop function if exists core_get_sequence_next;

create or replace function core_get_sequence_next (
    in in_txt_key text
)
returns numeric as $body$
begin

    return nextval (lower (in_txt_key));

end;
$body$ language plpgsql;