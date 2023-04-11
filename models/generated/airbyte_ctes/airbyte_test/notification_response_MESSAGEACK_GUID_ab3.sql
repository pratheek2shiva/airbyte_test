{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_airbyte_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('notification_response_MESSAGEACK_GUID_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_MESSAGEACK_hashid',
        'SUBMITDATE',
        'GUID',
        'ID',
    ]) }} as _airbyte_GUID_hashid,
    tmp.*
from {{ ref('notification_response_MESSAGEACK_GUID_ab2') }} tmp
-- GUID at notification/response/MESSAGEACK/GUID
where 1 = 1

