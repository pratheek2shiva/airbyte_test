{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_airbyte_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('notification_response_MESSAGEACK') }}
select
    _airbyte_MESSAGEACK_hashid,
    {{ json_extract_scalar('GUID', ['SUBMITDATE'], ['SUBMITDATE']) }} as SUBMITDATE,
    {{ json_extract_scalar('GUID', ['GUID'], ['GUID']) }} as GUID,
    {{ json_extract_scalar('GUID', ['ID'], ['ID']) }} as ID,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('notification_response_MESSAGEACK') }} as table_alias
-- GUID at notification/response/MESSAGEACK/GUID
where 1 = 1
and GUID is not null

