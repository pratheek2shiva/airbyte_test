{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_airbyte_test",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('deal_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'email_id',
        'event_created_date',
        'filter_name',
        'device_id',
        'app_version',
        'city',
        'filter_category',
        'os_version',
        'section',
        'source',
        'element_type',
        'search_type',
        'utm',
        'add_car_step',
        'user_id',
        'page_name',
        'company_name',
        '_medium',
        'client_ip',
        'id',
        '_id',
        'state',
        'event',
    ]) }} as _airbyte_deal_hashid,
    tmp.*
from {{ ref('deal_ab2') }} tmp
-- deal
where 1 = 1

