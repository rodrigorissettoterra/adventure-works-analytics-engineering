with source as (
    select *
    from {{ source('adventure_works', 'sales_order_detail') }}
),

renamed as (
    select
        cast(SalesOrderDetailID as bigint) as sales_order_detail_id,
        cast(SalesOrderID as bigint) as sales_order_id,
        cast(CarrierTrackingNumber as string) as carrier_tracking_number,
        cast(OrderQty as int) as order_quantity,
        cast(ProductID as bigint) as product_id,
        cast(SpecialOfferID as bigint) as special_offer_id,
        cast(UnitPrice as decimal(20, 4)) as unit_price,
        cast(UnitPriceDiscount as decimal(10, 6)) as unit_price_discount_pct,
        cast(ModifiedDate as timestamp) as modified_at
    from source
)

select * from renamed
