WITH

source AS (
    SELECT * FROM {{ source('staging', 'ratings') }}
)


select * from source
