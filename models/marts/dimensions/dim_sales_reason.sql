with reasons as (
    select
        sales_reason_id as sales_reason_key,
        sales_reason_id,
        sales_reason_name,
        sales_reason_type
    from {{ ref('stg_sales__sales_reason') }}
)

select * from reasons
