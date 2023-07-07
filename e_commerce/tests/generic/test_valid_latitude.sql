{% test valid_latitude(model, column_name) %}

with validation as (

    select
        {{ column_name }} as lat_field

    from {{ model }}

),

validation_errors as (

    select
        lat_field

    from validation
    -- if this is true, then even_field is actually odd!
    where lat_field < -90.0 or lat_field > 90.0

)

select *
from validation_errors

{% endtest %}