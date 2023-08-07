with 
    source_salesorderdetail as (
        select * 
        from {{ source('sap', 'salesorderdetail') }}
    )

    , renamed as (
        select
            cast(salesorderid as int) as salesorderid
            , cast(salesorderdetailid as int) as salesorderdetailid
            , cast(orderqty as int) as orderqty
            , cast(productid as int) as productid
            , cast(specialofferid as int) as specialofferid
            , cast(unitprice as numeric) as unitprice
            , cast(unitpricediscount as numeric) as unitpricediscount
            , cast(date(modifieddate) as date) as modifieddate
            -- rowguid
            -- carriertrackingnumber
        from source_salesorderdetail
    )

select * 
from renamed
