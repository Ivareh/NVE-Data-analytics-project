{# Generates area_id columns with averages for column_name's metrics #}

{% macro generate_area_avgs(column_name, area_ids) %}
    {% for area_id in area_ids %}
        avg(
            case
                when area_id = {{ area_id }} and area_id is not null
                then {{ column_name }}
                else 0
            end
        ) as area_id_{{ area_id }}_mean_{{ column_name }}
        {% if not loop.last %},{% endif %}
    {% endfor %}
{% endmacro %}



{% macro generate_area_mins(column_name, area_ids) %}
    {% for area_id in area_ids %}
        min(
            case
                when area_id = {{ area_id }} and area_id is not null
                then {{ column_name }}
                else 0
            end
        ) as area_id_{{ area_id }}_mean_{{ column_name }}
        {% if not loop.last %},{% endif %}
    {% endfor %}
{% endmacro %}



{% macro generate_area_max(column_name, area_ids) %}
    {% for area_id in area_ids %}
        max(
            case
                when area_id = {{ area_id }} and area_id is not null
                then {{ column_name }}
                else 0
            end
        ) as area_id_{{ area_id }}_mean_{{ column_name }}
        {% if not loop.last %},{% endif %}
    {% endfor %}
{% endmacro %}






