{{ config(
    partition_by = {"field": "created", "data_type": "timestamp", "granularity": "day"},
    schema = "airbyte_test",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='notification_scd'
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
-- depends_on: {{ ref('notification_ab3') }}
select
    cost,
    safe_cast(created as timestamp) as created,
    GUID,
    request_url,
    payload,
    service,
    response,
    id,
    _id,
    sent_notificationid,
    category,
    updated,
    request_id,
    msg_length,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_notification_hashid
from {{ ref('notification_ab3') }}
-- notification from {{ source('airbyte_test', '_airbyte_raw_notification') }}
where 1 = 1

