with source as (
    select *
    from {{ source('adventure_works', 'state_province') }}
),

renamed as (
    select
        cast(StateProvinceID as bigint) as state_province_id,
        trim(cast(StateProvinceCode as string)) as state_province_code,
        trim(cast(CountryRegionCode as string)) as country_region_code,
        cast(IsOnlyStateProvinceFlag as boolean) as is_only_state_province,
        trim(cast(Name as string)) as state_province_name,
        cast(TerritoryID as bigint) as territory_id,
        cast(ModifiedDate as timestamp) as modified_at
    from source
)

select * from renamed
