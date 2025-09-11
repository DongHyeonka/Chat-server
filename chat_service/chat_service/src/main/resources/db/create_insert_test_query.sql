CREATE EXTENSION IF NOT EXISTS "pgcrypto";

WITH users AS (
    SELECT gen_random_uuid() AS user_id
    FROM generate_series(1, 100)
),
new_conversations AS (
    INSERT INTO conversations (conversation_id, user_id, created_date, updated_date)
    SELECT 
        gen_random_uuid() as conversation_id,
        u.user_id,
        NOW() - INTERVAL '1 day' * (random() * 365) as created_date,
        NOW() - INTERVAL '1 hour' * (random() * 24) as updated_date
    FROM users u
    CROSS JOIN generate_series(1, 10000) -- 사용자당 10,000개의 대화 생성
    RETURNING conversation_id
),
message_data AS (
    SELECT 
        nc.conversation_id,
        CASE 
            WHEN random() < 0.5 THEN 'USER'
            ELSE 'ASSISTANT'
        END as sender_type,
        CASE 
            WHEN random() < 0.3 THEN '안녕하세요! 도움이 필요하신가요?'
            WHEN random() < 0.6 THEN '네, 알겠습니다. 추가로 궁금한 점이 있으시면 언제든 말씀해 주세요.'
            WHEN random() < 0.8 THEN '좋은 질문이네요. 자세히 설명드리겠습니다.'
            ELSE '감사합니다. 더 도움이 필요하시면 말씀해 주세요.'
        END as content,
        NOW() - INTERVAL '1 day' * (random() * 30) as created_date,
        NOW() - INTERVAL '1 hour' * (random() * 12) as updated_date,
        ROW_NUMBER() OVER (PARTITION BY nc.conversation_id ORDER BY random()) as msg_num
    FROM new_conversations nc
    CROSS JOIN generate_series(1, 20) -- 각 conversation당 20개 메시지
    WHERE random() < 0.95 -- 일부 conversation은 메시지가 적을 수 있도록
)
INSERT INTO messages (conversation_id, sender_type, content, created_date, updated_date)
SELECT 
    conversation_id,
    sender_type,
    content || ' (메시지 #' || msg_num || ')',
    created_date,
    updated_date
FROM message_data;
