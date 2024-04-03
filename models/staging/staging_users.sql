WITH

source AS (
    SELECT * FROM {{ source('staging', 'users') }}
)


select * from source
