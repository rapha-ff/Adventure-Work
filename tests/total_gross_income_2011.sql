with 
    total_gross_income_years as (
        select
            extract(year from orderdate) as year
            , round(sum(gross_income),2) as total_gross_income
        from {{ ref('fct_sales') }}
        group by extract(year from orderdate)
    )

    , total_gross_income_2011 as (
        select 
            year
            , total_gross_income
        from total_gross_income_years
        where year = 2011 and total_gross_income <> 12646112.16
    )

select *
from total_gross_income_2011
