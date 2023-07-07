# Models

## Commands

* `dbt build` - builds all models
    * `dbt build --models staging` - builds all staging models
    * `dbt build --models staging.thelook.stg_thelook_products` - builds a specific staging model
* `dbt test` - runs all tests
    * `dbt test --models staging` - runs all tests for staging models
    * `dbt test --models staging.thelook.stg_thelook_products` - runs all tests for a specific staging model
    * Note that the tests are stored in [models/schema.yml](schema.yml)

## Sources

### Codegen

`dbt run-operation generate_source --args '{"schema_name": "thelook_ecommerce", "generate_columns": "true", "include_data_types": "true"}'`

## Staging

I have created one staging model for each source table. The staging models are located in the `staging` directory. The staging models are prefixed with `stg_` and are named after the source table and the database they come from. For example, the staging model for the `users` table in the `thelook` database is `stg_thelook_users.sql`.

```
-- stg_stripe__payments.sql

with

source as (

    select * from {{ source('stripe','payment') }}

),

renamed as (

    select
        -- ids
        id as payment_id,
        orderid as order_id,

        -- strings
        paymentmethod as payment_method,
        case
            when payment_method in ('stripe', 'paypal', 'credit_card', 'gift_card') then 'credit'
            else 'cash'
        end as payment_type,
        status,

        -- numerics
        amount as amount_cents,
        amount / 100.0 as amount,
        
        -- booleans
        case
            when status = 'successful' then true
            else false
        end as is_completed_payment,

        -- dates
        date_trunc('day', created) as created_date,

        -- timestamps
        created::timestamp_ltz as created_at

    from source

)

select * from renamed
```

* ✅ Renaming
* ✅ Type casting
* ✅ Basic computations (e.g. cents to dollars)
* ✅ Categorizing (using conditional logic to group values into buckets or booleans, such as in the case when statements above)
* ❌ Joins — the goal of staging models is to clean and prepare individual source conformed concepts for downstream usage. We're creating the most useful version of a source system table, which we can use as a new modular component for our project. In our experience, joins are almost always a bad idea here — they create immediate duplicated computation and confusing relationships that ripple downstream — there are occasionally exceptions though (see base models below).
* ❌ Aggregations — aggregations entail grouping, and we're not doing that at this stage. Remember - staging models are your place to create the building blocks you’ll use all throughout the rest of your project — if we start changing the grain of our tables by grouping in this layer, we’ll lose access to source data that we’ll likely need at some point. We just want to get our individual concepts

✅ Materialized as views. Looking at a partial view of our dbt_project.yml below, we can see that we’ve configured the entire staging directory to be materialized as views. As they’re not intended to be final artifacts themselves, but rather building blocks for later models, staging models should typically be materialized as views for two key reasons:

* Any downstream model (discussed more in marts) referencing our staging models will always get the freshest data possible from all of the component views it’s pulling together and materializing

* It avoids wasting space in the warehouse on models that are not intended to be queried by data consumers, and thus do not need to perform as quickly or efficiently

### Codegen

We can pass kwargs to the `generate_base_model` operation to generate a base model for a source table.

* `dbt run-operation generate_base_model --args '{"source_name": "thelook", "table_name": "users"}'`

## Web Resources

* https://docs.getdbt.com/guides/best-practices/how-we-structure/2-staging
* https://github.com/dbt-labs/dbt-codegen#generate_base_model-source