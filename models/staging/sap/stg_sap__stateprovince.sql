with 
    source_stateprovince as (
        select * 
        from {{ source('sap', 'stateprovince') }}
    )

    , renamed as (
        select
            cast(stateprovinceid as int) as stateprovinceid
            , cast(stateprovincecode as string) as stateprovincecode
            , cast(countryregioncode as string) as countryregioncode
            , cast(isonlystateprovinceflag as bool) as isonlystateprovinceflag
            , cast(name as string) as name
            , cast(territoryid as int) as territoryid
            , cast(date(modifieddate) as date) as modifieddate
            -- rowguid,
        from source_stateprovince
    )

select * 
from renamed
