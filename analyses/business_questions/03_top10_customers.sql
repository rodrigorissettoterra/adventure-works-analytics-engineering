select
    customer.customer_key,
    customer.customer_name,
    customer.customer_type,
    count(distinct sales.sales_order_id) as order_count,
    sum(sales.order_quantity) as units_sold,
    sum(sales.net_sales_amount) as transaction_value
from {{ ref('fct_sales') }} as sales
left join {{ ref('dim_customer') }} as customer on sales.customer_key = customer.customer_key
group by all
order by transaction_value desc
limit 10
