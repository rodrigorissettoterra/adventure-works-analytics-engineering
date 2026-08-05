with customers as (
    select * from {{ ref('stg_sales__customer') }}
),

people as (
    select * from {{ ref('stg_person__person') }}
),

stores as (
    select * from {{ ref('stg_sales__store') }}
),

resolved as (
    select
        customers.customer_id,
        customers.customer_account_number,
        customers.person_id,
        customers.store_id,
        customers.territory_id,
        case
            when customers.store_id is not null then 'Store'
            else 'Individual'
        end as customer_type,
        case
            when customers.store_id is not null then stores.store_name
            else concat_ws(' ', people.first_name, people.middle_name, people.last_name)
        end as customer_name,
        concat_ws(' ', people.first_name, people.middle_name, people.last_name) as contact_person_name
    from customers
    left join people
        on customers.person_id = people.person_id
    left join stores
        on customers.store_id = stores.store_id
)

select * from resolved
