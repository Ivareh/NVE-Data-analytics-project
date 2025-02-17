
with

source as (

    select * from {{ source('nve_db', 'magasinstatistikk_model') }}

),


renamed as (

    select
        -- ids
        id as measure_id,
        dato_id as date_id,
        area_id as area_id,

        -- decimals
        fyllingsgrad as filling_degree,
        kapasitet_twh as capacity_twh,
        fylling_twh as filling_twh,
        fyllingsgrad_forrige_uke as filling_prev_week,
        endring_fyllingsgrad as change_filling_degree,

        -- timestamps
        neste_publiseringsdato as next_publication_date

    from source
)



select * from renamed
