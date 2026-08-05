select
    location.city,
    location.state_province_name,
    location.country_name,
    count(distinct sales.sales_order_id) as order_count,
    sum(sales.order_quantity) as units_sold,
    sum(sales.net_sales_amount) as transaction_value
from {{ ref('fct_sales') }} as sales
left join {{ ref('dim_location') }} as location on sales.location_key = location.location_key
group by all
order by transaction_value desc
limit 5
