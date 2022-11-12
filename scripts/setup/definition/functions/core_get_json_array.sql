drop function if exists core_get_json_array;

create or replace function core_get_json_array (
    in in_jsn_object json,
    in in_txt_key text
)
returns text [] as $body$
begin

    return translate (in_jsn_object ->> lower (in_txt_key), '[]', '{}') :: text [];

end;
$body$ language plpgsql;