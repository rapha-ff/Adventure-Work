with 
source_specialofferproduct as (
    select * 
    from {{ source('sap', 'specialofferproduct') }}
)

, renamed as (
    select
        cast(specialofferid as int) as specialofferid
        , cast(productid as int) as productid
        , cast(date(modifieddate) as date) as modifieddate
        -- rowguid,
    from source_specialofferproduct
)

select * 
from renamed
