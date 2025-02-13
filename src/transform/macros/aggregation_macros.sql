{# Generates area_id columns with averages for column_name's metrics #}

{% macro generate_area_avgs(column_name, area_ids) -%}
    {%- for area_id in area_ids -%}
        avg(
            case
                when area_id = {{ area_id }}
                then {{ column_name }}
            end
        ) as area_id_{{ area_id }}_mean_{{ column_name }}
        {%- if not loop.last %},{% endif %}
    {%- endfor %}
{%- endmacro %}
