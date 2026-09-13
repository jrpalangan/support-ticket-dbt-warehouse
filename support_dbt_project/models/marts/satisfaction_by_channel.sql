WITH tickets AS (
    SELECT * FROM {{ ref('stg_tickets') }}
)

SELECT
    ticket_channel,
    COUNT(*) AS total_tickets,
    ROUND(AVG(satisfaction_rating), 2) AS avg_satisfaction_rating
FROM tickets
GROUP BY ticket_channel
ORDER BY avg_satisfaction_rating DESC