{{
    config(
        materialized='table'
    )
}}

SELECT
    EXTRACT(YEAR FROM a.aired_start) AS aired_year,
    a.genres AS anime_genres,
    COUNT(*) AS anime_count
FROM
    {{ ref('staging_anime') }} a
GROUP BY
    aired_year,
    anime_genres
ORDER BY
    aired_year,
    anime_count DESC

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{%if var('is_test_run', default=true)%}

LIMIT 1000

{%endif%}
