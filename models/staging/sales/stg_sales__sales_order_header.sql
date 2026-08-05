with source as (
    select *
    from {{ source('adventure_works', 'sales_order_header') }}
),

renamed as (
    select
        cast(SalesOrderID as bigint) as sales_order_id,
        cast(RevisionNumber as int) as revision_number,
        cast(OrderDate as timestamp) as order_date,
        cast(DueDate as timestamp) as due_date,
        cast(ShipDate as timestamp) as ship_date,
        cast(Status as int) as status_code,
        cast(OnlineOrderFlag as boolean) as is_online_order,
        concat('SO', cast(SalesOrderID as string)) as sales_order_number,
        cast(PurchaseOrderNumber as string) as purchase_order_number,
        cast(CustomerID as bigint) as customer_id,
        cast(SalesPersonID as bigint) as sales_person_id,
        cast(TerritoryID as bigint) as territory_id,
        cast(BillToAddressID as bigint) as bill_to_address_id,
        cast(ShipToAddressID as bigint) as ship_to_address_id,
        cast(ShipMethodID as bigint) as ship_method_id,
        cast(CreditCardID as bigint) as credit_card_id,
        cast(CurrencyRateID as bigint) as currency_rate_id,
        cast(SubTotal as decimal(20, 4)) as order_subtotal,
        cast(TaxAmt as decimal(20, 4)) as tax_amount,
        cast(Freight as decimal(20, 4)) as freight_amount,
        cast(TotalDue as decimal(20, 4)) as transaction_total,
        cast(ModifiedDate as timestamp) as modified_at
    from source
)

select * from renamed
