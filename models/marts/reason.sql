with
    salesorderheadersalesreason as (
        select *
        from {{ ref('stg_sap__salesorderheadersalesreason') }}
    )

    , salesorderdetail as (
        select *
        from {{ ref('stg_sap__salesorderdetail') }}
    )

    , salesreason as (
        select *
        from {{ ref('stg_sap__salesreason') }}
    )

    , join_reason as (
        select 
            {{ dbt_utils.generate_surrogate_key(['salesorderheadersalesreason.salesorderid', 'salesorderdetail.productid']) }} as hash_salesorderid_productid
            , salesorderheadersalesreason.salesorderid
            , salesorderdetail.productid            
            , salesreason.name as salesreason
            , salesreason.reasontype as salesreason_type
            , salesorderheadersalesreason.modifieddate
        from salesorderheadersalesreason
        left join salesorderdetail
        using (salesorderid)
        left join salesreason
        using (salesreasonid)
    )

select *
from join_reason