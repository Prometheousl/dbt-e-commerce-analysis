with source as (

    select * from {{ source('thelook', 'distribution_centers') }}

),

renamed as (

    select
        id as distribution_center_id,
        name,
        latitude,
        longitude

    from source

)

select * from renamed