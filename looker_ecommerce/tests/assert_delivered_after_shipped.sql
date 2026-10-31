-- An item cannot be delivered before it was shipped.
-- Returns the rows that break the rule: zero rows = pass.
select
    order_item_id,
    shipped_at,
    delivered_at
from {{ ref('stg_thelook__order_items') }}
where delivered_at < shipped_at