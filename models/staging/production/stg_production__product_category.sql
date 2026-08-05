with source as (
    select *
    from {{ source('adventure_works', 'product_category') }}
),

renamed as (
    select
        cast(ProductCategoryID as bigint) as product_category_id,
        trim(cast(Name as string)) as product_category_name,
        cast(ModifiedDate as timestamp) as modified_at
    from source
)

select * from renamed
