-- stg_thelook_users.sql


with source as (

    select * from {{ source('thelook', 'users') }}

),

renamed as (

    select
        -- ids
        id as user_id,

        -- strings
        first_name,
        last_name,
        email,
        gender,
        state,
        street_address,
        postal_code,
        city,
        country,
        traffic_source,

        -- numerics
        age,
        latitude,
        longitude,

        -- timestamps
        created_at

    from source

),

filtered as (
    
        select * from renamed
        where user_id is not null
)

select * from filtered