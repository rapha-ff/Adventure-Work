with
    salesperson as (
        select *
        from {{ ref('stg_sap__salesperson') }}
    )

    , employee as (
        select *
        from {{ ref('stg_sap__employee') }}
    )

    , join_salesperson as (
        select
            salesperson.businessentityid
            , salesperson.territoryid
            , salesperson.salesquota
            , salesperson.bonus
            , salesperson.commissionpct
            , salesperson.salesytd
            , salesperson.saleslastyear

            , employee.jobtitle
            , employee.birthdate
            , employee.maritalstatus
            , employee.gender
            , employee.hiredate
            , employee.salariedflag
            , employee.vacationhours
            , employee.sickleavehours
            , employee.currentflag
            , employee.modifieddate as last_modifieddate
        from salesperson
        left join employee
        using (businessentityid)
    )

select *
from join_salesperson