drop function if exists website_get_awake_page;

create or replace function website_get_awake_page (
    in in_jsn_incoming json
)
returns json as $body$
declare
    var_jsn_incoming json;
    var_jsn_outgoing json;
    var_txt_version text;
begin

    in_jsn_incoming = result_get_initial (in_jsn_incoming);

    var_jsn_incoming = core_get_json_json (in_jsn_incoming, 'incoming');

    select
        cst.txt_value
    into
        var_txt_version
    from
        dat_constants cst
    where
        cst.txt_key = 'application_version';

    var_jsn_outgoing = core_set_json_text (var_jsn_outgoing, 'txt_version', var_txt_version);

    return result_set_return (in_jsn_incoming, var_jsn_incoming, var_jsn_outgoing);

exception
    when others then
        return result_get_failed (in_jsn_incoming);

end;
$body$ language plpgsql;