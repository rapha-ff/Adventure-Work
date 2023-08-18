with 
    salesorderheader as (
        select *
        from {{ ref('stg_sap__salesorderdheader') }}
    )

    , salesorderdetail as (
        select *
        from {{ ref('stg_sap__salesorderdetail') }}
    )

    , creditcard as (
        select *
        from {{ ref('stg_sap__creditcard') }}
    )

    , last_modifieddate as (
        select
            max(salesorderheader.modifieddate) as modifieddate_salesorderheader
            , max(creditcard.modifieddate) as modifieddate_creditcard
            , max(salesorderdetail.modifieddate) as modifieddate_salesorderdetail
        from salesorderheader
        left join creditcard 
        using (creditcardid)
        left join salesorderdetail
        using (salesorderid)
    )

    , join_sales as (
        select 
            {{ dbt_utils.generate_surrogate_key(['salesorderheader.salesorderid', 'salesorderdetail.productid']) }} as sk_sales
            , salesorderheader.salesorderid
            , salesorderheader.orderdate
            , salesorderheader.duedate
            , salesorderheader.shipdate
            , salesorderheader.status as status_id
            , salesorderheader.is_orderonline
            , salesorderheader.customerid
            , salesorderheader.salespersonid
            , salesorderheader.territoryid
            , salesorderheader.billtoaddressid
            , salesorderheader.shiptoaddressid
            , salesorderheader.shipmethodid
            , salesorderheader.creditcardid
            , creditcard.CardType as CardType_with_null
            , salesorderheader.currencyrateid
            , salesorderheader.subtotal
            , salesorderheader.taxamt
            , salesorderheader.freight
            , salesorderheader.totaldue
            , salesorderheader.modifieddate as last_modifieddate
            , salesorderdetail.productid
            , salesorderdetail.orderqty
            , salesorderdetail.specialofferid
            , salesorderdetail.unitprice
            , salesorderdetail.unitpricediscount
        from salesorderheader
        left join creditcard 
        using (creditcardid)
        left join salesorderdetail
        using (salesorderid)
    )

    , metrics as (
        select
            *
        , date_diff(shipdate, orderdate, day) as time_to_ship
        , date_diff(duedate, shipdate, day) as shipped_to_required
        , date_diff(duedate, orderdate, day) as order_to_required
        , case  when status_id = 1 then 'In process'
                when status_id = 2 then 'Approved'
                when status_id = 3 then 'Backordered'
                when status_id = 4 then 'Rejected'
                when status_id = 5 then 'Shipped'
                when status_id = 6 then 'Cancelled'
                else 'Others' end as status
        , (unitprice * orderqty) as gross_income
        , (unitprice * orderqty * (1-unitpricediscount)) as net_income
        , (unitprice * orderqty * unitpricediscount) as total_discount
        , round((freight/(count(*) over(partition by salesorderid))),2) as freight_per_product
        , round((taxamt/(count(*) over(partition by salesorderid))),2) as taxamt_per_product
        , round((unitprice * orderqty * (1-unitpricediscount)) + (freight/(count(*) over(partition by salesorderid))) + (taxamt/(count(*) over(partition by salesorderid))),2) as totaldue_per_product
        , coalesce(CardType_with_null,'Uninformed') as Cardtype
        from join_sales     
    )

    , final as (
        select 
            sk_sales
            , productid as fk_product
            , customerid as fk_customer
            , salespersonid as fk_salesperson
            , billtoaddressid as fk_billtoaddress
            , currencyrateid as fk_currencyrate
            , specialofferid as fk_specialoffer
            , salesorderid
            , territoryid
            , shiptoaddressid

            , orderqty
            , unitprice
            , unitpricediscount
            , gross_income
            , net_income

            , total_discount
            , freight_per_product
            , taxamt_per_product
            , totaldue_per_product
            , time_to_ship
            , shipped_to_required
            , order_to_required

            , orderdate
            , duedate
            , shipdate
            , last_modifieddate
            
            , status
            , shipmethodid as shipmethod
            , creditcardid
            , CardType
            , is_orderonline
        from metrics
    )

select *
from final
