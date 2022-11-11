drop function if exists core_get_random_base62;

create or replace function core_get_random_base62 ()
returns text as $body$
declare
    var_arr_alphabet text [];
    var_num_max numeric;
    var_num_min numeric;
    var_num_offset numeric;
    var_num_random bigint;
    var_txt_object text;
begin

    var_arr_alphabet = string_to_array ('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' :: text, null);

    var_num_max = 218340105584895;

    var_num_min = 3521614606208;

    var_num_random = floor (random () * (var_num_max - var_num_min + 1) + var_num_min);

    var_txt_object = '';

    loop

        var_num_offset = var_num_random % 62;

	    var_num_random = var_num_random / 62;

	    var_txt_object = var_arr_alphabet [(var_num_offset + 1)] || var_txt_object ;

	    exit when var_num_random <= 0;

    end loop ;

    return var_txt_object;

end;
$body$ language plpgsql;