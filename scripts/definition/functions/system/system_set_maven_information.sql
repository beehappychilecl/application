drop function if exists system_set_maven_information;

create or replace function system_set_maven_information (
    in in_jsn_incoming json
)
returns json as $body$
declare
    var_jsn_dependencies json;
    var_jsn_parent json;
    var_jsn_plugins json;
begin

    in_jsn_incoming = result_get_initial (in_jsn_incoming);

    if (system_get_maintenance_mode () is true) then

        return result_get_maintenance (in_jsn_incoming);

    end if;

    var_jsn_dependencies = core_get_json_array ((in_jsn_incoming ->> 'incoming') :: json, 'obj_dependencies');

    var_jsn_parent = core_get_json_array ((in_jsn_incoming ->> 'incoming') :: json, 'obj_parent');

    var_jsn_plugins = core_get_json_array ((in_jsn_incoming ->> 'incoming') :: json, 'obj_plugins');

    truncate dat_dependencies;

    insert into dat_dependencies (
        num_type,
        txt_artifact,
        txt_group,
        txt_type,
        txt_version
    ) values (
        1,
        var_jsn_parent ->> 'artifact',
        var_jsn_parent ->> 'group',
        'parent',
        var_jsn_parent ->> 'version'
    );

    insert into dat_dependencies (
        num_type,
        txt_artifact,
        txt_group,
        txt_type,
        txt_version
    )
    select
        2,
        json ->> 'artifact',
        json ->> 'group',
        'dependency',
        json ->> 'version'
    from
        json_array_elements (var_jsn_dependencies) json
    order by
        json ->> 'group',
        json ->> 'artifact';

    insert into dat_dependencies (
        num_type,
        txt_artifact,
        txt_group,
        txt_type,
        txt_version
    )
    select
        3,
        json ->> 'artifact',
        json ->> 'group',
        'plugin',
        json ->> 'version'
    from
        json_array_elements (var_jsn_plugins) json
    order by
        json ->> 'group',
        json ->> 'artifact';

    return result_get_success (in_jsn_incoming);

exception
    when others then
        return result_get_failed (in_jsn_incoming);

end;
$body$ language plpgsql;