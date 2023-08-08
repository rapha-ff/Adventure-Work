with 
    source_salesperson as (
        select * 
        from {{ source('sap', 'salesperson') }}
    )

    , renamed as (
        select
            cast(businessentityid as int) as businessentityid
            , cast(territoryid as int) as territoryid
            , cast(salesquota as int) as salesquota
            , cast(bonus as int) as bonus
            , cast(commissionpct as numeric) as commissionpct
            , cast(salesytd as numeric) as salesytd
            , cast(saleslastyear as numeric) as saleslastyear
            , cast(date(modifieddate) as date) as modifieddate
            -- rowguid,
        from source_salesperson
    )

select * 
from renamed
