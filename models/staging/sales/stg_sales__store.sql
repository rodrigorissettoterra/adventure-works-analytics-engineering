with source as (
    select *
    from {{ source('adventure_works', 'store') }}
),

renamed as (
    select
        cast(BusinessEntityID as bigint) as store_id,
        trim(cast(Name as string)) as store_name,
        cast(SalesPersonID as bigint) as sales_person_id,
        cast(ModifiedDate as timestamp) as modified_at
    from source
)

select * from renamed
