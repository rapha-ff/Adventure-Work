with 
source_address as (
    select * 
    from {{ source('sap', 'address') }}
)

, renamed as (
    select
        cast(addressid as int) as addressid
        , cast(addressline1 as string) as addressline1
        , cast(addressline2 as string) as addressline2
        , cast(city as string) as city
        , cast(stateprovinceid as int) as stateprovinceid
        , cast(postalcode as string) as postalcode
        , cast(date(modifieddate) as date) as modifieddate
        -- spatiallocation,
        -- rowguid,
    from source_address
)

select * 
from renamed
