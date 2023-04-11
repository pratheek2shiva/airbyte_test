{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_airbyte_test",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('notification_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'cost',
        'created',
        'GUID',
        'request_url',
        object_to_string('payload'),
        'service',
        object_to_string('response'),
        'id',
        '_id',
        'sent_notificationid',
        'category',
        'updated',
        'request_id',
        'msg_length',
    ]) }} as _airbyte_notification_hashid,
    tmp.*
from {{ ref('notification_ab2') }} tmp
-- notification
where 1 = 1

