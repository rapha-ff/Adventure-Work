with 
    source_specialoffer as (
        select * 
        from {{ source('sap', 'specialoffer') }}
    )

    , renamed as (
        select
            cast(specialofferid as int) as specialofferid
            , cast(description as string) as description
            , cast(discountpct as numeric) as discountpct
            , cast(type as string) as type
            , cast(category as string) as category
            , cast(date(startdate) as date) as startdate
            , cast(date(enddate) as date) as enddate
            , cast(minqty as int) as minqty
            , cast(maxqty as int) as maxqty
            , cast(date(modifieddate) as date) as modifieddate
            -- rowguid,
        from source_specialoffer
    )

select * 
from renamed
