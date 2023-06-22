{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_airbyte_test",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('airbyte_test', '_airbyte_raw_deal') }}
select
    {{ json_extract_scalar('_airbyte_data', ['email_id'], ['email_id']) }} as email_id,
    {{ json_extract_scalar('_airbyte_data', ['event_created_date'], ['event_created_date']) }} as event_created_date,
    {{ json_extract_scalar('_airbyte_data', ['filter_name'], ['filter_name']) }} as filter_name,
    {{ json_extract_scalar('_airbyte_data', ['device_id'], ['device_id']) }} as device_id,
    {{ json_extract_scalar('_airbyte_data', ['app_version'], ['app_version']) }} as app_version,
    {{ json_extract_scalar('_airbyte_data', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('_airbyte_data', ['filter_category'], ['filter_category']) }} as filter_category,
    {{ json_extract_scalar('_airbyte_data', ['os_version'], ['os_version']) }} as os_version,
    {{ json_extract_scalar('_airbyte_data', ['section'], ['section']) }} as section,
    {{ json_extract_scalar('_airbyte_data', ['source'], ['source']) }} as source,
    {{ json_extract_scalar('_airbyte_data', ['element_type'], ['element_type']) }} as element_type,
    {{ json_extract_scalar('_airbyte_data', ['search_type'], ['search_type']) }} as search_type,
    {{ json_extract_scalar('_airbyte_data', ['utm'], ['utm']) }} as utm,
    {{ json_extract_scalar('_airbyte_data', ['add_car_step'], ['add_car_step']) }} as add_car_step,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['page_name'], ['page_name']) }} as page_name,
    {{ json_extract_scalar('_airbyte_data', ['company_name'], ['company_name']) }} as company_name,
    {{ json_extract_scalar('_airbyte_data', ['_medium'], ['_medium']) }} as _medium,
    {{ json_extract_scalar('_airbyte_data', ['client_ip'], ['client_ip']) }} as client_ip,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['event'], ['event']) }} as event,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('airbyte_test', '_airbyte_raw_deal') }} as table_alias
-- deal
where 1 = 1

