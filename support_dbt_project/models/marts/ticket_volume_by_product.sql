WITH tickets AS (
    SELECT * FROM {{ ref('stg_tickets') }}
)

SELECT
    product_purchased,
    COUNT(*) AS total_tickets,
    ROUND(AVG(satisfaction_rating), 2) AS avg_satisfaction_rating
FROM tickets
GROUP BY product_purchased
ORDER BY total_tickets DESC