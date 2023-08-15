with 
    specialoffer as (
        select *
        from {{ ref('stg_sap__specialoffer') }}
)

select *
from specialoffer
