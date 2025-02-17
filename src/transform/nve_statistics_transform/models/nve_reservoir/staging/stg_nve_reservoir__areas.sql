

with

source as (

    select * from {{ source('nve_db', 'area') }}

),


renamed as (

    select
        -- ids
        id as area_id,

        -- strings
        navn as name,
        navn_langt as name_long,
        beskrivelse as description,
        omr_type as area_type,
        current_area as current_area,

        -- integers
        omrnr as area_number

    from source
)



select * from renamed

