with 
    source_store as (
        select * 
        from {{ source('sap', 'store') }}
    )

    , renamed as (
        select
            cast(businessentityid as int) as businessentityid
            , cast(name as string) as name
            , cast(salespersonid as int) as salespersonid
            , cast(date(modifieddate) as date) as modifieddate
            -- demographics,
            -- rowguid,
        from source_store
    )

select * 
from renamed
