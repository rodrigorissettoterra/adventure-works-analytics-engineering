with source as (
    select *
    from {{ source('adventure_works', 'country_region') }}
),

renamed as (
    select
        trim(cast(CountryRegionCode as string)) as country_region_code,
        trim(cast(Name as string)) as country_name,
        cast(ModifiedDate as timestamp) as modified_at
    from source
)

select * from renamed
