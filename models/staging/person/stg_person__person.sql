with source as (
    select *
    from {{ source('adventure_works', 'person') }}
),

renamed as (
    select
        cast(BusinessEntityID as bigint) as person_id,
        trim(cast(PersonType as string)) as person_type,
        trim(cast(Title as string)) as title,
        trim(cast(FirstName as string)) as first_name,
        trim(cast(MiddleName as string)) as middle_name,
        trim(cast(LastName as string)) as last_name,
        trim(cast(Suffix as string)) as suffix,
        cast(EmailPromotion as int) as email_promotion_code,
        cast(ModifiedDate as timestamp) as modified_at
    from source
)

select * from renamed
