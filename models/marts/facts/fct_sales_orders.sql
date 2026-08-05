with orders as (
    select * from {{ ref('int_sales__orders_enriched') }}
),

fact as (
    select
        sales_order_id,
        sales_order_number,
        cast(order_date as date) as order_date_key,
        cast(due_date as date) as due_date,
        cast(ship_date as date) as ship_date,
        coalesce(customer_id, -1) as customer_key,
        coalesce(ship_to_address_id, -1) as location_key,
        coalesce(credit_card_id, -1) as credit_card_key,
        coalesce(status_code, -1) as status_key,
        sales_channel,
        order_subtotal,
        tax_amount,
        freight_amount,
        transaction_total
    from orders
)

select * from fact
