with 
    source_customer as (
        select * 
        from {{ source('sap', 'customer') }}
    )

    , renamed as (
        select
            cast(customerid as int) as customerid
            , cast(personid as int) as personid
            , cast(storeid as int) as storeid
            , cast(territoryid as int) as territoryid
            , cast(date(modifieddate) as date) as modifieddate
            -- rowguid
        from source_customer
    )

select * 
from renamed
