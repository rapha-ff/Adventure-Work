with
    salesreason as (
        select *
        from {{ ref('stg_sap__salesreason') }}
    )

select *
from salesreason