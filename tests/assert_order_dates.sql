select
    sales_order_id,
    order_date_key,
    due_date,
    ship_date
from {{ ref('fct_sales_orders') }}
where due_date < order_date_key
   or (ship_date is not null and ship_date < order_date_key)
