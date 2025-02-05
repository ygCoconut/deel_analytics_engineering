-- stg_globepay__chargeback_report.sql

with source as (
    select * from {{ source('raw_layer', 'src_globepay__chargeback_report') }}
),

renamed as (
    select
        -- ids
        external_ref,

        -- strings
        source,

        -- booleans
        chargeback as is_chargeback,
        status

    from source

)

select * from renamed