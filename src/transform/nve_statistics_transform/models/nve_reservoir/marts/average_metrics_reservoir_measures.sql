{%- set area_ids = range(1, 11) -%}
{%- set metrics = ['filling_degree', 'capacity_twh', 'filling_twh', 'filling_prev_week'] -%}

with

reservoir_measures as (
    select * from {{ ref('stg_nve_reservoir__reservoir_measures') }}
),

date as (
    select * from {{ ref('stg_nve_reservoir__dates') }}
),

average_metrics_reservoir_measures as (
    select
        date.iso_day,
        date.measuring_week,
        date.iso_month,
        date.iso_year,

        {% for metric in metrics -%}
            avg({{ metric }}) as total_mean_{{ metric }}{% if not loop.last %},
        {% endif %}{%- endfor %}

    from reservoir_measures

    inner join date on date.date_id = reservoir_measures.date_id

    group by (date.iso_day, date.measuring_week, date.iso_month, date.iso_year)
)


select * from average_metrics_reservoir_measures

