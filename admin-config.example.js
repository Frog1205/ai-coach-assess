// ATLAS · 教练后台配置模板(2026 Supabase Auth 架构)
// 1. 复制本文件为 admin-config.js
// 2. 填入 Project URL + Publishable key(与前端 config.js 相同)
// 3. ADMIN_EMAIL 填你在 Supabase Auth 里创建的管理员 email

window.SUPABASE_URL      = 'https://你的项目.supabase.co';
window.SUPABASE_ANON_KEY = 'sb_publishable_xxxxx';

// 管理员 Supabase Auth email,密码由登录时输入
// 创建方式:Supabase Dashboard → Authentication → Users → Add user
// 必须给 user_metadata 加 {"role":"atlas_admin"} 才能通过 RLS
window.ADMIN_EMAIL = 'coach@atlas.local';
