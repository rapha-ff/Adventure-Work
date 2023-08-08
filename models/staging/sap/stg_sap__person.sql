with 
    source_person as (
        select * 
        from {{ source('sap', 'person') }}
    )

    , renamed as (
        select
            cast(businessentityid as int) as businessentityid
            , cast(persontype as string) as persontype
            , cast(firstname as string) as firstname
            , cast(middlename as string) as middlename
            , cast(lastname as string) as lastname
            , cast(case when middlename is null then concat(firstname, ' ',lastname)
            else concat(firstname, ' ',middlename, ' ', lastname) end as string )as fullname
            , cast(emailpromotion as int) as emailpromotion
            , cast(date(modifieddate) as date) as modifieddate
            -- additionalcontactinfo
            -- namestyle,
            -- title,
            -- demographics,
            -- rowguid,
            -- suffix,
        from source_person
    )

select * 
from renamed
