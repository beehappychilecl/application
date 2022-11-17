drop function if exists indicator_set_dollars;

create or replace function indicator_set_dollars (
    in in_jsn_incoming json
)
returns json as $body$
declare
    var_num_actual numeric;
    var_num_previous numeric;
    var_num_registries numeric;
    var_num_year numeric;
    var_obj_incoming json;
    var_obj_series json;
    var_rec_day record;
begin

    in_jsn_incoming = result_get_initial (in_jsn_incoming);

    var_obj_incoming = core_get_json_json (in_jsn_incoming, 'incoming');

    var_obj_series = core_get_json_json ((in_jsn_incoming ->> 'incoming') :: json, 'Dolares');
/*
    for var_rec_day in
        select distinct
            to_char ((json ->> 'fecha') :: date, 'yyyymmdd') :: numeric "idf_dollar",
            to_char ((json ->> 'fecha') :: date, 'dd') :: numeric "num_day",
            to_char ((json ->> 'fecha') :: date, 'mm') :: numeric "num_month",
            (json ->> 'valor') :: numeric "num_value",
            to_char ((json ->> 'fecha') :: date, 'yyyy') :: numeric "num_year"
        from
            json_array_elements (var_obj_series) json
        order by
            to_char ((json ->> 'fecha') :: date, 'yyyymmdd') :: numeric,
            to_char ((json ->> 'fecha') :: date, 'dd') :: numeric,
            to_char ((json ->> 'fecha') :: date, 'mm') :: numeric,
            (json ->> 'valor') :: numeric,
            to_char ((json ->> 'fecha') :: date, 'yyyy') :: numeric
    loop

        insert into dat_dollars (
            idf_dollar,
            num_day,
            num_month,
            num_type,
            num_value,
            num_year
        ) values (
            var_rec_day.idf_dollar,
            var_rec_day.num_day,
            var_rec_day.num_month,
            1,
            var_rec_day.num_value,
            var_rec_day.num_year
        )
        on conflict (idf_dollar)
        do update set
            num_value = excluded."num_value",
            num_type = 1;

    end loop;

    select
        to_char ((json ->> 'fecha') :: date, 'yyyy') :: numeric
    into
        var_num_year
    from
        json_array_elements (var_obj_series) json
    order by
        (json ->> 'fecha') :: date
    limit 1;

    select
        to_char (now (), 'yyyy') :: numeric
    into
        var_num_actual;

    if (var_num_year = var_num_actual) then

        for var_rec_day in
            select
                to_char (generate_series (date_trunc ('year', now ()), now (), '1 day' :: interval), 'yyyymmdd') :: numeric "num_previous",
                to_char (generate_series (date_trunc ('year', now ()), now (), '1 day' :: interval), 'yyyymmdd') "txt_previous"
        loop

            select
                count (*)
            into
                var_num_registries
            from
                dat_dollars
            where
                idf_dollar = var_rec_day.num_previous;

            if (var_num_registries = 0) then

                insert into dat_dollars (
                    idf_dollar,
                    num_day,
                    num_month,
                    num_type,
                    num_value,
                    num_year
                )
                select
                    var_rec_day.num_previous,
                    to_char (var_rec_day.txt_previous :: date, 'dd') :: numeric,
                    to_char (var_rec_day.txt_previous :: date, 'mm') :: numeric,
                    2,
                    num_value,
                    to_char (var_rec_day.txt_previous :: date, 'yyyy') :: numeric
                from
                    dat_dollars
                where
                    idf_dollar <= var_rec_day.num_previous
                order by
                    idf_dollar desc
                limit 1;

            end if;

        end loop;

    else

        for var_rec_day in
            select
                to_char (generate_series (concat (var_num_year, '0101') :: date, concat (var_num_year, '1231') :: date, '1 day' :: interval), 'yyyymmdd') :: numeric "num_previous",
                to_char (generate_series (concat (var_num_year, '0101') :: date, concat (var_num_year, '1231') :: date, '1 day' :: interval), 'yyyymmdd') "txt_previous"
        loop

            select
                count (*)
            into
                var_num_registries
            from
                dat_dollars
            where
                idf_dollar = var_rec_day.num_previous;

            if (var_num_registries = 0) then

                insert into dat_dollars (
                    idf_dollar,
                    num_day,
                    num_month,
                    num_type,
                    num_value,
                    num_year
                )
                select
                    var_rec_day.num_previous,
                    to_char (var_rec_day.txt_previous :: date, 'dd') :: numeric,
                    to_char (var_rec_day.txt_previous :: date, 'mm') :: numeric,
                    2,
                    num_value,
                    to_char (var_rec_day.txt_previous :: date, 'yyyy') :: numeric
                from
                    dat_dollars
                where
                    idf_dollar <= var_rec_day.num_previous
                order by
                    idf_dollar desc
                limit 1;

            end if;

        end loop;

    end if;

    for var_rec_day in
        select
            idf_dollar,
            to_char (to_date (idf_dollar :: text, 'yyyymmdd') - '1 day' :: interval, 'yyyymmdd') :: numeric "num_previous",
            num_value
        from
            dat_dollars
        where
            num_year = var_num_year
        order by
            idf_dollar
    loop

        select
            num_value
        into
            var_num_previous
        from
            dat_dollars
        where
            idf_dollar = var_rec_day.num_previous;

        if (var_num_previous is null) then

            var_num_previous = var_rec_day.num_value;

        end if;

        update dat_dollars set
            num_absolute = var_rec_day.num_value - var_num_previous,
            num_variation = sign (var_rec_day.num_value - var_num_previous),
            num_percentage = round ((var_rec_day.num_value - var_num_previous) / var_num_previous * 100, 2)
        where
            idf_dollar = var_rec_day.idf_dollar;

    end loop;
*/
    return result_get_success (in_jsn_incoming);

exception
    when others then
        return result_get_failed (in_jsn_incoming);

end;
$body$ language plpgsql;