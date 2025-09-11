EXPLAIN (ANALYZE, BUFFERS)
SELECT
    c1_0.conversation_id
FROM
    conversations c1_0
WHERE
    c1_0.conversation_id = '0169dcbd-6c75-4d4b-8b23-26cc6e92f4e8'
    AND c1_0.user_id = '8a21cb76-860c-47b9-931f-36143e52c3d5'
FETCH FIRST 1 ROWS ONLY;

EXPLAIN (ANALYZE, BUFFERS)
SELECT
    m1_0.id,
    m1_0.conversation_id,
    m1_0.sender_type,
    m1_0.content,
    m1_0.created_date,
    m1_0.updated_date
FROM
    messages m1_0
WHERE
    m1_0.conversation_id = '0169dcbd-6c75-4d4b-8b23-26cc6e92f4e8'
ORDER BY
    m1_0.id DESC
FETCH FIRST 20 ROWS ONLY;

EXPLAIN (ANALYZE, BUFFERS)
SELECT
    m.id,
    m.conversation_id,
    m.sender_type,
    m.content,
    m.created_date,
    m.updated_date
FROM
    messages m
WHERE
    m.conversation_id IN ('e58ed763-928c-4155-bee9-fdbaa6f04f4c', 'af8a7f94-6c33-42b3-9683-7f33b07a4f4c') -- 예시 대화방 UUID 목록
    AND m.id < 1900000 -- 예시 cursorId
ORDER BY
    m.id DESC
LIMIT 20;