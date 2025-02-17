

with

source as (

    select * from {{ source('nve_db', 'dates') }}

),


renamed as (

    select
        -- ids
        id as date_id,

        -- dates
        iso_dato as iso_date,

        -- integers
        iso_aar as iso_year,
        maaling_uke as measuring_week,
        iso_maaned as iso_month,
        iso_dag as  iso_day

    from source
)



select * from renamed

