{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "airbyte_test",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='notification_response_MESSAGEACK_GUID_scd'
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
-- depends_on: {{ ref('notification_response_MESSAGEACK_GUID_ab3') }}
select
    _airbyte_MESSAGEACK_hashid,
    SUBMITDATE,
    GUID,
    ID,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_GUID_hashid
from {{ ref('notification_response_MESSAGEACK_GUID_ab3') }}
-- GUID at notification/response/MESSAGEACK/GUID from {{ ref('notification_response_MESSAGEACK') }}
where 1 = 1

