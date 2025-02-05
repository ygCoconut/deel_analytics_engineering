-- transactions_missing_chargeback.sql

with

chargeback_report as  (
    select * from {{ ref('stg_globepay__chargeback_report')}}
),

acceptance_report as  (
    select * from {{ ref('stg_globepay__acceptance_report')}}
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

missing_chargeback as (
    select
        *
    from joined_reports
    where 
        not is_chargeback
)

select * from missing_chargeback 