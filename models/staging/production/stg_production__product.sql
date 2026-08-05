with source as (
    select *
    from {{ source('adventure_works', 'product') }}
),

renamed as (
    select
        cast(ProductID as bigint) as product_id,
        trim(cast(Name as string)) as product_name,
        trim(cast(ProductNumber as string)) as product_number,
        cast(MakeFlag as boolean) as is_manufactured_in_house,
        cast(FinishedGoodsFlag as boolean) as is_finished_good,
        trim(cast(Color as string)) as color,
        cast(StandardCost as decimal(20, 4)) as standard_cost,
        cast(ListPrice as decimal(20, 4)) as list_price,
        trim(cast(Size as string)) as size,
        cast(ProductLine as string) as product_line,
        cast(Class as string) as product_class,
        cast(Style as string) as product_style,
        cast(ProductSubcategoryID as bigint) as product_subcategory_id,
        cast(SellStartDate as timestamp) as sell_start_date,
        cast(SellEndDate as timestamp) as sell_end_date,
        cast(DiscontinuedDate as timestamp) as discontinued_date,
        cast(ModifiedDate as timestamp) as modified_at
    from source
)

select * from renamed
