with 
    source_employee as (
        select * 
        from {{ source('sap', 'employee') }}
    )

    , renamed as (
        select
            businessentityid,
            nationalidnumber,
            loginid,
            jobtitle,
            birthdate,
            maritalstatus,
            gender,
            hiredate,
            salariedflag,
            vacationhours,
            sickleavehours,
            currentflag,
            rowguid,
            modifieddate,
            organizationnode
        from source_employee
    )

select * 
from renamed

