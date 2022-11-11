drop function if exists chatbot_get_message;

create or replace function chatbot_get_message (
    in in_jsn_incoming json
)
returns json as $body$
declare
    var_jsn_incoming json;
    var_jsn_outgoing json;
    var_rec_words record;
    var_txt_message text;
    var_txt_word text;
    var_txt_words text;
begin

    var_jsn_incoming = core_get_json_empty ((in_jsn_incoming ->> 'incoming') :: json);
    var_jsn_outgoing = core_get_json_empty ((in_jsn_incoming ->> 'outgoing') :: json);
    in_jsn_incoming = core_del_json_node (in_jsn_incoming, 'incoming');
    in_jsn_incoming = core_del_json_node (in_jsn_incoming, 'outgoing');

    var_txt_message = core_get_json_text (var_jsn_incoming, 'txt_message');
    var_txt_words = '';

    for var_rec_words in
        select
            regexp_split_to_table (var_txt_message, ' ') "words"
    loop

        var_txt_word = trim (regexp_replace (var_rec_words.words, '[^\w]+', '', 'g'));
        var_txt_word = translate (var_txt_word, 'àáâãäéèëêíìïîóòõöôúùüûçÇ', 'aaaaaeeeeiiiiooooouuuucc');

        if (var_txt_word != 'java.sql.SQLWarning' and var_txt_word != '') then

            var_txt_words = var_txt_words || ' ' || var_txt_word;

        end if;

    end loop;

    var_jsn_outgoing = core_del_json_node (var_jsn_incoming, 'txt_message');
    var_jsn_outgoing = core_set_json_text (var_jsn_outgoing, 'txt_message', trim (var_txt_words));

    return result_set_return (in_jsn_incoming, var_jsn_incoming, var_jsn_outgoing);

end;
$body$ language plpgsql;