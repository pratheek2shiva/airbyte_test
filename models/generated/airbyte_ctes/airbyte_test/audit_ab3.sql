{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_airbyte_test",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('audit_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'audit_id',
        'act',
        'created',
        'pr_id',
        'act_id',
        '_id',
        'ack_data',
        'uuid',
        'updated',
        'ack_status',
        'status',
    ]) }} as _airbyte_audit_hashid,
    tmp.*
from {{ ref('audit_ab2') }} tmp
-- audit
where 1 = 1

