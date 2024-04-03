WITH

source AS (
    SELECT * FROM {{ source('staging', 'anime') }}
)


select * from source
