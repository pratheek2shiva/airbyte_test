{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_airbyte_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('notification_payload_notification_data_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_payload_hashid',
        'amount',
        'vrn',
        'bar_code',
    ]) }} as _airbyte_notification_data_hashid,
    tmp.*
from {{ ref('notification_payload_notification_data_ab2') }} tmp
-- notification_data at notification/payload/notification_data
where 1 = 1

