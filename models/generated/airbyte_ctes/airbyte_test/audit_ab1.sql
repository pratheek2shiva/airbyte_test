{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_airbyte_test",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('airbyte_test', '_airbyte_raw_audit') }}
select
    {{ json_extract_scalar('_airbyte_data', ['audit_id'], ['audit_id']) }} as audit_id,
    {{ json_extract_scalar('_airbyte_data', ['act'], ['act']) }} as act,
    {{ json_extract_scalar('_airbyte_data', ['created'], ['created']) }} as created,
    {{ json_extract_scalar('_airbyte_data', ['pr_id'], ['pr_id']) }} as pr_id,
    {{ json_extract_scalar('_airbyte_data', ['act_id'], ['act_id']) }} as act_id,
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['ack_data'], ['ack_data']) }} as ack_data,
    {{ json_extract_scalar('_airbyte_data', ['uuid'], ['uuid']) }} as uuid,
    {{ json_extract_scalar('_airbyte_data', ['updated'], ['updated']) }} as updated,
    {{ json_extract_scalar('_airbyte_data', ['ack_status'], ['ack_status']) }} as ack_status,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('airbyte_test', '_airbyte_raw_audit') }} as table_alias
-- audit
where 1 = 1

