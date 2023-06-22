{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_airbyte_test",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('actions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'ack_time',
        'sub_id',
        'created',
        'pr_id',
        'ack',
        'uid',
        'sent_time',
        'mqtt',
        'service_id',
        'meta_data',
        'id',
        '_id',
        'state',
        'updated',
        'event_time',
    ]) }} as _airbyte_actions_hashid,
    tmp.*
from {{ ref('actions_ab2') }} tmp
-- actions
where 1 = 1

