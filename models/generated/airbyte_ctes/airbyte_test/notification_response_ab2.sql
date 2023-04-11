{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_airbyte_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('notification_response_ab1') }}
select
    _airbyte_notification_hashid,
    cast(MESSAGEACK as {{ type_json() }}) as MESSAGEACK,
    cast(GUID as {{ dbt_utils.type_string() }}) as GUID,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(msg_length as {{ dbt_utils.type_string() }}) as msg_length,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('notification_response_ab1') }}
-- response at notification/response
where 1 = 1

