WITH

source AS (
    SELECT * FROM {{ source('staging', 'users') }}
)


select * from source


-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{%if var('is_test_run', default=true)%}

LIMIT 1000

{%endif%}
