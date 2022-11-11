drop function if exists chatbot_set_expression;

create or replace function chatbot_set_expression (
    in in_jsn_incoming json
)
returns json as $body$
declare
    var_idf_expression numeric;
    var_jsn_incoming json;
    var_jsn_outgoing json;
    var_txt_expression text;
    var_txt_header text;
begin

    var_jsn_incoming = core_get_json_empty ((in_jsn_incoming ->> 'incoming') :: json);
    var_jsn_outgoing = core_get_json_empty ((in_jsn_incoming ->> 'outgoing') :: json);
    in_jsn_incoming = core_del_json_node (in_jsn_incoming, 'incoming');
    in_jsn_incoming = core_del_json_node (in_jsn_incoming, 'outgoing');

    var_idf_expression = core_get_json_numeric (var_jsn_outgoing, 'idf_expression');

    select
        exp.txt_expression
    into
        var_txt_header
    from
        dat_expressions exp
    where
        exp.idf_expression = 0;

    var_jsn_outgoing = core_set_json_text (var_jsn_outgoing, 'txt_header', var_txt_header);

    select
        exp.txt_expression
    into
        var_txt_expression
    from
        dat_expressions exp
    where
        exp.idf_expression = var_idf_expression
    order by
        random ()
    limit 1;

    var_jsn_outgoing = core_set_json_text (var_jsn_outgoing, 'txt_expression', var_txt_expression);

    return result_set_return (in_jsn_incoming, var_jsn_incoming, var_jsn_outgoing);

end;
$body$ language plpgsql;