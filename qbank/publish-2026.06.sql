-- ATLAS · 一次性运维 SQL(2026-06-04)
-- 用法:Supabase Dashboard → SQL Editor → 粘贴 → Run
-- 覆盖:① 发布 2026.06 题库并激活 ② 给 accounts 加 signup_source 字段

BEGIN;

-- ══════════ 1. 发布 2026.06 题库并激活 ══════════
INSERT INTO qbank_versions (version, updated_at, questions, is_active)
VALUES ('2026.06', '2026-06-04', '[{"d": 0, "q": "你目前最常用的 AI 工具是哪类?", "a": ["基本不用,偶尔搜一下", "偶尔用豆包/文心一言做简单问答", "稳定使用 2-3 个工具,含国内外主流产品", "按场景切换工具(写作 Claude/图片 Midjourney/视频 Sora 等)"]}, {"d": 0, "q": "以下 AI 工具类别,你深度用过几类?\n(写作 · 图像 · 视频 · 研究 · Agent · 多模态)", "a": ["只 1 类,其他没接触", "用过 2 类", "用过 3-4 类", "5 类及以上,且能讲清各家差异"]}, {"d": 0, "q": "面对同一个任务,你怎么选工具?", "a": ["用同一个习惯的工具,不太换", "偶尔尝试不同工具对比", "大部分情况知道该用哪个", "有工具选择 SOP,能秒速决策"]}, {"d": 0, "q": "2026 年 6 月当下的旗舰模型(Claude Opus 4.8 / GPT-5.5 / Gemini 3.5 / 通义 Qwen3.7 / 豆包 1.6 / DeepSeek V4 / MiniMax M3 / Kimi K2.6)你的认知?", "a": ["基本没听过,只用过一两个", "听过名字,知道大概各有特点", "同时用过 3 个以上,知道每个擅长什么场景", "会按任务类型主动切换(写作/编程/视觉/视频/长文档/低成本各选不同),且能说出选择理由"]}, {"d": 1, "q": "你通常怎么给 AI 下指令?", "a": ["直接说需求,比如「帮我写篇文章」", "会加一些背景信息", "会设定角色、说明格式和要求", "结构化模板:角色 + 背景 + 任务 + 格式 + 约束 + 示例"]}, {"d": 1, "q": "AI 给的回答不理想时,你会怎么做?", "a": ["重新问一遍,或直接放弃", "稍微修改问题再问", "指出具体哪里不好,要求针对性修改", "拆解问题,分步引导 AI 逐步完善(思维链/Chain-of-Thought)"]}, {"d": 1, "q": "对「AI Skills / 长期记忆 / 知识沉淀」(把你的方法论变成可复用的 AI 技能,而非每次重写提示词)的实践?", "a": ["没听过这个概念", "听过,但还在每次现写提示词", "会把常用方法保存成模板,在 Claude / Codex / 豆包 / IMA 里复用", "已建完整 Skills 库,把书籍 / 课程 / SOP 沉淀成可调用资产,可团队共享"]}, {"d": 1, "q": "对「上下文工程」(Context Engineering)和「深度思考模式」(Extended Thinking)你的理解?", "a": ["没听说过这两个词", "听过但不太懂区别", "知道核心是给 AI 喂足背景 + 让它先思考再回答", "熟练使用 Claude/GPT 的深度思考模式,会构建领域知识上下文"]}, {"d": 2, "q": "用 AI 写专业内容(报告/科普/方案),你的流程是?", "a": ["让 AI 直接写,基本直接用", "AI 写初稿,我做简单润色", "我设计框架,AI 填充,再做专业校验", "完整 SOP:选题→框架→AI 写→专业校验→多平台适配"]}, {"d": 2, "q": "AI 音乐 / 语音克隆 / 数字人(Suno / Miso / 海螺 / 腾讯智影 / 即梦)的使用程度?", "a": ["没接触过", "玩过 1-2 次,听个新鲜", "能稳定产出可用的配音 / 歌曲 / 数字人片段", "已纳入正式内容生产线(播客 / 课程 / 宣传片),有从脚本到成片的完整流程"]}, {"d": 2, "q": "2026 年 AI 视频生成(Sora 2 / Veo 3 / 可灵 / 即梦)的能力你怎么用?", "a": ["完全没接触过", "玩过几次,做着玩", "能稳定产出 30 秒到 1 分钟的可用素材", "已纳入正式内容生产线,从脚本到成片有完整流程"]}, {"d": 2, "q": "AI 视频/数字人/播客整合创作,你目前处于哪个阶段?", "a": ["完全没接触", "知道有这类工具", "用过几次,了解基本流程", "能独立完成:脚本→视频→数字人配音→剪辑→分发全链路"]}, {"d": 3, "q": "听到「AI Agent」,你的第一反应是?", "a": ["不太清楚是什么", "知道是 AI 助手一类的东西", "了解 Agent 可以自主执行多步骤任务", "已在用 Agent 工具(Claude Code / WorkBuddy / Manus 等)做真实业务"]}, {"d": 3, "q": "桌面 Agent(让 AI 直接操控你的电脑:Claude Computer Use / Perplexity Personal Computer / Holo3.1 / Antigravity 等)的实践?", "a": ["没听过这类工具", "看过演示,觉得有意思但没装", "装过并跑过几次任务(整理文件 / 批量改名 / 跨应用搬数据)", "已稳定让桌面 Agent 接管多个日常任务,有 SOP 和效果回顾"]}, {"d": 3, "q": "如果有工具能让 AI 自动完成某项重复性工作,你会?", "a": ["觉得不靠谱,还是自己手动", "感兴趣但不知怎么设置", "愿意尝试,会花时间摸索", "已经在用,有具体的自动化案例"]}, {"d": 3, "q": "你目前工作中,有没有被 AI 接管的重复性任务?", "a": ["没有,所有工作都手动", "少数简单任务会用 AI 辅助", "多项工作有 AI 参与,节省了一些时间", "建立了自动化流程,多个场景已由 AI 接管执行"]}, {"d": 4, "q": "你的「AI 工作底座」(长期主用的智能体客户端:Claude Code / Codex / Cursor / 通义灵码 / 元宝 / 豆包电脑版 等)是?", "a": ["没有固定底座,哪个网页方便就用哪个", "主用 1 个聊天产品,需要时临时切换", "有 1-2 个固定客户端,接了知识库 / MCP / Skills", "搭了完整人-AI 协作工作站(主智能体 + Skills + MCP + 自定义工具),团队可复用"]}, {"d": 4, "q": "对「多 Agent 协作」/「MCP 协议」(让多个 AI 工具协同工作)的实践?", "a": ["没接触过", "听过概念,没动手", "搭过简单的多 Agent 流水线", "已用 MCP/n8n 等编排了多个 Agent,跨工具协同跑真实业务"]}, {"d": 4, "q": "你的 AI 使用程度和同行业的同级别专家/老板相比?", "a": ["比大多数人用得少", "差不多,都是基础使用", "比大多数人用得多、用得深", "是行业公认的 AI 重度用户与方法论输出者"]}, {"d": 4, "q": "你离「AI 让团队/业务效率提升 50% 以上」还有多远?", "a": ["很远,几乎感觉不到提升", "有提升,但不稳定、不系统", "部分场景明显提升,全面提升仍需时间", "已经实现,核心场景效率提升远超 50%"]}]'::jsonb, true)
ON CONFLICT (version) DO UPDATE
  SET questions = EXCLUDED.questions,
      updated_at = EXCLUDED.updated_at,
      is_active = true;

UPDATE qbank_versions SET is_active = false WHERE version <> '2026.06';

-- ══════════ 2. 给 accounts 加 signup_source 字段(流量来源 first-touch 归因) ══════════
ALTER TABLE accounts ADD COLUMN IF NOT EXISTS signup_source jsonb;
COMMENT ON COLUMN accounts.signup_source IS 'First-touch attribution: UTM/referrer/channel,前端写入,后台分析渠道转化';

-- ══════════ 3. 校验 ══════════
SELECT version, updated_at, is_active, jsonb_array_length(questions) AS n_questions
FROM qbank_versions ORDER BY updated_at DESC;

SELECT column_name, data_type FROM information_schema.columns
WHERE table_name='accounts' AND column_name='signup_source';

COMMIT;
