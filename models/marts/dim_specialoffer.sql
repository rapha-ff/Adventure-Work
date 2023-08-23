with 
    specialoffer as (
        select 
            specialofferid
            , description
            , discountpct
            , type
            , category
            , startdate
            , enddate
            , minqty
            , maxqty
            , modifieddate
        from {{ ref('stg_sap__specialoffer') }}
)

select *
from specialoffer
