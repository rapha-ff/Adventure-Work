with 
    sub_total_calc as (
        select salesorderid, round(sum(net_income) over(partition by salesorderid),4) as subtotal_calc
        from {{ ref('fct_sales') }}
    )

    , sub_total as (
        select salesorderid, subtotal
        from {{ ref('stg_sap__salesorderdheader') }}
    )

    , join_sub_total as (
        select *
        from sub_total_calc
        left join sub_total using (salesorderid)
    )

select *
from join_sub_total
where ABS(subtotal_calc - subtotal) > 1
