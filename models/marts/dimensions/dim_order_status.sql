select
    cast(status_key as bigint) as status_key,
    cast(status_code as int) as status_code,
    cast(status_name as string) as status_name
from {{ ref('order_status') }}
