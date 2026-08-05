with source as (
    select *
    from {{ source('adventure_works', 'sales_reason') }}
),

renamed as (
    select
        cast(SalesReasonID as bigint) as sales_reason_id,
        trim(cast(Name as string)) as sales_reason_name,
        trim(cast(ReasonType as string)) as sales_reason_type,
        cast(ModifiedDate as timestamp) as modified_at
    from source
)

select * from renamed
