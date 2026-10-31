-- Grain: one row per department and category.
-- Answers: which categories make the most profit, and which get returned most?
select
    department,
    category,
    count(*)                                                        as items_sold,
    sum(sale_price)                                                 as revenue,
    sum(gross_profit)                                               as gross_profit,
    round(sum(gross_profit) / nullif(sum(sale_price), 0), 3)        as profit_margin,
    round(avg(case when is_returned then 1.0 else 0 end), 3)        as return_rate
from {{ ref('fct_order_items') }}
where item_status <> 'Cancelled'
group by department, category