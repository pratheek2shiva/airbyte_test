{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_airbyte_test",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('airbyte_test', '_airbyte_raw_notification') }}
select
    {{ json_extract_scalar('_airbyte_data', ['cost'], ['cost']) }} as cost,
    {{ json_extract_scalar('_airbyte_data', ['created'], ['created']) }} as created,
    {{ json_extract_scalar('_airbyte_data', ['GUID'], ['GUID']) }} as GUID,
    {{ json_extract_scalar('_airbyte_data', ['request_url'], ['request_url']) }} as request_url,
    {{ json_extract('table_alias', '_airbyte_data', ['payload'], ['payload']) }} as payload,
    STRUCT(
   {{ json_extract_scalar('_airbyte_data', ['payload', 'user_id_list'], ['user_id_list']) }} as user_id_list,
   {{ json_extract_scalar('_airbyte_data', ['payload', 'event_type'], ['event_type']) }} as event_type,
        {{ json_extract_scalar('_airbyte_data', ['payload', 'from_email'], ['from_email']) }} as from_email,
   {{ json_extract_scalar('_airbyte_data', ['payload', 'transaction_idd'], ['transaction_idd']) }} as transaction_idd,
        {{ json_extract_scalar('_airbyte_data', ['payload', 'project_id'], ['project_id']) }} as project_id,
   {{ json_extract_scalar('_airbyte_data', ['payload', 'notification_data'], ['notification_data']) }} as notification_data,
        {{ json_extract_scalar('_airbyte_data', ['payload', 'title_notify_data'], ['title_notify_data']) }} as title_notify_data,
   {{ json_extract_scalar('_airbyte_data', ['payload', 'category_type'], ['category_type']) }} as category_type,
         {{ json_extract_scalar('_airbyte_data', ['payload', 'origin_service'], ['origin_service']) }} as origin_service,
   {{ json_extract_scalar('_airbyte_data', ['payload', 'medium_list'], ['medium_list']) }} as medium_list
        
) as payload1,
    
    {{ json_extract_scalar('_airbyte_data', ['service'], ['service']) }} as service,
    {{ json_extract('table_alias', '_airbyte_data', ['response'], ['response']) }} as response,
    
     STRUCT(
   {{ json_extract_scalar('_airbyte_data', ['response', 'MESSAGEACK'], ['MESSAGEACK']) }} as MESSAGEACK,
   {{ json_extract_scalar('_airbyte_data', ['response', 'GUID'], ['GUID']) }} as GUID,
   {{ json_extract_scalar('_airbyte_data', ['response', 'description'], ['description']) }} as description,
   {{ json_extract_scalar('_airbyte_data', ['response', 'msg_length'], ['msg_length']) }} as msg_length     
) as response1,
    
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['sent_notificationid'], ['sent_notificationid']) }} as sent_notificationid,
    {{ json_extract_scalar('_airbyte_data', ['category'], ['category']) }} as category,
    {{ json_extract_scalar('_airbyte_data', ['updated'], ['updated']) }} as updated,
    {{ json_extract_scalar('_airbyte_data', ['request_id'], ['request_id']) }} as request_id,
    {{ json_extract_scalar('_airbyte_data', ['msg_length'], ['msg_length']) }} as msg_length,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('airbyte_test', '_airbyte_raw_notification') }} as table_alias
-- notification
where 1 = 1

