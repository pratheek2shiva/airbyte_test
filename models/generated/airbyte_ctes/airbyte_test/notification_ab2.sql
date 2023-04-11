{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_airbyte_test",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('notification_ab1') }}
select
    cast(cost as {{ dbt_utils.type_string() }}) as cost,
    cast(created as {{ dbt_utils.type_string() }}) as created,
    cast(GUID as {{ dbt_utils.type_string() }}) as GUID,
    cast(request_url as {{ dbt_utils.type_string() }}) as request_url,
    cast(payload as {{ type_json() }}) as payload,
    cast(service as {{ dbt_utils.type_string() }}) as service,
    cast(response as {{ type_json() }}) as response,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(sent_notificationid as {{ dbt_utils.type_string() }}) as sent_notificationid,
    cast(category as {{ dbt_utils.type_string() }}) as category,
    cast(updated as {{ dbt_utils.type_string() }}) as updated,
    cast(request_id as {{ dbt_utils.type_string() }}) as request_id,
    cast(msg_length as {{ dbt_utils.type_string() }}) as msg_length,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('notification_ab1') }}
-- notification
where 1 = 1

