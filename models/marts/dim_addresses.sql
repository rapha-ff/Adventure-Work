with
    address as (
        select *
        from {{ ref('stg_sap__address') }}
    )

    , states_province as (
        select *
        from {{ ref('stg_sap__stateprovince') }}
    )

    , country_region as (
        select *
        from {{ ref('stg_sap__countryregion') }}
    )

    , last_modifieddate as (
        select
            max(address.modifieddate) as modifieddate_address 
            , max(states_province.modifieddate) as modifieddate_states_province
            , max(country_region.modifieddate) as modifieddate_countryregioncode
        from address
        left join states_province
        using (stateprovinceid)
        left join country_region
        using (countryregioncode)
    )

    , join_address as (
        select
            address.addressid
            , states_province.territoryid
            , address.addressline1
            , address.addressline2
            , address.city
            , address.postalcode
            , states_province.stateprovincecode
            , states_province.name as province_name
            , country_region.countryregioncode
            , country_region.name as country_name
            , states_province.isonlystateprovinceflag
            , address.modifieddate as last_modifieddate
        from address
        left join states_province
        using (stateprovinceid)
        left join country_region
        using (countryregioncode)
    )

select *
from join_address