{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_airbyte_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('notification_payload_notification_data_ab1') }}
select
    _airbyte_payload_hashid,
    cast(amount as {{ dbt_utils.type_string() }}) as amount,
    cast(vrn as {{ dbt_utils.type_string() }}) as vrn,
    cast(bar_code as {{ dbt_utils.type_string() }}) as bar_code,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('notification_payload_notification_data_ab1') }}
-- notification_data at notification/payload/notification_data
where 1 = 1

