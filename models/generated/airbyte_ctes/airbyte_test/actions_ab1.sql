{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_airbyte_test",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('airbyte_test', '_airbyte_raw_actions') }}
select
    {{ json_extract_scalar('_airbyte_data', ['ack_time'], ['ack_time']) }} as ack_time,
    {{ json_extract_scalar('_airbyte_data', ['sub_id'], ['sub_id']) }} as sub_id,
    {{ json_extract_scalar('_airbyte_data', ['created'], ['created']) }} as created,
    {{ json_extract_scalar('_airbyte_data', ['pr_id'], ['pr_id']) }} as pr_id,
    {{ json_extract_scalar('_airbyte_data', ['ack'], ['ack']) }} as ack,
    {{ json_extract_scalar('_airbyte_data', ['uid'], ['uid']) }} as uid,
    {{ json_extract_scalar('_airbyte_data', ['sent_time'], ['sent_time']) }} as sent_time,
    {{ json_extract_scalar('_airbyte_data', ['mqtt'], ['mqtt']) }} as mqtt,
    {{ json_extract_scalar('_airbyte_data', ['service_id'], ['service_id']) }} as service_id,
    {{ json_extract_scalar('_airbyte_data', ['meta_data'], ['meta_data']) }} as meta_data,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['updated'], ['updated']) }} as updated,
    {{ json_extract_scalar('_airbyte_data', ['event_time'], ['event_time']) }} as event_time,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('airbyte_test', '_airbyte_raw_actions') }} as table_alias
-- actions
where 1 = 1

