-- 사용자별 일일 활동 통계
WITH base AS (
    SELECT * FROM {{ ref('stg_todos') }}
)

SELECT
    user_id,
    created_date,
    COUNT(*) AS total_tasks,
    COUNT(CASE WHEN completed THEN 1 END) AS completed_tasks,
    COUNT(CASE WHEN NOT completed THEN 1 END) AS incomplete_tasks,
    ROUND(
        COUNT(CASE WHEN completed THEN 1 END)::NUMERIC / 
        NULLIF(COUNT(*), 0) * 100, 
        2
    ) AS completion_rate,
    COUNT(DISTINCT category) AS categories_used
FROM base
GROUP BY user_id, created_date
ORDER BY user_id, created_date DESC
