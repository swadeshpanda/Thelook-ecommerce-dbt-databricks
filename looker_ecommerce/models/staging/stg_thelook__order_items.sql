with source as (
    select * from {{ source('thelook', 'order_items') }}
)

select
    id                                  as order_item_id,
    order_id,
    user_id,
    product_id,
    inventory_item_id,
    status                              as item_status,
    cast(sale_price as decimal(10, 2))  as sale_price,
    created_at,
    shipped_at,
    delivered_at,
    returned_at
from source