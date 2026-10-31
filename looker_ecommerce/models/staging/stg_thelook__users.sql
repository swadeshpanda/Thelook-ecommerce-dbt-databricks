with source as (
    select * from {{ source('thelook', 'users') }}
)

select
    id              as user_id,
    age,
    gender,
    city,
    state,
    country,
    latitude,
    longitude,
    traffic_source,
    created_at
from source
-- first_name, last_name, email and street_address are deliberately excluded (PII not needed for analysis)