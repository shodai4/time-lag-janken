// ==============================================================================
// 時差じゃんけん（Time-Lag Janken）外部接続設定
// ==============================================================================
// Supabaseと連携する場合、管理画面の「Project Settings」->「API」から取得できる
// Project URL と anon public key を設定してください。
//
// ※ 未設定（空文字）のままでも、内蔵された世界各地の時空シードデータ（オフラインモード）で
// 　 一切エラーなく快適に遊べます。
// ==============================================================================

window.TIME_LAG_CONFIG = {
  // 翔大さんのSupabaseプロジェクトURL
  supabaseUrl: "https://xxzmrdfroqeflfgszgls.supabase.co",
  
  // anon public key（SupabaseのAPIキー）
  supabaseAnonKey: "sb_publishable_sPah3iPPh-CesDyG0hxG_A_ZMu2VTkb"
};
