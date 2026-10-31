-- Grain: one row per customer, with lifetime purchase stats.
with users as (
    select * from {{ ref('stg_thelook__users') }}
),

customer_orders as (
    select
        user_id,
        count(distinct order_id)    as lifetime_orders,
        sum(order_revenue)          as lifetime_revenue,
        min(created_at)             as first_order_at,
        max(created_at)             as last_order_at
    from {{ ref('fct_orders') }}
    where is_valid_order
    group by user_id
)

select
    u.user_id,
    u.age,
    case
        when u.age < 25 then '18-24'
        when u.age < 35 then '25-34'
        when u.age < 45 then '35-44'
        when u.age < 55 then '45-54'
        else '55+'
    end                                     as age_group,
    u.gender,
    u.city,
    u.state,
    u.country,
    u.traffic_source,
    u.created_at                            as signed_up_at,
    coalesce(o.lifetime_orders, 0)          as lifetime_orders,
    coalesce(o.lifetime_revenue, 0)         as lifetime_revenue,
    o.first_order_at,
    o.last_order_at,
    coalesce(o.lifetime_orders, 0) > 1      as is_repeat_customer
from users u
left join customer_orders o on u.user_id = o.user_id