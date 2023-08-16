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

    , metrics as (
        select
        *
        , case  when persontype = 'SC' then 'Store Contact'
                when persontype = 'IN' then 'Individual (retail) customer'
                when persontype = 'SP' then 'Sales person'
                when persontype = 'EM' then 'Employee (non-sales)'
                when persontype = 'VC' then 'Vendor contact'
                when persontype = 'GC' then 'General contact'
                else 'store' end as customer_type
        , case  when persontype = 'SC' then store_name
                when persontype = 'IN' then fullname
                when persontype = 'SP' then fullname
                when persontype = 'EM' then fullname
                when persontype = 'VC' then fullname
                when persontype = 'GC' then fullname
                else store_name end as final_customer
        from join_customers
    )

select *
from metrics
