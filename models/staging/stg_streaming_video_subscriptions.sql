SELECT 
    CAST(customer_id AS BIGINT) AS customer_id,

    strptime(created_date, '%Y-%m-%d') AS created_date,

    CASE
        WHEN canceled_date IS NOT NULL
        THEN strptime(canceled_date, '%Y-%m-%d')
        ELSE NULL
    END AS canceled_date,

    CAST(subscription_cost AS DOUBLE) AS subscription_cost,

    CASE
        WHEN lower(subscription_interval) = 'month' THEN 'monthly'
        WHEN lower(subscription_interval) = 'year' THEN 'annual'
        ELSE lower(subscription_interval)
    END AS subscription_interval,

    lower(was_subscription_paid) AS was_subscription_paid

FROM {{ source('raw','streaming_video_subscriptions') }}
