with
-- Calculate weekly metrics across all areas
weekly_metrics as (
    select
        iso_date,
        measuring_week,
        iso_month,
        iso_year,
        min(filling_degree) as min_week_filling_degree,
        min(filling_twh) as min_week_filling_twh,
        max(filling_twh) as max_week_filling_twh,
        max(filling_degree) as max_week_filling_degree
    from {{ ref('reservoir_measures') }}

    group by iso_year, iso_month, measuring_week, iso_date
),

-- Calculate metrics per area and week
area_metrics as (
    select
        iso_date,
        measuring_week,
        iso_month,
        iso_year,
        area_id,
        area_type,
        area_number,
        name_long,
        name,
        current_area,
        min(filling_degree) as area_filling_degree, -- Must appear in min(), but is already lowest grain (only takes min of one number)
        min(filling_twh) as area_filling_twh -- See comment about area_filling_degree
    from {{ ref('reservoir_measures') }}

    group by iso_year, iso_month, measuring_week, iso_date, area_id, area_number, area_type, name_long, name, current_area
)

-- Combine weekly metrics with area-specific metrics
select
    a.area_id,
    a.measuring_week,
    a.iso_date,
    a.iso_month,
    a.iso_year,
    a.area_type,
    a.area_number,
    a.name_long,
    a.name,
    a.current_area,
    a.area_filling_twh,
    a.area_filling_degree,
    w.min_week_filling_degree,
    w.min_week_filling_twh,
    w.max_week_filling_degree,
    w.max_week_filling_twh
from area_metrics a

join weekly_metrics w
    ON a.iso_year = w.iso_year
    AND a.iso_month = w.iso_month
    AND a.measuring_week = w.measuring_week
    AND a.iso_date = w.iso_date

order by a.iso_year, a.iso_month, a.measuring_week, a.iso_date, a.area_id
