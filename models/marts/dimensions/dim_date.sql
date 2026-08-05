with date_bounds as (
    select
        min(cast(order_date as date)) as start_date,
        max(cast(order_date as date)) as end_date
    from {{ ref('stg_sales__sales_order_header') }}
),

date_spine as (
    select explode(sequence(start_date, end_date, interval 1 day)) as date_key
    from date_bounds
),

calendar as (
    select
        date_key,
        year(date_key) as year,
        quarter(date_key) as quarter,
        month(date_key) as month_number,
        date_format(date_key, 'MMMM') as month_name,
        date_format(date_key, 'yyyy-MM') as year_month,
        weekofyear(date_key) as week_of_year,
        dayofmonth(date_key) as day_of_month,
        dayofweek(date_key) as day_of_week_number,
        date_format(date_key, 'EEEE') as day_of_week_name,
        case when date_key = trunc(date_key, 'MM') then true else false end as is_month_start,
        case when date_key = last_day(date_key) then true else false end as is_month_end,
        case when date_key = trunc(date_key, 'YEAR') then true else false end as is_year_start,
        case when date_key = last_day(add_months(trunc(date_key, 'YEAR'), 11)) then true else false end as is_year_end
    from date_spine
)

select * from calendar
