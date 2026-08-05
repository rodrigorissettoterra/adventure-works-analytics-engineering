with unknown_member as (
    select
        cast(-1 as bigint) as credit_card_key,
        cast(-1 as bigint) as credit_card_id,
        cast('Unknown / Not applicable' as string) as card_type
),

credit_cards as (
    select
        credit_card_id as credit_card_key,
        credit_card_id,
        card_type
    from {{ ref('stg_sales__credit_card') }}
)

select * from unknown_member
union all
select * from credit_cards
