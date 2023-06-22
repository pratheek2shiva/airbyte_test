{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "airbyte_test",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='deal_scd'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "],
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('deal_ab3') }}
select
    email_id,
    event_created_date,
    filter_name,
    device_id,
    app_version,
    city,
    filter_category,
    os_version,
    section,
    source,
    element_type,
    search_type,
    utm,
    add_car_step,
    user_id,
    page_name,
    company_name,
    _medium,
    client_ip,
    id,
    _id,
    state,
    event,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_deal_hashid
from {{ ref('deal_ab3') }}
-- deal from {{ source('airbyte_test', '_airbyte_raw_deal') }}
where 1 = 1

