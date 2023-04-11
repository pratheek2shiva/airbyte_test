{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_airbyte_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('notification_payload_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_notification_hashid',
        array_to_string('user_id_list'),
        'event_type',
        'from_email',
        'transaction_idd',
        'project_id',
        object_to_string('notification_data'),
        object_to_string('title_notify_data'),
        'category_type',
        'origin_service',
        array_to_string('medium_list'),
    ]) }} as _airbyte_payload_hashid,
    tmp.*
from {{ ref('notification_payload_ab2') }} tmp
-- payload at notification/payload
where 1 = 1

