drop function if exists core_get_json_text;

create or replace function core_get_json_text (
    in in_jsn_object json,
    in in_txt_key text
)
returns text as $body$
declare
    var_txt_array text;
begin

    var_txt_array = trim (in_jsn_object ->> lower (in_txt_key));

    var_txt_array = replace (var_txt_array, '"[', '[');
    var_txt_array = replace (var_txt_array, ']"', ']');

    return var_txt_array;

end;
$body$ language plpgsql;