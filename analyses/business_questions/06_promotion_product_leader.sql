with promotion_orders as (
    select distinct bridge.sales_order_id
    from {{ ref('bridge_order_sales_reason') }} as bridge
    inner join {{ ref('dim_sales_reason') }} as reason
        on bridge.sales_reason_key = reason.sales_reason_key
    where lower(reason.sales_reason_type) = 'promotion'
)

select
    product.product_name,
    product.product_subcategory_name,
    product.product_category_name,
    count(distinct sales.sales_order_id) as order_count,
    sum(sales.order_quantity) as units_sold,
    sum(sales.net_sales_amount) as transaction_value
from {{ ref('fct_sales') }} as sales
inner join promotion_orders
    on sales.sales_order_id = promotion_orders.sales_order_id
left join {{ ref('dim_product') }} as product
    on sales.product_key = product.product_key
group by all
order by units_sold desc, transaction_value desc
limit 1
