{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_airbyte_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('notification_payload_ab1') }}
select
    _airbyte_notification_hashid,
    user_id_list,
    cast(event_type as {{ dbt_utils.type_string() }}) as event_type,
    cast(from_email as {{ dbt_utils.type_string() }}) as from_email,
    cast(transaction_idd as {{ dbt_utils.type_string() }}) as transaction_idd,
    cast(project_id as {{ dbt_utils.type_string() }}) as project_id,
    cast(notification_data as {{ type_json() }}) as notification_data,
    cast(title_notify_data as {{ type_json() }}) as title_notify_data,
    cast(category_type as {{ dbt_utils.type_string() }}) as category_type,
    cast(origin_service as {{ dbt_utils.type_string() }}) as origin_service,
    medium_list,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('notification_payload_ab1') }}
-- payload at notification/payload
where 1 = 1

