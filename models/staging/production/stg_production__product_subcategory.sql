with source as (
    select *
    from {{ source('adventure_works', 'product_subcategory') }}
),

renamed as (
    select
        cast(ProductSubcategoryID as bigint) as product_subcategory_id,
        cast(ProductCategoryID as bigint) as product_category_id,
        trim(cast(Name as string)) as product_subcategory_name,
        cast(ModifiedDate as timestamp) as modified_at
    from source
)

select * from renamed
