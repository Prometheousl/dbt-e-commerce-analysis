{# Rounds a price column to 2 decimal places #}

{% macro round_price(column_name) -%}
    {{ round_float(column_name, precision=2) }}
{%- endmacro %}