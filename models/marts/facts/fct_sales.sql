with order_items as (
    select * from {{ ref('stg_sales__sales_order_detail') }}
),

orders as (
    select * from {{ ref('int_sales__orders_enriched') }}
),

fact as (
    select
        order_items.sales_order_detail_id,
        order_items.sales_order_id,
        cast(orders.order_date as date) as order_date_key,
        coalesce(orders.customer_id, -1) as customer_key,
        coalesce(order_items.product_id, -1) as product_key,
        coalesce(orders.ship_to_address_id, -1) as location_key,
        coalesce(orders.credit_card_id, -1) as credit_card_key,
        coalesce(orders.status_code, -1) as status_key,
        orders.sales_channel,
        order_items.special_offer_id,
        order_items.order_quantity,
        order_items.unit_price,
        order_items.unit_price_discount_pct,
        cast(order_items.order_quantity * order_items.unit_price as decimal(20, 4)) as gross_sales_amount,
        cast(
            order_items.order_quantity
            * order_items.unit_price
            * order_items.unit_price_discount_pct
            as decimal(20, 4)
        ) as discount_amount,
        cast(
            order_items.order_quantity
            * order_items.unit_price
            * (1 - order_items.unit_price_discount_pct)
            as decimal(20, 4)
        ) as net_sales_amount
    from order_items
    inner join orders
        on order_items.sales_order_id = orders.sales_order_id
)

select * from fact
