{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_airbyte_test",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('deal_ab1') }}
select
    cast(email_id as {{ dbt_utils.type_string() }}) as email_id,
    cast(event_created_date as {{ dbt_utils.type_string() }}) as event_created_date,
    cast(filter_name as {{ dbt_utils.type_string() }}) as filter_name,
    cast(device_id as {{ dbt_utils.type_string() }}) as device_id,
    cast(app_version as {{ dbt_utils.type_string() }}) as app_version,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(filter_category as {{ dbt_utils.type_string() }}) as filter_category,
    cast(os_version as {{ dbt_utils.type_float() }}) as os_version,
    cast(section as {{ dbt_utils.type_string() }}) as section,
    cast(source as {{ dbt_utils.type_string() }}) as source,
    cast(element_type as {{ dbt_utils.type_string() }}) as element_type,
    cast(search_type as {{ dbt_utils.type_string() }}) as search_type,
    cast(utm as {{ dbt_utils.type_string() }}) as utm,
    cast(add_car_step as {{ dbt_utils.type_string() }}) as add_car_step,
    cast(user_id as {{ dbt_utils.type_string() }}) as user_id,
    cast(page_name as {{ dbt_utils.type_string() }}) as page_name,
    cast(company_name as {{ dbt_utils.type_string() }}) as company_name,
    cast(_medium as {{ dbt_utils.type_string() }}) as _medium,
    cast(client_ip as {{ dbt_utils.type_string() }}) as client_ip,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(event as {{ dbt_utils.type_string() }}) as event,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('deal_ab1') }}
-- deal
where 1 = 1

