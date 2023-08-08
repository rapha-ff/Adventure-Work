with 
    source_productsubcategory as (
        select * 
        from {{ source('sap', 'productsubcategory') }}
    )

    , renamed as (
        select
            cast(productsubcategoryid as int) as productsubcategoryid
            , cast(productcategoryid as int) as productcategoryid
            , cast(name as string) as name            
            , cast(date(modifieddate) as date) as modifieddate
            -- rowguid,
        from source_productsubcategory
    )

select * 
from renamed
