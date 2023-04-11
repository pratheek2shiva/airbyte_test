{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "airbyte_test",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='notification_payload_scd'
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
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('notification_payload_ab3') }}
select
    _airbyte_notification_hashid,
    user_id_list,
    event_type,
    from_email,
    transaction_idd,
    project_id,
    notification_data,
    title_notify_data,
    category_type,
    origin_service,
    medium_list,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_payload_hashid
from {{ ref('notification_payload_ab3') }}
-- payload at notification/payload from {{ ref('notification') }}
where 1 = 1

