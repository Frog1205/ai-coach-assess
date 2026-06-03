-- ATLAS · 只读诊断查询
-- 看现在云端 qbank_versions 是什么状态

SELECT version,
       updated_at,
       is_active,
       jsonb_array_length(questions) AS n_questions,
       (SELECT q->>'q' FROM jsonb_array_elements(questions) q LIMIT 1) AS first_question
FROM qbank_versions
ORDER BY updated_at DESC;

-- 看 accounts 表结构(确认 signup_source 字段是否已加)
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name='accounts'
ORDER BY ordinal_position;
