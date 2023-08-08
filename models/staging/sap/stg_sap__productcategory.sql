with 
    source_productcategory as (
        select * 
        from {{ source('sap', 'productcategory') }}
    )

    , renamed as (
        select
            cast(productcategoryid as int) as productcategoryid
            , cast(name as string) as name
            , cast(date(modifieddate) as date) as modifieddate
            -- rowguid,
        from source_productcategory 
    )

select * 
from renamed
