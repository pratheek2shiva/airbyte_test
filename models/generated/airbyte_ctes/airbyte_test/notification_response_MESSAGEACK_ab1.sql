{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_airbyte_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('notification_response') }}
select
    _airbyte_response_hashid,
    {{ json_extract('table_alias', 'MESSAGEACK', ['GUID'], ['GUID']) }} as GUID,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('notification_response') }} as table_alias
-- MESSAGEACK at notification/response/MESSAGEACK
where 1 = 1
and MESSAGEACK is not null

