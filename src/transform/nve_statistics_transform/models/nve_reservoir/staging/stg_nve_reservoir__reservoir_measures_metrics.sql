
with

source as (

    select * from {{ source('nve_db', 'magasinstatistikk_min_max_median_model') }}

),


renamed as (

    select
        -- ids
        id as measure_metric_id,
        area_id as area_id,

        -- integers
        maaling_uke as measuring_week,

        -- decimals
        min_fyllingsgrad as min_filling_degree,
        min_fylling_twh as min_filling_twh,
        max_fyllingsgrad as max_filling_degree,
        max_fylling_twh as max_filling_twh,
        median_fyllingsgrad as median_filling_degree,
        median_fylling_twh as median_filling_twh

    from source
)



select * from renamed
