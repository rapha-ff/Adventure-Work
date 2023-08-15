with 
source_salesorderheadersalesreason as (
    select * 
    from {{ source('sap', 'salesorderheadersalesreason') }}
)

, renamed as (
    select
        cast(salesorderid as int) as salesorderid
        , cast(salesreasonid as int) as salesreasonid
        , cast(date(modifieddate) as date) as modifieddate
    from source_salesorderheadersalesreason
)

select * 
from renamed
