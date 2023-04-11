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
    {{ json_extract('table_alias', 'response', ['MESSAGEACK'], ['MESSAGEACK']) }} as MESSAGEACK,
    {{ json_extract_scalar('response', ['GUID'], ['GUID']) }} as GUID,
    {{ json_extract_scalar('response', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('response', ['msg_length'], ['msg_length']) }} as msg_length,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('notification') }} as table_alias
-- response at notification/response
where 1 = 1
and response is not null

