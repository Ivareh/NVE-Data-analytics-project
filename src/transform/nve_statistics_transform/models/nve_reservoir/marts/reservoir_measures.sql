

with

dates as (
    select * from {{ ref('stg_nve_reservoir__dates') }}
),

areas as (
    select * from {{ ref('stg_nve_reservoir__areas') }}
),


reservoir_measures as (
    select *
    from {{ ref('stg_nve_reservoir__reservoir_measures') }} as rm

    left join dates using (date_id)
    left join areas using (area_id)
)

select * from reservoir_measures
