drop function if exists chatbot_set_message;

create or replace function chatbot_set_message (
    in in_jsn_incoming json
)
returns json as $body$
declare
    var_idf_expression numeric;
    var_jsn_alternatives json;
    var_jsn_incoming json;
    var_jsn_outgoing json;
    var_jsn_parameters json;
    var_num_alternatives numeric;
    var_num_offset numeric;
    var_num_parameters numeric;
    var_txt_alternative text;
    var_txt_alternatives text;
    var_txt_first_name text;
    var_txt_header text;
    var_txt_parameter text;
    var_txt_expression text;
begin

    var_jsn_incoming = core_get_json_empty ((in_jsn_incoming ->> 'incoming') :: json);
    var_jsn_outgoing = core_get_json_empty ((in_jsn_incoming ->> 'outgoing') :: json);
    in_jsn_incoming = core_del_json_node (in_jsn_incoming, 'incoming');
    in_jsn_incoming = core_del_json_node (in_jsn_incoming, 'outgoing');

    var_idf_expression = core_get_json_numeric (var_jsn_outgoing, 'idf_expression');
    var_jsn_alternatives = core_get_json_json (var_jsn_outgoing, 'jsn_alternatives');
    var_jsn_parameters = core_get_json_json (var_jsn_outgoing, 'jsn_parameters');
    var_txt_expression = core_get_json_text (var_jsn_outgoing, 'txt_expression');
    var_txt_first_name = core_get_json_text (var_jsn_outgoing, 'txt_first_name');
    var_txt_header = core_get_json_text (var_jsn_outgoing, 'txt_header');

    if (core_get_json_text (var_jsn_outgoing, 'txt_first_name') != '') then

        var_txt_expression = replace (var_txt_expression, '%0', ' *' || var_txt_first_name || '*');

    else

        var_txt_expression = replace (var_txt_expression, '%0', '');

    end if;

    if (var_jsn_parameters::text != '{}') then

        var_num_parameters = json_array_length (var_jsn_parameters) - 1;

        for var_num_offset in 0 .. var_num_parameters loop

            var_txt_parameter = '%' || (var_num_offset + 1);

            var_txt_expression = replace (var_txt_expression, var_txt_parameter, var_jsn_parameters ->> var_num_offset);

        end loop;

    end if;

    if (var_jsn_alternatives::text != '{}') then

        var_num_alternatives = json_array_length (var_jsn_alternatives) - 1;

        var_txt_alternatives = '';

        for var_num_offset in 0 .. var_num_alternatives loop

            var_txt_alternative = var_jsn_alternatives ->> var_num_offset;
            var_txt_alternative = (var_num_offset + 1) || '. ' || var_txt_alternative || chr (10);

            var_txt_alternatives = var_txt_alternatives || var_txt_alternative;

        end loop;

    end if;

    var_jsn_outgoing = core_set_json_text (var_jsn_outgoing, 'txt_response', var_txt_expression);

    return result_set_return (in_jsn_incoming, var_jsn_incoming, var_jsn_outgoing);

end;
$body$ language plpgsql;