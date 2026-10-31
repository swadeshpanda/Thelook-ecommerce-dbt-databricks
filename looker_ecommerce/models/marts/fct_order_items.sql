-- Grain: one row per item sold. Central fact table for revenue and profit.
select
    order_item_id,
    order_id,
    user_id,
    product_id,
    product_name,
    brand,
    category,
    department,
    distribution_center_id,
    item_status,
    created_at,
    cast(created_at as date)                       as order_date,
    delivered_at,
    sale_price,
    cost,
    sale_price - cost                              as gross_profit,
    datediff(delivered_at, created_at)             as days_to_deliver,
    item_status = 'Returned'                       as is_returned
from {{ ref('int_order_items__enriched') }}