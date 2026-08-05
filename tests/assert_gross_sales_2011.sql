with validation as (
    select
        round(sum(gross_sales_amount), 2) as actual_value,
        cast({{ var('gross_sales_2011_expected') }} as decimal(20, 2)) as expected_value
    from {{ ref('fct_sales') }}
    where year(order_date_key) = 2011
)

select
    actual_value,
    expected_value,
    actual_value - expected_value as difference
from validation
where abs(actual_value - expected_value) > {{ var('reconciliation_tolerance') }}
