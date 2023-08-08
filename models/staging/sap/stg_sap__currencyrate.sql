with 
    source_currencyrate as (
        select * 
        from {{ source('sap', 'currencyrate') }}
    )

    , renamed as (
        select
            cast(currencyrateid as int) as currencyrateid
            , cast(date(currencyratedate) as date) as currencyratedate
            , cast(fromcurrencycode as string) as fromcurrencycode
            , cast(tocurrencycode as string) as tocurrencycode
            , cast(averagerate as numeric) as averagerate
            , cast(endofdayrate as numeric) as endofdayrate
            , cast(date(modifieddate) as date) as modifieddate
        from source_currencyrate
    )

select * 
from renamed
