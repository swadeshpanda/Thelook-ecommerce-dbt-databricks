-- Grain: one row per order, with totals rolled up from its items.
with orders as (
    select * from {{ ref('stg_thelook__orders') }}
),

item_totals as (
    select
        order_id,
        count(*)            as item_count,
        sum(sale_price)     as order_revenue,
        sum(gross_profit)   as order_profit
    from {{ ref('fct_order_items') }}
    group by order_id
)

select
    o.order_id,
    o.user_id,
    o.order_status,
    o.customer_gender,
    o.created_at,
    cast(o.created_at as date)                          as order_date,
    o.shipped_at,
    o.delivered_at,
    o.returned_at,
    coalesce(t.item_count, 0)                           as item_count,
    coalesce(t.order_revenue, 0)                        as order_revenue,
    coalesce(t.order_profit, 0)                         as order_profit,
    o.order_status not in ('Cancelled', 'Returned')     as is_valid_order
from orders o
left join item_totals t on o.order_id = t.order_id