-- Grain: one row per month.
-- Answers: how are revenue, profit and order volume trending?
-- Status count columns are generated from var('order_statuses') by a macro.

{% set valid_revenue = "case when is_valid_order then order_revenue end" %}

select
    cast(date_trunc('MONTH', order_date) as date)        as order_month,
    count(distinct order_id)                             as total_orders,
    count(distinct user_id)                              as unique_customers,
    {{ count_orders_by_status() }},
    sum({{ valid_revenue }})                             as revenue,
    sum(case when is_valid_order then order_profit end)  as gross_profit,
    sum({{ valid_revenue }})
        / nullif(count(distinct case when is_valid_order then order_id end), 0) as avg_order_value
from {{ ref('fct_orders') }}
group by 1