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
                            identifier='actions_scd'
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
-- depends_on: {{ ref('actions_ab3') }}
select
    ack_time,
    sub_id,
    created,
    pr_id,
    ack,
    uid,
    sent_time,
    mqtt,
    service_id,
    meta_data,
    id,
    _id,
    state,
    updated,
    event_time,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_actions_hashid
from {{ ref('actions_ab3') }}
-- actions from {{ source('airbyte_test', '_airbyte_raw_actions') }}
where 1 = 1

