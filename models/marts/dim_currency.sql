with
    currencyrate as (
        select 
            currencyrateid
            , currencyratedate
            , fromcurrencycode
            , tocurrencycode
            , averagerate
            , endofdayrate
            , modifieddate
        from {{ ref('stg_sap__currencyrate') }}
    )

select *
from currencyrate