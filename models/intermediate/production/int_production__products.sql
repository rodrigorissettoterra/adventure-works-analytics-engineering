with products as (
    select * from {{ ref('stg_production__product') }}
),

subcategories as (
    select * from {{ ref('stg_production__product_subcategory') }}
),

categories as (
    select * from {{ ref('stg_production__product_category') }}
),

resolved as (
    select
        products.product_id,
        products.product_name,
        products.product_number,
        products.is_manufactured_in_house,
        products.is_finished_good,
        products.color,
        products.standard_cost,
        products.list_price,
        products.size,
        products.product_line,
        products.product_class,
        products.product_style,
        products.product_subcategory_id,
        subcategories.product_subcategory_name,
        subcategories.product_category_id,
        categories.product_category_name,
        products.sell_start_date,
        products.sell_end_date,
        products.discontinued_date
    from products
    left join subcategories
        on products.product_subcategory_id = subcategories.product_subcategory_id
    left join categories
        on subcategories.product_category_id = categories.product_category_id
)

select * from resolved
