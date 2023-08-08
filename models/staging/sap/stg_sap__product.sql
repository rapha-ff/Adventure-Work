with 
    source_product as (
        select * 
        from {{ source('sap', 'product') }}
    )

    , renamed as (
        select
            cast(productid as int) as productid
            , cast(name as string) as name
            , cast(productnumber as string) as productnumber
            , cast(makeflag as bool) as makeflag
            , cast(safetystocklevel as int) as safetystocklevel
            , cast(reorderpoint as int) as reorderpoint
            , cast(standardcost as numeric) as standardcost
            , cast(listprice as numeric) as listprice
            , cast(daystomanufacture as int) as daystomanufacture
            , cast(class as string) as class
            , cast(style as string) as style
            , cast(productsubcategoryid as int) as productsubcategoryid
            , cast(productmodelid as int) as productmodelid
            , cast(date(sellstartdate) as date) as sellstartdate
            , cast(date(sellenddate) as date) as sellenddate
            , cast(date(modifieddate) as date) as modifieddate
            -- discontinueddate (todos os valores são vazios)
            -- rowguid,
            -- productline,
            -- size,
            -- sizeunitmeasurecode,
            -- weightunitmeasurecode,
            -- weight,
            -- finishedgoodsflag,
            -- color,
        from source_product
    )

select *
from renamed
where discontinueddate is not null