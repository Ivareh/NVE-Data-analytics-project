{%- set area_ids = range(1, 11) -%}
{%- set metrics = ['filling_degree', 'capacity_twh', 'filling_twh', 'filling_prev_week'] -%}

with

reservoir_measures as (
    select * from {{ ref('stg_nve_reservoir__reservoir_measures') }}
),

date as (
    select * from {{ ref('stg_nve_reservoir__dates') }}
),

pivot_measures_to_order_areas as (
    select
        date.iso_day,
        date.measuring_week,
        date.iso_month,
        date.iso_year,
        {% for metric in metrics -%}
            {{ generate_area_avgs(metric, area_ids) }},
            avg({{ metric }}) as total_mean_{{ metric }}
            {% if not loop.last %},{% endif %} -- fixes trail comma
        {%- endfor %}
    from reservoir_measures

    inner join date on date.date_id = reservoir_measures.date_id

    group by (date.iso_day, date.measuring_week, date.iso_month, date.iso_year)
)


select * from pivot_measures_to_order_areas
