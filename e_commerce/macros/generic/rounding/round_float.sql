{# Rounds a float to precision amount of decimal places #}

-- The docs use ::numeric to cast to a numeric type, 
-- but this is not supported in BigQuery. 

{% macro round_float(column_name, precision=2) -%}
    round({{column_name}}, {{precision}})
{%- endmacro %}