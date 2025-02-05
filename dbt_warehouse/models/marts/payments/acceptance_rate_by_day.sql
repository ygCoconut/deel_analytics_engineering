-- acceptance_rate_by_day.sql

with

acceptance_report as  (
    select * from {{ ref('stg_globepay__acceptance_report' )}}
),

acceptance_rate_by_day as (
    select 
        date,
        COUNT(*) AS total_transactions,
        COUNT(CASE WHEN is_accepted = TRUE THEN 1 END) AS accepted_transactions,
        COUNT(CASE WHEN is_accepted = TRUE THEN 1 END) * 1.0 / COUNT(*) AS acceptance_rate
    from 
        acceptance_report
    group by 
        date
    order by date desc
)

select * from acceptance_rate_by_day