drop function if exists result_set_return;

create or replace function result_set_return (
    in in_jsn_object_1 json,
    in in_jsn_object_2 json,
    in in_jsn_object_3 json
)
returns json as $body$
begin

    return in_jsn_object_1 ::jsonb || json_build_object ('incoming', in_jsn_object_2) :: jsonb || json_build_object ('outgoing', in_jsn_object_3) :: jsonb;

end;
$body$ language plpgsql;