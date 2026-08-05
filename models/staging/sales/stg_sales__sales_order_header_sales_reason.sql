with source as (
    select *
    from {{ source('adventure_works', 'sales_order_header_sales_reason') }}
),

renamed as (
    select
        cast(SalesOrderID as bigint) as sales_order_id,
        cast(SalesReasonID as bigint) as sales_reason_id,
        cast(ModifiedDate as timestamp) as modified_at
    from source
)

select * from renamed
