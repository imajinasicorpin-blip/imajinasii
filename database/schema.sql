-- Users Table
CREATE TABLE users (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  nama VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  role VARCHAR(50) NOT NULL CHECK (role IN ('admin', 'produksi', 'sablon', 'bordir', 'qc', 'packing', 'owner')),
  no_hp VARCHAR(20),
  alamat TEXT,
  foto_profil TEXT,
  status VARCHAR(20) DEFAULT 'aktif',
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- PO (Purchase Order) Table
CREATE TABLE po (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  invoice VARCHAR(100) UNIQUE NOT NULL,
  customer VARCHAR(255) NOT NULL,
  jenis VARCHAR(50) NOT NULL CHECK (jenis IN ('sablon', 'bordir', 'jahit', 'kombinasi')),
  qty INTEGER NOT NULL,
  spk VARCHAR(100) UNIQUE,
  status VARCHAR(50) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'cutting', 'sablon', 'bordir', 'jahit', 'qc', 'packing', 'selesai')),
  proses INTEGER DEFAULT 0,
  tanggal_masuk DATE NOT NULL,
  tanggal_selesai DATE,
  deadline DATE NOT NULL,
  desain_url TEXT,
  catatan TEXT,
  harga_satuan DECIMAL(12, 2),
  total_harga DECIMAL(12, 2),
  user_id UUID REFERENCES users(id) ON DELETE SET NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Inventory Table
CREATE TABLE inventory (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nama_barang VARCHAR(255) NOT NULL,
  kategori VARCHAR(100) NOT NULL,
  stok INTEGER NOT NULL DEFAULT 0,
  satuan VARCHAR(50) NOT NULL,
  harga DECIMAL(12, 2) NOT NULL,
  min_stok INTEGER NOT NULL DEFAULT 10,
  supplier VARCHAR(255),
  kode_barang VARCHAR(100) UNIQUE,
  deskripsi TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Stok History Table
CREATE TABLE stok_history (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  inventory_id UUID REFERENCES inventory(id) ON DELETE CASCADE,
  tipe VARCHAR(20) NOT NULL CHECK (tipe IN ('masuk', 'keluar')),
  qty INTEGER NOT NULL,
  keterangan TEXT,
  referensi VARCHAR(100),
  user_id UUID REFERENCES users(id) ON DELETE SET NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Notifikasi Table
CREATE TABLE notifikasi (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  tipe VARCHAR(50) NOT NULL CHECK (tipe IN ('deadline', 'po_baru', 'revisi', 'selesai', 'stok_habis')),
  pesan TEXT NOT NULL,
  data_referensi JSONB,
  read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Produksi Progress Table
CREATE TABLE produksi_progress (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  po_id UUID REFERENCES po(id) ON DELETE CASCADE,
  tahap VARCHAR(50) NOT NULL CHECK (tahap IN ('cutting', 'sablon', 'bordir', 'jahit', 'qc', 'packing')),
  status VARCHAR(50) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'berjalan', 'selesai')),
  tanggal_mulai TIMESTAMP,
  tanggal_selesai TIMESTAMP,
  catatan TEXT,
  foto_progress TEXT[],
  user_id UUID REFERENCES users(id) ON DELETE SET NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Costing Table
CREATE TABLE costing (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  po_id UUID REFERENCES po(id) ON DELETE CASCADE,
  bahan DECIMAL(12, 2),
  sablon DECIMAL(12, 2),
  jahit DECIMAL(12, 2),
  packing DECIMAL(12, 2),
  biaya_lainnya DECIMAL(12, 2) DEFAULT 0,
  total_hpp DECIMAL(12, 2),
  harga_jual DECIMAL(12, 2),
  margin DECIMAL(12, 2),
  keuntungan DECIMAL(12, 2),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Create Indexes
CREATE INDEX idx_po_customer ON po(customer);
CREATE INDEX idx_po_status ON po(status);
CREATE INDEX idx_po_deadline ON po(deadline);
CREATE INDEX idx_po_user_id ON po(user_id);
CREATE INDEX idx_inventory_kategori ON inventory(kategori);
CREATE INDEX idx_stok_history_inventory ON stok_history(inventory_id);
CREATE INDEX idx_notifikasi_user ON notifikasi(user_id);
CREATE INDEX idx_notifikasi_read ON notifikasi(read);
CREATE INDEX idx_produksi_progress_po ON produksi_progress(po_id);

-- Enable RLS (Row Level Security)
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE po ENABLE ROW LEVEL SECURITY;
ALTER TABLE inventory ENABLE ROW LEVEL SECURITY;
ALTER TABLE stok_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifikasi ENABLE ROW LEVEL SECURITY;
ALTER TABLE produksi_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE costing ENABLE ROW LEVEL SECURITY;

-- RLS Policies for Users
CREATE POLICY "Users can view own profile" ON users
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" ON users
  FOR UPDATE USING (auth.uid() = id);

-- RLS Policies for PO
CREATE POLICY "Everyone can view PO" ON po
  FOR SELECT USING (true);

CREATE POLICY "Admin and Owner can insert PO" ON po
  FOR INSERT WITH CHECK (
    EXISTS (SELECT 1 FROM users WHERE id = auth.uid() AND role IN ('admin', 'owner'))
  );

CREATE POLICY "Admin and Owner can update PO" ON po
  FOR UPDATE USING (
    EXISTS (SELECT 1 FROM users WHERE id = auth.uid() AND role IN ('admin', 'owner'))
  );

-- RLS Policies for Inventory
CREATE POLICY "Everyone can view inventory" ON inventory
  FOR SELECT USING (true);

CREATE POLICY "Admin can manage inventory" ON inventory
  FOR ALL USING (
    EXISTS (SELECT 1 FROM users WHERE id = auth.uid() AND role = 'admin')
  );

-- RLS Policies for Notifikasi
CREATE POLICY "Users can view own notifications" ON notifikasi
  FOR SELECT USING (auth.uid() = user_id);

-- RLS Policies for Produksi Progress
CREATE POLICY "Everyone can view progress" ON produksi_progress
  FOR SELECT USING (true);

CREATE POLICY "Divisi can update own progress" ON produksi_progress
  FOR UPDATE USING (
    EXISTS (SELECT 1 FROM users WHERE id = auth.uid())
  );
