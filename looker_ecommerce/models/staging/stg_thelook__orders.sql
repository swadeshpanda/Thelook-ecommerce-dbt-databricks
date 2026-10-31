with source as (
    select * from {{ source('thelook', 'orders') }}
)

select
    order_id,
    user_id,
    status          as order_status,
    gender          as customer_gender,
    num_of_item     as num_items,
    created_at,
    shipped_at,
    delivered_at,
    returned_at
from source