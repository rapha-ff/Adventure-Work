with 
    source_salesorderheader as (
        select * 
        from {{ source('sap', 'salesorderheader') }}
    )

    , renamed as (
        select 
            cast(salesorderid as int) as salesorderid
            , cast(date(orderdate) as date) as orderdate
            , cast(date(duedate) as date) as duedate
            , cast(date(shipdate) as date) as shipdate
            , cast(status as int) as status
            , cast(onlineorderflag as bool) as onlineorderflag
            , cast(customerid as int) as customerid
            , cast(salespersonid as int) as salespersonid
            , cast(territoryid as int) as territoryid
            , cast(billtoaddressid as int) as billtoaddressid
            , cast(shiptoaddressid as int) as shiptoaddressid
            , cast(shipmethodid as int) as shipmethodid
            , cast(creditcardid as int) as creditcardid
            , cast(currencyrateid as int) as currencyrateid
            , cast(subtotal as numeric) as subtotal
            , cast(taxamt as numeric) as taxamt
            , cast(freight as numeric) as freight
            , cast(totaldue as numeric) as totaldue
            , cast(date(modifieddate) as date) as modifieddate
            -- revisionnumber
            --comment
            --rowguid
            --creditcardapprovalcode
            --purchaseordernumber
            --accountnumber
        from source_salesorderheader
    )

select * 
from renamed
