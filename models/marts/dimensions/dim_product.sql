with unknown_member as (
    select
        cast(-1 as bigint) as product_key,
        cast(-1 as bigint) as product_id,
        cast('Unknown' as string) as product_name,
        cast('Unknown' as string) as product_number,
        cast(null as boolean) as is_manufactured_in_house,
        cast(null as boolean) as is_finished_good,
        cast('Unknown' as string) as color,
        cast(null as decimal(20, 4)) as standard_cost,
        cast(null as decimal(20, 4)) as list_price,
        cast('Unknown' as string) as size,
        cast('Unknown' as string) as product_line,
        cast('Unknown' as string) as product_class,
        cast('Unknown' as string) as product_style,
        cast(null as bigint) as product_subcategory_id,
        cast('Unknown' as string) as product_subcategory_name,
        cast(null as bigint) as product_category_id,
        cast('Unknown' as string) as product_category_name,
        cast(null as timestamp) as sell_start_date,
        cast(null as timestamp) as sell_end_date,
        cast(null as timestamp) as discontinued_date
),

products as (
    select
        product_id as product_key,
        product_id,
        product_name,
        product_number,
        is_manufactured_in_house,
        is_finished_good,
        coalesce(color, 'Not informed') as color,
        standard_cost,
        list_price,
        coalesce(size, 'Not informed') as size,
        coalesce(product_line, 'Not informed') as product_line,
        coalesce(product_class, 'Not informed') as product_class,
        coalesce(product_style, 'Not informed') as product_style,
        product_subcategory_id,
        coalesce(product_subcategory_name, 'Not categorized') as product_subcategory_name,
        product_category_id,
        coalesce(product_category_name, 'Not categorized') as product_category_name,
        sell_start_date,
        sell_end_date,
        discontinued_date
    from {{ ref('int_production__products') }}
)

select * from unknown_member
union all
select * from products
