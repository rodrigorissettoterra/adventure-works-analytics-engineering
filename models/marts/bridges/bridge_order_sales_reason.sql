with distinct_relationships as (
    select distinct
        sales_order_id,
        sales_reason_id
    from {{ ref('stg_sales__sales_order_header_sales_reason') }}
),

with_counts as (
    select
        sales_order_id,
        sales_reason_id,
        count(*) over (partition by sales_order_id) as reason_count
    from distinct_relationships
),

bridge as (
    select
        concat(cast(sales_order_id as string), '-', cast(sales_reason_id as string)) as order_sales_reason_key,
        sales_order_id,
        sales_reason_id as sales_reason_key,
        reason_count,
        cast(1.0 / reason_count as decimal(18, 8)) as allocation_weight
    from with_counts
)

select * from bridge
