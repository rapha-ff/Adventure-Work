with
    customers as (
        select *
        from {{ ref('stg_sap__customer') }}
    )

    , person as (
        select *
        from {{ ref('stg_sap__person') }}

    )

    , stores as (
        select * 
        from {{ ref('stg_sap__store') }}
    )

    , last_modifieddate as (
        select
            max(customers.modifieddate) as modifieddate_customers 
            , max(person.modifieddate) as modifieddate_person
            , max(stores.modifieddate) as modifieddate_stores
        from customers
        left join person
        on customers.personid = person.businessentityid
        left join stores
        on customers.storeid = stores.businessentityid
    )

    , join_customers as (
        select
            customers.customerid
            , customers.personid
            , customers.storeid
            , customers.territoryid
            , person.persontype
            , person.fullname
            , person.emailpromotion
            , stores.name as store_name
            , stores.salespersonid
            , person.modifieddate as last_modifieddate
        from customers
        left join person
        on customers.personid = person.businessentityid
        left join stores
        on customers.storeid = stores.businessentityid
    )

select *
from join_customers