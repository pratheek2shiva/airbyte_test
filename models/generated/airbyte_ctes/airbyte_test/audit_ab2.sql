{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_airbyte_test",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('audit_ab1') }}
select
    cast(audit_id as {{ dbt_utils.type_string() }}) as audit_id,
    cast(act as {{ dbt_utils.type_string() }}) as act,
    cast(created as {{ dbt_utils.type_string() }}) as created,
    cast(pr_id as {{ dbt_utils.type_string() }}) as pr_id,
    cast(act_id as {{ dbt_utils.type_string() }}) as act_id,
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(ack_data as {{ dbt_utils.type_string() }}) as ack_data,
    cast(uuid as {{ dbt_utils.type_string() }}) as uuid,
    cast(updated as {{ dbt_utils.type_string() }}) as updated,
    cast(ack_status as {{ dbt_utils.type_string() }}) as ack_status,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('audit_ab1') }}
-- audit
where 1 = 1

