{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_airbyte_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('notification_response_MESSAGEACK_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_response_hashid',
        object_to_string('GUID'),
    ]) }} as _airbyte_MESSAGEACK_hashid,
    tmp.*
from {{ ref('notification_response_MESSAGEACK_ab2') }} tmp
-- MESSAGEACK at notification/response/MESSAGEACK
where 1 = 1

