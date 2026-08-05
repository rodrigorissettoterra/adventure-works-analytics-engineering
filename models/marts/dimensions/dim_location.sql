with unknown_member as (
    select
        cast(-1 as bigint) as location_key,
        cast(-1 as bigint) as address_id,
        cast('Unknown' as string) as city,
        cast('Unknown' as string) as postal_code,
        cast(null as bigint) as state_province_id,
        cast('Unknown' as string) as state_province_code,
        cast('Unknown' as string) as state_province_name,
        cast('Unknown' as string) as country_region_code,
        cast('Unknown' as string) as country_name,
        cast(null as bigint) as territory_id
),

locations as (
    select
        address_id as location_key,
        address_id,
        city,
        postal_code,
        state_province_id,
        state_province_code,
        state_province_name,
        country_region_code,
        country_name,
        territory_id
    from {{ ref('int_person__locations') }}
)

select * from unknown_member
union all
select * from locations
