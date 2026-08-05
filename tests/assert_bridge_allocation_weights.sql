with weights as (
    select
        sales_order_id,
        round(sum(allocation_weight), 6) as total_weight
    from {{ ref('bridge_order_sales_reason') }}
    group by sales_order_id
)

select *
from weights
where abs(total_weight - 1) > 0.000001
