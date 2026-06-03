// ATLAS · 前端 Supabase 配置
// 1. 复制本文件为 config.js  (config.js 已被 .gitignore,放心填真实值)
// 2. 填入 Supabase Project Settings → API 页里的 URL 和 anon public key

window.SUPABASE_URL      = 'https://你的项目.supabase.co';
window.SUPABASE_ANON_KEY = '你的 anon public key';

// 可选:开启本地→云端的一次性回填
window.ATLAS_AUTO_BACKFILL = true;

// DeepSeek API key — 用于 ATLAS 精灵问答(网页直调)
// ⚠️ 注意:该 key 会暴露在前端,任何人 F12 都能看到。务必在 DeepSeek 控制台
//   设置月度消费上限(推荐 ¥50/月),配合本前端的 5/50 次配额作为兜底。
window.DEEPSEEK_API_KEY = 'sk-...';
