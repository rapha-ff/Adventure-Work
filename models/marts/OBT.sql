with 
    fact as (
        select *
        from {{ ref('fct_sales') }}
    )

    , dim_products as (
        select *
        from {{ ref('dim_products') }}
    )

    , dim_salesreason as (
        select *
        from {{ ref('bridge_salesorderheader_salesreason') }}
    )

    , join_obt as (
        select *
        from fact
        left join dim_products on fact.fk_product = dim_products.productid
        left join dim_salesreason on fact.sk_sales = dim_salesreason.hash_salesorderid_productid
    )
    
select *
from join_obt
