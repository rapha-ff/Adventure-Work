with
    salesorderheadersalesreason as (
        select *
        from {{ ref('stg_sap__salesorderheadersalesreason') }}
    )

    , salesorderdetail as (
        select *
        from {{ ref('stg_sap__salesorderdetail') }}
    )

    , join_bridge as (
        select 
            {{ dbt_utils.generate_surrogate_key(['salesorderheadersalesreason.salesorderid', 'salesorderdetail.productid']) }}
            , salesorderheadersalesreason.salesorderid
            , salesorderdetail.productid
            , salesorderheadersalesreason.salesreasonid
            , salesorderheadersalesreason.modifieddate
        from salesorderheadersalesreason
        left join salesorderdetail
        using (salesorderid)
    )

select *
from join_bridge