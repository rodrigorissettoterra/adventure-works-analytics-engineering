with source as (
    select *
    from {{ source('adventure_works', 'customer') }}
),

renamed as (
    select
        cast(CustomerID as bigint) as customer_id,
        cast(PersonID as bigint) as person_id,
        cast(StoreID as bigint) as store_id,
        cast(TerritoryID as bigint) as territory_id,
        concat('AW', lpad(cast(CustomerID as string), 8, '0')) as customer_account_number,
        cast(ModifiedDate as timestamp) as modified_at
    from source
)

select * from renamed
