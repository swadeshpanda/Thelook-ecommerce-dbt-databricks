with source as (
    select * from {{ source('thelook', 'events') }}
)

select
    id                          as event_id,
    cast(user_id as bigint)     as user_id,   -- null for anonymous visitors
    session_id,
    sequence_number,
    event_type,
    uri,
    browser,
    traffic_source,
    city,
    state,
    created_at
from source
