with 
    source_creditcard as (
        select * 
        from {{ source('sap', 'creditcard') }}
    )

    , renamed as (
        select
            cast(creditcardid as int) as creditcardid
            , cast(cardtype as string) as cardtype
            , cast(date(modifieddate) as date) as modifieddate
            -- cardnumber,
            -- expmonth,
            -- expyear,
        from source_creditcard
    )

select * 
from renamed
