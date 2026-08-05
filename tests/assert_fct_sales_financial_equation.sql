select
    sales_order_detail_id,
    gross_sales_amount,
    discount_amount,
    net_sales_amount,
    net_sales_amount - (gross_sales_amount - discount_amount) as difference
from {{ ref('fct_sales') }}
where abs(net_sales_amount - (gross_sales_amount - discount_amount))
    > {{ var('reconciliation_tolerance') }}
