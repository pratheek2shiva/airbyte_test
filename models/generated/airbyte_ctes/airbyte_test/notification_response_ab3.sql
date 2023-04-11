{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_airbyte_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('notification_response_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_notification_hashid',
        object_to_string('MESSAGEACK'),
        'GUID',
        'description',
        'msg_length',
    ]) }} as _airbyte_response_hashid,
    tmp.*
from {{ ref('notification_response_ab2') }} tmp
-- response at notification/response
where 1 = 1

