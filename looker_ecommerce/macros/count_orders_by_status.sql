{#
    Generates one "count of orders" column per order status, e.g.
        count(distinct case when order_status = 'Complete' then order_id end) as complete_orders
    The list of statuses comes from the order_statuses variable in dbt_project.yml.
#}
{% macro count_orders_by_status(status_column='order_status', id_column='order_id') -%}
    {%- for status in var('order_statuses') %}
    count(distinct case when {{ status_column }} = '{{ status }}' then {{ id_column }} end)
        as {{ status | lower }}_orders{{ "," if not loop.last }}
    {%- endfor %}
{%- endmacro %}