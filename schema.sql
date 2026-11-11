-- ==============================================================================
-- 時差じゃんけん（Time-Lag Janken）Supabase テーブル定義＆本日（2026-11-11）初期シードデータ
-- 企画：お絵描き楽しも委員会（しょうだい）
-- ==============================================================================

-- 1. テーブル作成
CREATE TABLE IF NOT EXISTS public.time_lag_janken (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    player_name VARCHAR(50) NOT NULL DEFAULT '名もなき旅人',
    country_code VARCHAR(10) NOT NULL DEFAULT 'JP',
    country_name VARCHAR(50) NOT NULL DEFAULT '日本',
    country_flag VARCHAR(10) NOT NULL DEFAULT '🇯🇵',
    hand VARCHAR(10) NOT NULL CHECK (hand IN ('rock', 'scissors', 'paper')),
    comment VARCHAR(100),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 2. 行レベルセキュリティ（RLS）有効化
ALTER TABLE public.time_lag_janken ENABLE ROW LEVEL SECURITY;

-- 3. ポリシー設定（匿名アクセス許可）
-- (1) 誰でも過去の時差手を読み取り可能（SELECT）
DROP POLICY IF EXISTS "誰でも時差手を閲覧可能" ON public.time_lag_janken;
CREATE POLICY "誰でも時差手を閲覧可能"
ON public.time_lag_janken
FOR SELECT
TO anon, authenticated
USING (true);

-- (2) 誰でも自分の手を記録に刻むことが可能（INSERT）
DROP POLICY IF EXISTS "誰でも時差手を投稿可能" ON public.time_lag_janken;
CREATE POLICY "誰でも時差手を投稿可能"
ON public.time_lag_janken
FOR INSERT
TO anon, authenticated
WITH CHECK (true);

-- 4. パフォーマンス用インデックス
CREATE INDEX IF NOT EXISTS idx_time_lag_janken_created_at ON public.time_lag_janken (created_at DESC);
CREATE INDEX IF NOT EXISTS idx_time_lag_janken_hand ON public.time_lag_janken (hand);

-- 5. 既存の古いダミーデータ削除用（任意実行：本日の日付以前のテストデータを消去する場合）
-- DELETE FROM public.time_lag_janken WHERE created_at < '2026-11-11 00:00:00+09';

-- 6. 本日の初期シードデータ（2026-11-11 本日記録分のみ：8件）
-- ※ 過去数日・数ヶ月前の嘘のデータを全廃し、本日中の自然なタイムスタンプのみに限定
INSERT INTO public.time_lag_janken (player_name, country_code, country_name, country_flag, hand, comment, created_at) VALUES
('ハルト', 'JP', '日本（東京）', '🇯🇵', 'rock', '', NOW() - INTERVAL '12 minutes'),
('Camille', 'FR', 'フランス（パリ）', '🇫🇷', 'scissors', '', NOW() - INTERVAL '35 minutes'),
('Lucas', 'US', 'アメリカ（ニューヨーク）', '🇺🇸', 'paper', '', NOW() - INTERVAL '1 hour 20 minutes'),
('Oliver', 'GB', 'イギリス（ロンドン）', '🇬🇧', 'rock', '', NOW() - INTERVAL '2 hours 45 minutes'),
('雨萱（ユィシュエン）', 'TW', '台湾（台北）', '🇹🇼', 'scissors', '', NOW() - INTERVAL '4 hours 10 minutes'),
('ジフン', 'KR', '韓国（ソウル）', '🇰🇷', 'paper', '', NOW() - INTERVAL '6 hours 30 minutes'),
('Sophie', 'DE', 'ドイツ（ベルリン）', '🇩🇪', 'rock', '', NOW() - INTERVAL '8 hours 15 minutes'),
('アオイ', 'JP', '日本（大阪）', '🇯🇵', 'scissors', '', NOW() - INTERVAL '10 hours');
