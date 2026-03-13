WITH base AS (

    SELECT

        customer_id,
        created_date,
        canceled_date,
        subscription_interval,

        DATE_TRUNC('month', created_date) AS cohort_month,

        DATE_DIFF(
            'month',
            created_date,
            COALESCE(canceled_date, CURRENT_DATE)
        ) AS subscription_months

    FROM {{ ref('stg_streaming_video_subscriptions') }}

),

cohort_table AS (

    SELECT

        cohort_month,

        subscription_months AS month_number,

        COUNT(DISTINCT customer_id) AS customers

    FROM base

    GROUP BY 1,2

)

SELECT *
FROM cohort_table
ORDER BY cohort_month, month_number
