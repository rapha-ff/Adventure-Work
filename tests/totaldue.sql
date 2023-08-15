with 
    sub_total_calc as (
        select 
            salesorderid
            , sum(totaldue_per_product) over (partition by salesorderid) as totaldue_per_product
        from {{ ref('fct_sales') }}
    )

    , total_due as (
        select salesorderid, round(totaldue,2) as totaldue
        from {{ ref('stg_sap__salesorderdheader') }}
    )

    , join_sub_total as (
        select 
            salesorderid
            , total_due.totaldue as totaldue
            , sub_total_calc.totaldue_per_product as totaldue_per_product
        from sub_total_calc
        left join total_due using (salesorderid)
    )

select *
from join_sub_total
where ABS(totaldue - totaldue_per_product) > 1
