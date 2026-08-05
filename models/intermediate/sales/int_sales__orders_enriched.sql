with orders as (
    select * from {{ ref('stg_sales__sales_order_header') }}
),

customers as (
    select * from {{ ref('int_sales__customers') }}
),

locations as (
    select * from {{ ref('int_person__locations') }}
),

credit_cards as (
    select * from {{ ref('stg_sales__credit_card') }}
),

resolved as (
    select
        orders.sales_order_id,
        orders.sales_order_number,
        orders.order_date,
        orders.due_date,
        orders.ship_date,
        orders.status_code,
        case when orders.is_online_order then 'Online' else 'Reseller' end as sales_channel,
        orders.customer_id,
        customers.customer_name,
        customers.customer_type,
        orders.ship_to_address_id,
        locations.city,
        locations.state_province_name,
        locations.country_name,
        orders.credit_card_id,
        credit_cards.card_type,
        orders.order_subtotal,
        orders.tax_amount,
        orders.freight_amount,
        orders.transaction_total
    from orders
    left join customers
        on orders.customer_id = customers.customer_id
    left join locations
        on orders.ship_to_address_id = locations.address_id
    left join credit_cards
        on orders.credit_card_id = credit_cards.credit_card_id
)

select * from resolved
