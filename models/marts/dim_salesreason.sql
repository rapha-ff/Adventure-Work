with
    salesreason as (
        select 
            salesreasonid
            , name
            , reasontype
            , modifieddate
        from {{ ref('stg_sap__salesreason') }}
    )

select *
from salesreason