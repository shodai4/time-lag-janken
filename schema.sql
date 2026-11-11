-- ==============================================================================
-- 時差じゃんけん（Time-Lag Janken）Supabase テーブル定義＆初期シードデータ
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

-- (2) 誰でも自分の手を時空に刻むことが可能（INSERT）
DROP POLICY IF EXISTS "誰でも時差手を投稿可能" ON public.time_lag_janken;
CREATE POLICY "誰でも時差手を投稿可能"
ON public.time_lag_janken
FOR INSERT
TO anon, authenticated
WITH CHECK (true);

-- 4. パフォーマンス用インデックス
CREATE INDEX IF NOT EXISTS idx_time_lag_janken_created_at ON public.time_lag_janken (created_at DESC);
CREATE INDEX IF NOT EXISTS idx_time_lag_janken_hand ON public.time_lag_janken (hand);

-- 5. 世界各地の初期シードデータ（30件：時空の先人たち）
-- ※ 過去1ヶ月〜数時間前までの自然なタイムスタンプで初期配置
INSERT INTO public.time_lag_janken (player_name, country_code, country_name, country_flag, hand, comment, created_at) VALUES
('ハルト', 'JP', '日本（東京）', '🇯🇵', 'rock', '明日は晴れるといいな', NOW() - INTERVAL '15 minutes'),
('Camille', 'FR', 'フランス（パリ）', '🇫🇷', 'scissors', 'Café du matin.', NOW() - INTERVAL '42 minutes'),
('Lucas', 'US', 'アメリカ（ニューヨーク）', '🇺🇸', 'paper', 'Midnight walk in Brooklyn.', NOW() - INTERVAL '2 hours'),
('Oliver', 'GB', 'イギリス（ロンドン）', '🇬🇧', 'rock', 'Tea time janken!', NOW() - INTERVAL '5 hours'),
('雨萱（ユィシュエン）', 'TW', '台湾（台北）', '🇹🇼', 'scissors', '夜市の帰り道です', NOW() - INTERVAL '8 hours'),
('Thiago', 'BR', 'ブラジル（サンパウロ）', '🇧🇷', 'paper', 'Boa noite do Brasil!', NOW() - INTERVAL '13 hours'),
('ジフン', 'KR', '韓国（ソウル）', '🇰🇷', 'rock', '今日も一日お疲れ様でした', NOW() - INTERVAL '18 hours'),
('Sophie', 'DE', 'ドイツ（ベルリン）', '🇩🇪', 'scissors', 'Guten Abend!', NOW() - INTERVAL '1 day'),
('Matteo', 'IT', 'イタリア（ローマ）', '🇮🇹', 'paper', 'Un saluto dall Italia.', NOW() - INTERVAL '1 day 4 hours'),
('Liam', 'CA', 'カナダ（バンクーバー）', '🇨🇦', 'rock', 'Autumn leaves everywhere.', NOW() - INTERVAL '1 day 12 hours'),
('Mia', 'AU', 'オーストラリア（シドニー）', '🇦🇺', 'scissors', 'Sunny morning here!', NOW() - INTERVAL '2 days'),
('Carlos', 'ES', 'スペイン（マドリード）', '🇪🇸', 'paper', '¡Hola desde Madrid!', NOW() - INTERVAL '2 days 6 hours'),
('Wei', 'SG', 'シンガポール', '🇸🇬', 'rock', 'Night breeze in Marina Bay.', NOW() - INTERVAL '3 days'),
('Birna', 'IS', 'アイスランド（レイキャビク）', '🇮🇸', 'scissors', 'Waiting for auroras.', NOW() - INTERVAL '3 days 14 hours'),
('Diego', 'AR', 'アルゼンチン（ブエノスアイレス）', '🇦🇷', 'paper', 'Fútbol y amigos.', NOW() - INTERVAL '4 days'),
('Amina', 'EG', 'エジプト（カイロ）', '🇪🇬', 'rock', 'Nile river breeze.', NOW() - INTERVAL '5 days'),
('Astrid', 'SE', 'スウェーデン（ストックホルム）', '🇸🇪', 'scissors', 'Fika time!', NOW() - INTERVAL '6 days'),
('Aarav', 'IN', 'インド（ムンバイ）', '🇮🇳', 'paper', 'Namaste from Mumbai!', NOW() - INTERVAL '7 days'),
('Lars', 'NL', 'オランダ（アムステルダム）', '🇳🇱', 'rock', 'Biking through canals.', NOW() - INTERVAL '8 days'),
('Sofia', 'MX', 'メキシコ（メキシコシティ）', '🇲🇽', 'scissors', 'Tacos and sunshine!', NOW() - INTERVAL '9 days'),
('アオイ', 'JP', '日本（京都）', '🇯🇵', 'paper', '紅葉が色づいてきました', NOW() - INTERVAL '10 days'),
('Noah', 'NZ', 'ニュージーランド（オークランド）', '🇳🇿', 'rock', 'Kia ora!', NOW() - INTERVAL '12 days'),
('Elena', 'GR', 'ギリシャ（アテネ）', '🇬🇷', 'scissors', 'Ancient skies above.', NOW() - INTERVAL '14 days'),
('Fatima', 'MA', 'モロッコ（マラケシュ）', '🇲🇦', 'paper', 'Mint tea under the stars.', NOW() - INTERVAL '16 days'),
('Kenji', 'US', 'アメリカ（ハワイ）', '🇺🇸', 'rock', 'Aloha sunset.', NOW() - INTERVAL '18 days'),
('Chiara', 'CH', 'スイス（チューリッヒ）', '🇨🇭', 'scissors', 'Mountain snow view.', NOW() - INTERVAL '20 days'),
('Tenzin', 'NP', 'ネパール（カトマンズ）', '🇳🇵', 'paper', 'Himalayan wind.', NOW() - INTERVAL '23 days'),
('ユウキ', 'JP', '日本（大阪）', '🇯🇵', 'rock', '夜食のうどん食べてます', NOW() - INTERVAL '25 days'),
('Freja', 'DK', 'デンマーク（コペンハーゲン）', '🇩🇰', 'scissors', 'Hygge evening.', NOW() - INTERVAL '28 days'),
('Mateo', 'CL', 'チリ（サンティアゴ）', '🇨🇱', 'paper', 'Andes mountains horizon.', NOW() - INTERVAL '30 days');
