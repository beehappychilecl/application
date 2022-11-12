drop function if exists core_set_text_base62;

create or replace function core_set_text_base62 ()
returns text as $body$
declare
    var_arr_characters text [];
    var_boo_offset boolean;
    var_num_count numeric;
    var_num_max numeric;
    var_num_min numeric;
    var_num_offset numeric;
    var_num_random numeric;
    var_num_size numeric;
    var_txt_character text;
    var_txt_link text;
begin

    var_arr_characters = string_to_array ('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' :: text, null);
    var_boo_offset = true;
    var_num_max = 61;
    var_num_min = 0;
    var_num_size = 8;
    var_txt_character = '';

    while var_boo_offset is true loop

        var_txt_link = '';

        for var_num_offset in 1 .. var_num_size loop

            var_num_random = floor (random () * (var_num_max - var_num_min + 1) + var_num_min);

            var_txt_character = var_arr_characters [var_num_random + 1];

            var_txt_link = var_txt_link || var_txt_character;

        end loop;

        select
            count (*)
        into
            var_num_count
        from
            dat_links lnk
        where
            lnk.txt_link = var_txt_link;

        if (var_num_count = 0) then

            insert into dat_links (
                txt_link
            ) values (
                var_txt_link
            );

            var_boo_offset = false;

        end if;

    end loop;

    return var_txt_link;

end;
$body$ language plpgsql;