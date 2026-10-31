-- Grain: one row per order item.
-- Adds the real unit cost (from inventory) and product attributes to each item sold.
with order_items as (
    select * from {{ ref('stg_thelook__order_items') }}
),

inventory as (
    select inventory_item_id, cost
    from {{ ref('stg_thelook__inventory_items') }}
),

products as (
    select product_id, product_name, brand, category, department, distribution_center_id
    from {{ ref('stg_thelook__products') }}
)

select
    oi.order_item_id,
    oi.order_id,
    oi.user_id,
    oi.product_id,
    oi.item_status,
    oi.created_at,
    oi.shipped_at,
    oi.delivered_at,
    oi.returned_at,
    oi.sale_price,
    inv.cost,
    p.product_name,
    p.brand,
    p.category,
    p.department,
    p.distribution_center_id
from order_items oi
left join inventory inv on oi.inventory_item_id = inv.inventory_item_id
left join products p on oi.product_id = p.product_id