SELECT

    customer_id,
    created_date,
    canceled_date,
    subscription_cost,
    subscription_interval,
    was_subscription_paid,

    DATE_DIFF('day', created_date, COALESCE(canceled_date, CURRENT_DATE)) 
        AS subscription_duration_days,

    CASE
        WHEN canceled_date IS NULL THEN 'active'
        ELSE 'canceled'
    END AS subscription_status

FROM {{ ref('stg_streaming_video_subscriptions') }}
