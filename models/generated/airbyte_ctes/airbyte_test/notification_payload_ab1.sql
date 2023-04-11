{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_airbyte_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('notification') }}
select
    _airbyte_notification_hashid,
    {{ json_extract_array('payload', ['user_id_list'], ['user_id_list']) }} as user_id_list,
    {{ json_extract_scalar('payload', ['event_type'], ['event_type']) }} as event_type,
    {{ json_extract_scalar('payload', ['from_email'], ['from_email']) }} as from_email,
    {{ json_extract_scalar('payload', ['transaction_idd'], ['transaction_idd']) }} as transaction_idd,
    {{ json_extract_scalar('payload', ['project_id'], ['project_id']) }} as project_id,
    {{ json_extract('table_alias', 'payload', ['notification_data'], ['notification_data']) }} as notification_data,
    {{ json_extract('table_alias', 'payload', ['title_notify_data'], ['title_notify_data']) }} as title_notify_data,
    {{ json_extract_scalar('payload', ['category_type'], ['category_type']) }} as category_type,
    {{ json_extract_scalar('payload', ['origin-service'], ['origin-service']) }} as origin_service,
    {{ json_extract_array('payload', ['medium_list'], ['medium_list']) }} as medium_list,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('notification') }} as table_alias
-- payload at notification/payload
where 1 = 1
and payload is not null

