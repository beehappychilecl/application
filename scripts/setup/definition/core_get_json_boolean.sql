drop function if exists core_get_json_boolean;

create or replace function core_get_json_boolean (
    in in_jsn_object json,
    in in_txt_key text
)
returns boolean as $body$
begin

    return trim (in_jsn_object ->> lower (in_txt_key));

end;
$body$ language plpgsql;