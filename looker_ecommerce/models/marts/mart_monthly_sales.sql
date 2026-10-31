-- Grain: one row per month.
-- Answers: how are revenue, profit and order volume trending?
select
    cast(date_trunc('MONTH', order_date) as date)                               as order_month,
    count(distinct order_id)                                                    as total_orders,
    count(distinct user_id)                                                     as unique_customers,
    count(distinct case when order_status = 'Complete'   then order_id end)     as complete_orders,
    count(distinct case when order_status = 'Shipped'    then order_id end)     as shipped_orders,
    count(distinct case when order_status = 'Processing' then order_id end)     as processing_orders,
    count(distinct case when order_status = 'Cancelled'  then order_id end)     as cancelled_orders,
    count(distinct case when order_status = 'Returned'   then order_id end)     as returned_orders,
    sum(case when is_valid_order then order_revenue end)                        as revenue,
    sum(case when is_valid_order then order_profit end)                         as gross_profit,
    sum(case when is_valid_order then order_revenue end)
        / nullif(count(distinct case when is_valid_order then order_id end), 0) as avg_order_value
from {{ ref('fct_orders') }}
group by 1