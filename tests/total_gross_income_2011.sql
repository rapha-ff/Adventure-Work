with 
    total_gross_income_2011 as (
        select 
            extract(year from orderdate) as year
            , round(sum(gross_income),2) as total_gross_income
        from {{ ref('fct_sales') }}
        where extract(year from orderdate) = 2011
        group by extract(year from orderdate)
        having total_gross_income <> 12646112.16
    )

select *
from total_gross_income_2011