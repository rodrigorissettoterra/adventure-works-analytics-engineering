select
    year(sales.order_date_key) as order_year,
    month(sales.order_date_key) as order_month,
    location.city,
    location.state_province_name,
    location.country_name,
    product.product_name,
    count(distinct sales.sales_order_id) as order_count,
    sum(sales.net_sales_amount) as transaction_value,
    {{ safe_divide('sum(sales.net_sales_amount)', 'count(distinct sales.sales_order_id)') }} as avg_order_value
from {{ ref('fct_sales') }} as sales
left join {{ ref('dim_product') }} as product on sales.product_key = product.product_key
left join {{ ref('dim_location') }} as location on sales.location_key = location.location_key
group by all
order by avg_order_value desc
