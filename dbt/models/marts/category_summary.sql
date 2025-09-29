-- 카테고리별 집계 통계
WITH base AS (
    SELECT * FROM {{ ref('stg_todos') }}
)

SELECT
    category,
    COUNT(*) AS total_tasks,
    COUNT(CASE WHEN completed THEN 1 END) AS completed_tasks,
    COUNT(CASE WHEN NOT completed THEN 1 END) AS incomplete_tasks,
    ROUND(
        COUNT(CASE WHEN completed THEN 1 END)::NUMERIC / 
        NULLIF(COUNT(*), 0) * 100, 
        2
    ) AS completion_rate,
    COUNT(DISTINCT user_id) AS unique_users,
    COUNT(DISTINCT created_date) AS active_days
FROM base
GROUP BY category
ORDER BY total_tasks DESC
