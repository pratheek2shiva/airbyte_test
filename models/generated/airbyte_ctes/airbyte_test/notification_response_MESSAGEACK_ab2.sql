{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_airbyte_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('notification_response_MESSAGEACK_ab1') }}
select
    _airbyte_response_hashid,
    cast(GUID as {{ type_json() }}) as GUID,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('notification_response_MESSAGEACK_ab1') }}
-- MESSAGEACK at notification/response/MESSAGEACK
where 1 = 1

