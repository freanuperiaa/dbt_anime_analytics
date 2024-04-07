{{
    config(
        materialized='view'
    )
}}


SELECT
    CASE
        WHEN EXTRACT(YEAR FROM CURRENT_DATE()) - EXTRACT(YEAR FROM u.birthday) BETWEEN 0 AND 12 THEN 'Child'
        WHEN EXTRACT(YEAR FROM CURRENT_DATE()) - EXTRACT(YEAR FROM u.birthday) BETWEEN 13 AND 17 THEN 'Teen'
        WHEN EXTRACT(YEAR FROM CURRENT_DATE()) - EXTRACT(YEAR FROM u.birthday) BETWEEN 18 AND 24 THEN 'Young Adult'
        WHEN EXTRACT(YEAR FROM CURRENT_DATE()) - EXTRACT(YEAR FROM u.birthday) BETWEEN 25 AND 34 THEN 'Adult'
        WHEN EXTRACT(YEAR FROM CURRENT_DATE()) - EXTRACT(YEAR FROM u.birthday) BETWEEN 35 AND 44 THEN 'Middle-Aged Adult'
        ELSE 'Senior Adult'
    END AS age_group,
    a.name AS anime_name,
    COUNT(*) AS rating_count
FROM
    anime_analytics.users u
JOIN
    anime_analytics.ratings r ON u.mal_id = r.user_id
JOIN
    anime_analytics.anime a ON r.anime_id = a.anime_id
GROUP BY
    age_group,
    anime_name
ORDER BY
    age_group,
    rating_count DESC

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{%if var('is_test_run', default=true)%}

LIMIT 1000

{%endif%}
