with 
    source_employee as (
        select * 
        from {{ source('sap', 'employee') }}
    )

    , renamed as (
        select
            cast(businessentityid as int) as businessentityid
            , cast(jobtitle as string) as jobtitle
            , cast(birthdate as date) as birthdate
            , cast(maritalstatus as string) as maritalstatus
            , cast(gender as string) as gender
            , cast(hiredate as date) as hiredate
            , cast(salariedflag as bool) as salariedflag
            , cast(vacationhours as int) as vacationhours
            , cast(sickleavehours as int) as sickleavehours
            , cast(currentflag as bool) as currentflag
            , cast(date(modifieddate) as date) as modifieddate
            -- rowguid,
            -- organizationnode
            -- nationalidnumber,
            -- loginid,
        from source_employee
    )

select * 
from renamed

