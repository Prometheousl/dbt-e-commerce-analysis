{% test valid_longitude(model, column_name) %}

with validation as (

    select
        {{ column_name }} as lon_field

    from {{ model }}

),

validation_errors as (

    select
        lon_field

    from validation
    -- if this is true, then even_field is actually odd!
    where lon_field < -180.0 or lon_field > 180.0

)

select *
from validation_errors

{% endtest %}