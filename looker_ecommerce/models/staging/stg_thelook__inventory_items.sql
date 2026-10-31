with source as (
    select * from {{ source('thelook', 'inventory_items') }}
)

select
    id                                              as inventory_item_id,
    product_id,
    cast(cost as decimal(10, 2))                    as cost,
    product_category,
    product_name,
    product_brand,
    product_department,
    cast(product_retail_price as decimal(10, 2))    as product_retail_price,
    product_distribution_center_id                  as distribution_center_id,
    created_at,
    sold_at
from source
