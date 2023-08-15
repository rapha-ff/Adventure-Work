with
    currencyrate as (
        select *
        from {{ ref('stg_sap__currencyrate') }}
    )

select *
from currencyrate