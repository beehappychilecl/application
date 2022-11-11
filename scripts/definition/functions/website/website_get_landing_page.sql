drop function if exists website_get_landing_page;

create or replace function website_get_landing_page (
    in in_jsn_incoming json
)
returns json as $body$
begin

    in_jsn_incoming = result_get_initial (in_jsn_incoming);

    if (system_get_maintenance_mode () is true) then

        return result_get_maintenance (in_jsn_incoming);

    end if;

    return result_get_success (in_jsn_incoming);

exception
    when others then
        return result_get_failed (in_jsn_incoming);

end;
$body$ language plpgsql;