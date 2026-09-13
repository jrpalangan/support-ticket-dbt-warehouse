WITH source AS (
    SELECT * FROM {{ source('raw', 'customer_support_tickets') }}
),

renamed AS (
    SELECT
        TICKET_ID AS ticket_id,
        CUSTOMER_AGE AS customer_age,
        CUSTOMER_GENDER AS customer_gender,
        PRODUCT_PURCHASED AS product_purchased,
        CAST(DATE_OF_PURCHASE AS DATE) AS date_of_purchase,
        TICKET_TYPE AS ticket_type,
        TICKET_SUBJECT AS ticket_subject,
        TICKET_STATUS AS ticket_status,
        TICKET_PRIORITY AS ticket_priority,
        TICKET_CHANNEL AS ticket_channel,
        CAST(FIRST_RESPONSE_TIME AS TIMESTAMP) AS first_response_time,
        CAST(TIME_TO_RESOLUTION AS TIMESTAMP) AS time_to_resolution,
        CAST(CUSTOMER_SATISFACTION_RATING AS INTEGER) AS satisfaction_rating
        -- customer name and customer email were excluded from the final table 
    FROM source
    WHERE TICKET_ID IS NOT NULL
)

SELECT * FROM renamed