with source as (
    select * from {{ source('thelook', 'products') }}
)

select
    id                                      as product_id,
    name                                    as product_name,
    brand,
    category,
    department,
    sku,
    cast(cost as decimal(10, 2))            as cost,
    cast(retail_price as decimal(10, 2))    as retail_price,
    distribution_center_id
from source