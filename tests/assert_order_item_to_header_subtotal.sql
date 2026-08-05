with item_totals as (
    select
        sales_order_id,
        round(sum(net_sales_amount), 2) as calculated_subtotal
    from {{ ref('fct_sales') }}
    group by sales_order_id
),

validation as (
    select
        orders.sales_order_id,
        item_totals.calculated_subtotal,
        round(orders.order_subtotal, 2) as source_subtotal,
        item_totals.calculated_subtotal - round(orders.order_subtotal, 2) as difference
    from {{ ref('fct_sales_orders') }} as orders
    inner join item_totals
        on orders.sales_order_id = item_totals.sales_order_id
)

select *
from validation
where abs(difference) > {{ var('reconciliation_tolerance') }}
