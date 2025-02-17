

with

dates as (
    select * from {{ ref('stg_nve_reservoir__dates') }}
),


reservoir_measures as (
    select *
    from {{ ref('stg_nve_reservoir__reservoir_measures') }} as rm

    left join dates using (date_id)
)

select * from reservoir_measures

