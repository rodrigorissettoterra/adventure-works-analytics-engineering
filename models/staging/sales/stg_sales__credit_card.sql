with source as (
    select *
    from {{ source('adventure_works', 'credit_card') }}
),

renamed as (
    select
        cast(CreditCardID as bigint) as credit_card_id,
        cast(CardType as string) as card_type,
        cast(ModifiedDate as timestamp) as modified_at
    from source
)

select * from renamed
