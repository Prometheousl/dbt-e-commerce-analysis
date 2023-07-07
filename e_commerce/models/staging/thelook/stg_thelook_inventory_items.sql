with source as (

    select * from {{ source('thelook', 'inventory_items') }}

),

renamed as (

    select
        -- ids
        id as inventory_item_id,
        product_id,
        product_distribution_center_id

        -- strings
        product_category,
        product_name,
        product_brand,
        product_department,
        product_sku,

        -- numerics
        {{ round_price('cost') }} as cost,
        {{ round_price('product_retail_price') }} as product_retail_price,

        -- timestamps
        created_at,
        sold_at

    from source

)

select * from renamed