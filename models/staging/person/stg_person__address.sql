with source as (
    select *
    from {{ source('adventure_works', 'address') }}
),

renamed as (
    select
        cast(AddressID as bigint) as address_id,
        trim(cast(City as string)) as city,
        cast(StateProvinceID as bigint) as state_province_id,
        trim(cast(PostalCode as string)) as postal_code,
        cast(ModifiedDate as timestamp) as modified_at
    from source
)

select * from renamed
