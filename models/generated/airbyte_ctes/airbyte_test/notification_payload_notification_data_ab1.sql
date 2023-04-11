{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_airbyte_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('notification_payload') }}
select
    _airbyte_payload_hashid,
    {{ json_extract_scalar('notification_data', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('notification_data', ['vrn'], ['vrn']) }} as vrn,
    {{ json_extract_scalar('notification_data', ['bar_code'], ['bar_code']) }} as bar_code,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('notification_payload') }} as table_alias
-- notification_data at notification/payload/notification_data
where 1 = 1
and notification_data is not null

