drop function if exists core_get_json_json;

create or replace function core_get_json_json (
    in in_jsn_object json,
    in in_txt_key text
)
returns json as $body$
declare
    var_jsn_object json;
begin

    var_jsn_object = jsonb_pretty (trim (in_jsn_object ->> lower (in_txt_key)) :: jsonb);

    if (var_jsn_object is null) then

        return '{}';

    else

        return var_jsn_object;

    end if;

end;
$body$ language plpgsql;