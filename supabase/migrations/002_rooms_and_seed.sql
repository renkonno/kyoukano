-- roomsテーブル作成
CREATE TABLE IF NOT EXISTS rooms (
  id serial PRIMARY KEY,
  store_id uuid REFERENCES stores(id),
  name text NOT NULL,
  color_bg text DEFAULT '#f5f5f5',
  color_tx text DEFAULT '#333',
  color_bd text DEFAULT '#ddd',
  color_card text DEFAULT '#fafafa',
  sort_order integer DEFAULT 0,
  active boolean DEFAULT true,
  created_at timestamptz DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_rooms_store_id ON rooms(store_id);

-- 既存店舗のルームデータ投入（store_id=NULL）
INSERT INTO rooms (store_id, name, color_bg, color_tx, color_bd, color_card, sort_order)
VALUES
  (NULL, '堀田Aルーム', '#fff0f6', '#be185d', '#fbcfe8', '#fce7f3', 1),
  (NULL, '堀田Bルーム', '#eff6ff', '#1d4ed8', '#bfdbfe', '#dbeafe', 2),
  (NULL, '堀田Cルーム', '#f0fdf4', '#15803d', '#bbf7d0', '#dcfce7', 3),
  (NULL, '金山ルーム',  '#fefce8', '#854d0e', '#fef08a', '#fef9c3', 4)
ON CONFLICT DO NOTHING;

-- coursesテーブルにdurationを設定（既存データ）
UPDATE courses SET duration = 50 WHERE name LIKE '%50分%' AND duration IS NULL;
UPDATE courses SET duration = 80 WHERE name LIKE '%80分%' AND duration IS NULL;
UPDATE courses SET duration = 100 WHERE name LIKE '%100分%' AND duration IS NULL;
UPDATE courses SET duration = 130 WHERE name LIKE '%130分%' AND duration IS NULL;
UPDATE courses SET duration = 30 WHERE name LIKE '%延長%' AND duration IS NULL;
