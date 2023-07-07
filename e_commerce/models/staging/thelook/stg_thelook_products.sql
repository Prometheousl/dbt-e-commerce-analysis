-- stg_thelook_products.sql

with source as (

    select * from {{ source('thelook', 'products') }}

),

renamed as (

    select
        -- ids
        id as product_id,
        distribution_center_id,

        -- strings
        category,
        name,
        brand,
        department,
        sku,

        -- numerics
        {{ round_price('cost') }} as cost,
        {{ round_price('retail_price') }} as retail_price

    from source

)

select * from renamed