with
    salesorderheadersalesreason as (
        select *
        from {{ ref('stg_sap__salesorderheadersalesreason') }}
    )

    , salesorderheader as (
        select *
        from {{ ref('stg_sap__salesorderdheader') }}
    )

    , salesreason as (
        select *
        from {{ ref('stg_sap__salesreason') }}
    )

    , join_reason as (
        select 
            salesorderheadersalesreason.salesorderid           
            , salesreason.name as salesreason
            , salesreason.reasontype as salesreason_type
            , salesorderheadersalesreason.modifieddate
        from salesorderheadersalesreason
        left join salesreason
        using (salesreasonid)
    )

    , concat_reason as (
        select
            salesorderid
            , STRING_AGG(distinct(salesreason), ', ') AS salesreason_concat
            , STRING_AGG(distinct(salesreason_type), ', ') AS salesreason_type_concat
        from join_reason
        group by salesorderid

    )

select *
from concat_reason
