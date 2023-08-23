with
    salesperson as (
        select *
        from {{ ref('stg_sap__salesperson') }}
    )

    , employee as (
        select *
        from {{ ref('stg_sap__employee') }}
    )

    , person as (
        select *
        from {{ ref('stg_sap__person') }}

    )

    , join_salesperson as (
        select
            salesperson.businessentityid
            , person.fullname
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
        left join person 
        using (businessentityid)
    )

select *
from join_salesperson
