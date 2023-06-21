{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_airbyte_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('struct_check_outbound_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_struct_check_hashid',
        'disnt',
        'it',
    ]) }} as _airbyte_outbound_hashid,
    tmp.*
from {{ ref('struct_check_outbound_ab2') }} tmp
-- outbound at struct_check/outbound
where 1 = 1

