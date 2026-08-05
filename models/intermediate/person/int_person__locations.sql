with addresses as (
    select * from {{ ref('stg_person__address') }}
),

states as (
    select * from {{ ref('stg_person__state_province') }}
),

countries as (
    select * from {{ ref('stg_person__country_region') }}
),

resolved as (
    select
        addresses.address_id,
        addresses.city,
        addresses.postal_code,
        addresses.state_province_id,
        states.state_province_code,
        states.state_province_name,
        states.country_region_code,
        countries.country_name,
        states.territory_id
    from addresses
    left join states
        on addresses.state_province_id = states.state_province_id
    left join countries
        on states.country_region_code = countries.country_region_code
)

select * from resolved
