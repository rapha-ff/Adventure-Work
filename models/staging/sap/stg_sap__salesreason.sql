with 
    source_salesreason as (
        select * 
        from {{ source('sap', 'salesreason') }}
    )

    , renamed as (
        select
            cast(salesreasonid as int) as salesreasonid
            , cast(name as string) as name
            , cast(reasontype as string) as reasontype
            , cast(date(modifieddate) as date) as modifieddate
        from source_salesreason
    )

select * 
from renamed
