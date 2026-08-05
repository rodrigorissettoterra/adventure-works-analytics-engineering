select
    calendar.year,
    calendar.month_number,
    calendar.year_month,
    count(distinct sales.sales_order_id) as order_count,
    sum(sales.order_quantity) as units_sold,
    sum(sales.net_sales_amount) as transaction_value,
    {{ safe_divide('sum(sales.net_sales_amount)', 'count(distinct sales.sales_order_id)') }} as avg_order_value
from {{ ref('fct_sales') }} as sales
left join {{ ref('dim_date') }} as calendar on sales.order_date_key = calendar.date_key
group by all
order by calendar.year, calendar.month_number
