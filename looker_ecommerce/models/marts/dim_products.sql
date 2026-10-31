-- Grain: one row per product.
select
    p.product_id,
    p.product_name,
    p.brand,
    p.category,
    p.department,
    p.sku,
    p.cost,
    p.retail_price,
    p.retail_price - p.cost         as unit_margin,
    p.distribution_center_id,
    dc.distribution_center_name
from {{ ref('stg_thelook__products') }} p
left join {{ ref('stg_thelook__distribution_centers') }} dc
    on p.distribution_center_id = dc.distribution_center_id