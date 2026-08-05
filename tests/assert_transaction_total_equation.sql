select
    sales_order_id,
    order_subtotal,
    tax_amount,
    freight_amount,
    transaction_total,
    transaction_total - (order_subtotal + tax_amount + freight_amount) as difference
from {{ ref('fct_sales_orders') }}
where abs(transaction_total - (order_subtotal + tax_amount + freight_amount))
    > {{ var('reconciliation_tolerance') }}
