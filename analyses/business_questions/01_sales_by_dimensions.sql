select
    sales.order_date_key,
    product.product_name,
    product.product_category_name,
    customer.customer_name,
    customer.customer_type,
    location.city,
    location.state_province_name,
    location.country_name,
    card.card_type,
    status.status_name,
    sales.sales_channel,
    count(distinct sales.sales_order_id) as order_count,
    sum(sales.order_quantity) as units_sold,
    sum(sales.net_sales_amount) as transaction_value
from {{ ref('fct_sales') }} as sales
left join {{ ref('dim_product') }} as product on sales.product_key = product.product_key
left join {{ ref('dim_customer') }} as customer on sales.customer_key = customer.customer_key
left join {{ ref('dim_location') }} as location on sales.location_key = location.location_key
left join {{ ref('dim_credit_card') }} as card on sales.credit_card_key = card.credit_card_key
left join {{ ref('dim_order_status') }} as status on sales.status_key = status.status_key
group by all
