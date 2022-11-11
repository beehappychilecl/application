drop function if exists chatbot_get_intention;

create or replace function chatbot_get_intention (
    in in_jsn_incoming json
)
returns json as $body$
declare
    var_idf_unhandled numeric;
    var_jsn_incoming json;
    var_jsn_outgoing json;
    var_rec_intentions record;
    var_txt_message text;
begin

    var_jsn_incoming = core_get_json_empty ((in_jsn_incoming ->> 'incoming') :: json);
    var_jsn_outgoing = core_get_json_empty ((in_jsn_incoming ->> 'outgoing') :: json);
    in_jsn_incoming = core_del_json_node (in_jsn_incoming, 'incoming');
    in_jsn_incoming = core_del_json_node (in_jsn_incoming, 'outgoing');

    var_idf_unhandled = core_get_action_unhandled ();
    var_txt_message = core_get_json_text (var_jsn_incoming, 'txt_message');

    for var_rec_intentions in
        select
            int.boo_exact :: boolean,
            int.idf_intention,
            int.txt_intention,
            rel.boo_dependency,
            rel.boo_registered,
            rel.txt_function
        from
            dat_intentions int,
            dat_relations rel
        where
            int.txt_intention is not null
            and rel.idf_intention = int.idf_intention
        order by
            int.boo_exact desc,
            int.idf_intention
    loop

        if (var_rec_intentions.boo_exact is true) then

            if (var_rec_intentions.txt_intention = var_txt_message) then

                var_jsn_outgoing = core_del_json_node (var_jsn_outgoing, 'boo_dependency');
                var_jsn_outgoing = core_del_json_node (var_jsn_outgoing, 'boo_registered');
                var_jsn_outgoing = core_del_json_node (var_jsn_outgoing, 'idf_intention');
                var_jsn_outgoing = core_del_json_node (var_jsn_outgoing, 'txt_function');
                var_jsn_outgoing = core_set_json_boolean (var_jsn_outgoing, 'boo_dependency', var_rec_intentions.boo_dependency);
                var_jsn_outgoing = core_set_json_boolean (var_jsn_outgoing, 'boo_registered', var_rec_intentions.boo_registered);
                var_jsn_outgoing = core_set_json_numeric (var_jsn_outgoing, 'idf_intention', var_rec_intentions.idf_intention);
                var_jsn_outgoing = core_set_json_text (var_jsn_outgoing, 'txt_function', var_rec_intentions.txt_function);

                return result_set_return (in_jsn_incoming, var_jsn_incoming, var_jsn_outgoing);

            end if;

        end if;

        if (var_rec_intentions.boo_exact is false) then

            if (regexp_matches (var_txt_message, var_rec_intentions.txt_intention) is not null) then

                var_jsn_outgoing = core_del_json_node (var_jsn_outgoing, 'boo_dependency');
                var_jsn_outgoing = core_del_json_node (var_jsn_outgoing, 'boo_registered');
                var_jsn_outgoing = core_del_json_node (var_jsn_outgoing, 'idf_intention');
                var_jsn_outgoing = core_del_json_node (var_jsn_outgoing, 'txt_function');
                var_jsn_outgoing = core_set_json_boolean (var_jsn_outgoing, 'boo_dependency', var_rec_intentions.boo_dependency);
                var_jsn_outgoing = core_set_json_boolean (var_jsn_outgoing, 'boo_registered', var_rec_intentions.boo_registered);
                var_jsn_outgoing = core_set_json_numeric (var_jsn_outgoing, 'idf_intention', var_rec_intentions.idf_intention);
                var_jsn_outgoing = core_set_json_text (var_jsn_outgoing, 'txt_function', var_rec_intentions.txt_function);

                return result_set_return (in_jsn_incoming, var_jsn_incoming, var_jsn_outgoing);

            end if;

        end if;

    end loop;

    for var_rec_intentions in
        select
            int.idf_intention,
            rel.boo_dependency,
            rel.boo_registered,
            rel.txt_function
        from
            dat_intentions int,
            dat_relations rel
        where
            int.idf_intention = var_idf_unhandled
    loop

        var_jsn_outgoing = core_del_json_node (var_jsn_outgoing, 'boo_dependency');
        var_jsn_outgoing = core_del_json_node (var_jsn_outgoing, 'boo_registered');
        var_jsn_outgoing = core_del_json_node (var_jsn_outgoing, 'idf_intention');
        var_jsn_outgoing = core_del_json_node (var_jsn_outgoing, 'txt_function');
        var_jsn_outgoing = core_set_json_boolean (var_jsn_outgoing, 'boo_dependency', var_rec_intentions.boo_dependency);
        var_jsn_outgoing = core_set_json_boolean (var_jsn_outgoing, 'boo_registered', var_rec_intentions.boo_registered);
        var_jsn_outgoing = core_set_json_numeric (var_jsn_outgoing, 'idf_intention', var_rec_intentions.idf_intention);
        var_jsn_outgoing = core_set_json_text (var_jsn_outgoing, 'txt_function', var_rec_intentions.txt_function);

    end loop;

    return result_set_return (in_jsn_incoming, var_jsn_incoming, var_jsn_outgoing);

end;
$body$ language plpgsql;