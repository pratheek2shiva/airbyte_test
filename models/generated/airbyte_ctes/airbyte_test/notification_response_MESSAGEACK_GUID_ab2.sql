{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_airbyte_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('notification_response_MESSAGEACK_GUID_ab1') }}
select
    _airbyte_MESSAGEACK_hashid,
    cast(SUBMITDATE as {{ dbt_utils.type_string() }}) as SUBMITDATE,
    cast(GUID as {{ dbt_utils.type_string() }}) as GUID,
    cast(ID as {{ dbt_utils.type_string() }}) as ID,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('notification_response_MESSAGEACK_GUID_ab1') }}
-- GUID at notification/response/MESSAGEACK/GUID
where 1 = 1

