// ATLAS · 前端 Supabase 配置
// 1. 复制本文件为 config.js  (config.js 已被 .gitignore,放心填真实值)
// 2. 填入 Supabase Project Settings → API 页里的 URL 和 anon public key

window.SUPABASE_URL      = 'https://你的项目.supabase.co';
window.SUPABASE_ANON_KEY = '你的 anon public key';

// 可选:开启本地→云端的一次性回填
window.ATLAS_AUTO_BACKFILL = true;

// ⚠️ DeepSeek key 已迁到 Supabase Edge Function (sprite),不再走前端
// 部署步骤见 supabase/functions/sprite/index.ts 顶部注释
