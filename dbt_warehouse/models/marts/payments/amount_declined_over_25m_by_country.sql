-- amount_declined_over_25m_by_country.sql

with

acceptance_report as  (
    select * from {{ ref('stg_globepay__acceptance_report' )}}
),

chargeback_report as  (
    select * from {{ ref('stg_globepay__chargeback_report' )}}
),

joined_reports as (
    select 
        ar.*,
        cr.is_chargeback
    from acceptance_report ar
    left join 
        chargeback_report cr
        using (external_ref)
),

accepted_amount as (
    select
        round(sum(amount_usd)::numeric,2) as amount_usd,
        country
    from joined_reports
    where 
        not is_accepted
    group by country
),

thresholded_amount as (
    select 
        *
    from accepted_amount
    where amount_usd > 25000000
    order by amount_usd desc
)

select * from thresholded_amount 