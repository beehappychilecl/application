drop function if exists core_get_json_timestamp;

create or replace function core_get_json_timestamp (
    in in_jsn_object json,
    in in_txt_key text
)
returns timestamp as $body$
declare
    var_txt_array text;
begin

    var_txt_array = trim (in_jsn_object ->> lower (in_txt_key));

    var_txt_array = replace (var_txt_array, '"[', '[');
    var_txt_array = replace (var_txt_array, ']"', ']');

    return var_txt_array :: timestamp;

end;
$body$ language plpgsql;