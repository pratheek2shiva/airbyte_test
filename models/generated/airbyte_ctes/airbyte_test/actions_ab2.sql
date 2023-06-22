{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_airbyte_test",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('actions_ab1') }}
select
    cast(ack_time as {{ dbt_utils.type_string() }}) as ack_time,
    cast(sub_id as {{ dbt_utils.type_string() }}) as sub_id,
    cast(created as {{ dbt_utils.type_string() }}) as created,
    cast(pr_id as {{ dbt_utils.type_string() }}) as pr_id,
    cast(ack as {{ dbt_utils.type_float() }}) as ack,
    cast(uid as {{ dbt_utils.type_string() }}) as uid,
    cast(sent_time as {{ dbt_utils.type_string() }}) as sent_time,
    cast(mqtt as {{ dbt_utils.type_string() }}) as mqtt,
    cast(service_id as {{ dbt_utils.type_string() }}) as service_id,
    cast(meta_data as {{ dbt_utils.type_string() }}) as meta_data,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(updated as {{ dbt_utils.type_string() }}) as updated,
    cast(event_time as {{ dbt_utils.type_string() }}) as event_time,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('actions_ab1') }}
-- actions
where 1 = 1

