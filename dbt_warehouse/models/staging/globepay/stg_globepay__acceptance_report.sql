-- stg_globepay__acceptance_report.sql

with source as (
    select * from {{ source('raw_layer','src_globepay__acceptance_report') }}
),

renamed as (
    select
        -- ids
        external_ref,
        ref,

        -- strings
        source,
        country,
        currency,

        -- numerics
        amount,
        (rates::jsonb ->> currency)::float AS rate,
        amount/(rates::jsonb ->> currency)::float as amount_usd,


        -- timestamps
        to_timestamp(date_time , 'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"') as date_time, 

        -- dates
        to_timestamp(date_time, 'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"')::date AS date,

        -- booleans
        status,
        CASE
            WHEN state LIKE 'ACCEPTED' THEN TRUE
            ELSE FALSE
        END AS is_accepted,
        cvv_provided as has_cvv_provided

    from source

)

select * from renamed