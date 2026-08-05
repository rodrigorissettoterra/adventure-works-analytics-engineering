with unknown_member as (
    select
        cast(-1 as bigint) as customer_key,
        cast(-1 as bigint) as customer_id,
        cast('Unknown' as string) as customer_account_number,
        cast(null as bigint) as person_id,
        cast(null as bigint) as store_id,
        cast(null as bigint) as territory_id,
        cast('Unknown' as string) as customer_type,
        cast('Unknown' as string) as customer_name,
        cast('Unknown' as string) as contact_person_name
),

customers as (
    select
        customer_id as customer_key,
        customer_id,
        customer_account_number,
        person_id,
        store_id,
        territory_id,
        customer_type,
        customer_name,
        contact_person_name
    from {{ ref('int_sales__customers') }}
)

select * from unknown_member
union all
select * from customers
