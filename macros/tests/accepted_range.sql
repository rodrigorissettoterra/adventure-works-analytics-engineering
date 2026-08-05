{% test accepted_range(model, column_name, min_value=none, max_value=none, inclusive=true) %}

select *
from {{ model }}
where {{ column_name }} is not null
  and (
    try_cast({{ column_name }} as decimal(38, 10)) is null

    {% if min_value is not none %}
      or try_cast({{ column_name }} as decimal(38, 10))
        {% if inclusive %} < {% else %} <= {% endif %}
        cast({{ min_value }} as decimal(38, 10))
    {% endif %}

    {% if max_value is not none %}
      or try_cast({{ column_name }} as decimal(38, 10))
        {% if inclusive %} > {% else %} >= {% endif %}
        cast({{ max_value }} as decimal(38, 10))
    {% endif %}
  )

{% endtest %}