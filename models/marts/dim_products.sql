with
    products as (
        select
        *
        from {{ ref('stg_sap__product') }}
    )

    , productsubcategory as (
        select
        *
        from {{ ref('stg_sap__productsubcategory') }}
    )

    , productcategory as (
        select
        *
        from {{ ref('stg_sap__productcategory') }}
    )

    , last_modifieddate as (
        select
            max(products.modifieddate) as modifieddate_products
            , max(productsubcategory.modifieddate) as modifieddate_subcategory
            , max(productcategory.modifieddate) as modifieddate_category
        from products
        left join productsubcategory
        using (productsubcategoryid)
        left join productcategory
        using (productcategoryid)
    )

    , join_product as (
        select 
            products.productid
            , products.name
            , products.productnumber
            , products.makeflag
            , products.daystomanufacture
            , products.safetystocklevel
            , products.reorderpoint
            , products.standardcost
            , products.listprice
            , products.class
            , products.style
            , products.productsubcategoryid
            , productsubcategory.name as name_subcategory
            , productsubcategory.productcategoryid
            , productcategory.name as name_category
            , products.productmodelid
            , products.sellstartdate
            , products.sellenddate
            , products.modifieddate as last_modifieddate
        from products
        left join productsubcategory
        using (productsubcategoryid)
        left join productcategory
        using (productcategoryid)
    )

    , replace_null as (
        select
            productid
            , name
            , productnumber
            , makeflag
            , daystomanufacture
            , safetystocklevel
            , reorderpoint
            , standardcost
            , listprice
            , coalesce(class,'Others') as class
            , coalesce(style,'Others') as style
            , coalesce(productsubcategoryid, 0) as productsubcategoryid
            , coalesce(name_subcategory, 'Others') as name_subcategory
            , coalesce(productcategoryid, 0) as productcategoryid
            , coalesce(name_category, 'Others') as name_category
            , productmodelid
            , sellstartdate
            , sellenddate
            , case when sellenddate is not null then False else True end as is_continued
            , last_modifieddate
        from join_product

    )

select *
from replace_null
