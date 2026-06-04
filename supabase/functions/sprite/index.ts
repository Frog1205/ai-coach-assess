// ATLAS Sprite Edge Function
// ───────────────────────────────────────────────────────────────
// 前端 → 本函数 → DeepSeek。DEEPSEEK_API_KEY 留在 Supabase 服务端,
// 永不暴露给浏览器。CORS 白名单防止其他站点白嫖。
//
// 部署:
//   方法 A(CLI): supabase functions deploy sprite --no-verify-jwt
//   方法 B(Dashboard): Edge Functions → Create a new function → 粘贴本文件
//
// 设置 secret(2 选 1):
//   CLI:   supabase secrets set DEEPSEEK_API_KEY=sk-xxx
//   Dashboard: Edge Functions → Secrets → Add new secret DEEPSEEK_API_KEY
// ───────────────────────────────────────────────────────────────

const ALLOWED_ORIGINS = new Set([
  "https://frog1205.github.io",
  "http://localhost:8765",
  "http://localhost:3000",
]);

const DAILY_BUDGET_TOKENS = 2_000_000; // 单函数每日 token 上限兜底(约 ¥6/天)

function corsHeaders(origin: string | null) {
  const allowed = origin && ALLOWED_ORIGINS.has(origin) ? origin : "https://frog1205.github.io";
  return {
    "Access-Control-Allow-Origin": allowed,
    "Access-Control-Allow-Headers": "authorization, apikey, content-type, x-client-info",
    "Access-Control-Allow-Methods": "POST, OPTIONS",
    "Access-Control-Max-Age": "86400",
    "Content-Type": "application/json",
  };
}

Deno.serve(async (req) => {
  const origin = req.headers.get("origin");
  const cors = corsHeaders(origin);

  if (req.method === "OPTIONS") return new Response(null, { headers: cors });
  if (req.method !== "POST") {
    return new Response(JSON.stringify({ error: "Method not allowed" }), { status: 405, headers: cors });
  }

  const key = Deno.env.get("DEEPSEEK_API_KEY");
  if (!key) {
    return new Response(JSON.stringify({ error: "DEEPSEEK_API_KEY not configured in Supabase Edge Function secrets" }), { status: 500, headers: cors });
  }

  let payload: { messages?: unknown; max_tokens?: number; temperature?: number; model?: string };
  try { payload = await req.json(); } catch {
    return new Response(JSON.stringify({ error: "Invalid JSON body" }), { status: 400, headers: cors });
  }

  const { messages, max_tokens = 600, temperature = 0.7, model = "deepseek-chat" } = payload;
  if (!Array.isArray(messages) || messages.length === 0) {
    return new Response(JSON.stringify({ error: "messages must be non-empty array" }), { status: 400, headers: cors });
  }
  if (max_tokens > 2000) {
    return new Response(JSON.stringify({ error: "max_tokens exceeds limit (2000)" }), { status: 400, headers: cors });
  }

  // 透传到 DeepSeek
  const r = await fetch("https://api.deepseek.com/chat/completions", {
    method: "POST",
    headers: { "Content-Type": "application/json", Authorization: `Bearer ${key}` },
    body: JSON.stringify({ model, messages, max_tokens, temperature, stream: false }),
  });

  // 直接透传 status + body(包括上游错误)
  const body = await r.text();
  return new Response(body, { status: r.status, headers: cors });
});
