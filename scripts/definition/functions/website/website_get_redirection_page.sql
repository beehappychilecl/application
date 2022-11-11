drop function if exists website_get_redirection_page;

create or replace function website_get_redirection_page (
    in in_jsn_incoming json
)
returns json as $body$
declare
    var_jsn_incoming json;
    var_jsn_outgoing json;
    var_num_count numeric;
    var_txt_request text;
    var_txt_response text;
begin

    in_jsn_incoming = result_get_initial (in_jsn_incoming);

    if (system_get_maintenance_mode () is true) then

        return result_get_maintenance (in_jsn_incoming);

    end if;

    var_jsn_incoming = core_get_json_json (in_jsn_incoming, 'incoming');

    var_txt_request = core_get_json_text (var_jsn_incoming, 'txt_request');

    select
        count (*)
    into
        var_num_count
    from
        dat_redirects rdr
    where
        rdr.txt_request = var_txt_request;

    if (var_num_count = 0) then

        return result_get_failed (in_jsn_incoming);

    end if;

    select
        rdr.txt_response
    into
        var_txt_response
    from
        dat_redirects rdr
    where
        rdr.txt_request = var_txt_request;

    var_jsn_outgoing = core_get_json_empty (null);
    var_jsn_outgoing = core_set_json_text (var_jsn_outgoing, 'txt_response', var_txt_response);

    in_jsn_incoming = core_set_json_json (in_jsn_incoming, 'outgoing', var_jsn_outgoing);

    return result_get_success (in_jsn_incoming);

end;
$body$ language plpgsql;