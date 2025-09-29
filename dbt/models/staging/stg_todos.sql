-- 할일 데이터 정제 및 정규화
WITH source AS (
    SELECT * FROM {{ source('raw', 'todos') }}
),

cleaned AS (
    SELECT
        id,
        -- user_id 정규화
        CASE 
            WHEN user_id LIKE 'user%' AND user_id NOT LIKE 'user_%'
            THEN CONCAT('user_', LPAD(REGEXP_REPLACE(user_id, '[^0-9]', '', 'g'), 3, '0'))
            ELSE user_id
        END AS user_id,
        task,
        COALESCE(category, 'uncategorized') AS category,
        completed,
        created_at,
        created_at::DATE AS created_date
    FROM source
    WHERE user_id IS NOT NULL
      AND task IS NOT NULL
)

SELECT * FROM cleaned
