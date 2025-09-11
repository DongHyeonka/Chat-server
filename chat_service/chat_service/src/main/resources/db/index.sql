DROP INDEX IF EXISTS idx_messages_conversation_id_id_desc;

-- PostgreSQL 11 미만 버전에서 커버링 인덱스를 구현하는 방법입니다.
-- INCLUDE 절을 지원하지 않으므로, 커버링할 컬럼들을 인덱스 키의 일부로 포함시킵니다.
-- 이렇게 하면 쿼리가 인덱스만으로 필요한 모든 데이터를 얻을 수 있어(Index-Only Scan), 테이블 접근을 피하고 성능을 높일 수 있습니다.
-- 단점: INCLUDE 절을 사용하는 것보다 인덱스 크기가 커질 수 있습니다.
CREATE INDEX idx_messages_covering_history ON messages (
    conversation_id,
    id DESC,
    sender_type,
    content,
    created_date,
    updated_date
);
