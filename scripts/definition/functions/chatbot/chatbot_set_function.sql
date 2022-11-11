drop function if exists chatbot_set_function;

create or replace function chatbot_set_function (
    in in_jsn_incoming json
)
returns json as $body$
declare
    var_idf_expression numeric;
    var_idf_intention numeric;
    var_jsn_incoming json;
    var_jsn_outgoing json;
    var_jsn_subroutine json;
    var_txt_function text;
    var_txt_sentence text;
begin

    var_jsn_incoming = core_get_json_empty ((in_jsn_incoming ->> 'incoming') :: json);
    var_jsn_outgoing = core_get_json_empty ((in_jsn_incoming ->> 'outgoing') :: json);
    in_jsn_incoming = core_del_json_node (in_jsn_incoming, 'incoming');
    in_jsn_incoming = core_del_json_node (in_jsn_incoming, 'outgoing');

    var_idf_intention = core_get_json_numeric (var_jsn_outgoing, 'idf_intention');
    var_txt_function = core_get_json_text (var_jsn_outgoing, 'txt_function');

    if (var_txt_function is not null) then

        var_jsn_subroutine = result_set_return (in_jsn_incoming, var_jsn_incoming, var_jsn_outgoing);
raise notice '--------- 1 ------------ %', var_txt_function;
raise notice '--------- 2 ------------ %', var_jsn_subroutine;
        var_txt_sentence = 'select ' || var_txt_function || ' (' || chr (39) || var_jsn_subroutine || chr (39) || ')';

        execute
            var_txt_sentence
        into
            var_jsn_subroutine;

        var_jsn_outgoing = core_get_json_empty ((var_jsn_subroutine ->> 'outgoing') :: json);

    else

        var_idf_expression = var_idf_intention;

        var_jsn_outgoing = core_set_json_numeric (var_jsn_outgoing, 'idf_expression', var_idf_expression);

    end if;

    return result_set_return (in_jsn_incoming, var_jsn_incoming, var_jsn_outgoing);

end;
$body$ language plpgsql;