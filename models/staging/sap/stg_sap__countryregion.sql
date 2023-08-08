with 
    source_countryregion as (
        select * 
        from {{ source('sap', 'countryregion') }}
    )

    , renamed as (
        select
            cast(countryregioncode as string) as countryregioncode
            , cast(name as string) as name
            , cast(date(modifieddate) as date) as modifieddate
        from source_countryregion
    )

select * from renamed
