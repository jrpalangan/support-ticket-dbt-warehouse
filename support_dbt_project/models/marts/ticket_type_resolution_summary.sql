WITH tickets AS (
    SELECT * FROM {{ ref('stg_tickets') }}
),

with_diff AS (
    SELECT
        *,
        datediff('hour', first_response_time, time_to_resolution) as handling_time_hours
    FROM tickets
)

SELECT
    ticket_type,
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN handling_time_hours < 0 THEN 1 ELSE 0 END) AS excluded_negative_rows,
    ROUND(AVG(CASE WHEN handling_time_hours >= 0 THEN handling_time_hours END), 1) AS avg_handling_time_hours,
    ROUND(AVG(satisfaction_rating), 2) AS avg_satisfaction_rating
FROM with_diff
GROUP BY ticket_type
ORDER BY avg_handling_time_hours DESC