{% macro limit_data_in_dev(col_named,dev_days=3) %}
{% if target.name == 'dev' %}
where {{ col_named }} >= dateadd('day',-{{ dev_days }},current_timestamp)
{% endif %}
{% endmacro %}