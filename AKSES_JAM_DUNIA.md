# 🌍 JAM DUNIA INDONESIA - PANDUAN AKSES

## 📱 Link Akses untuk Semua Platform

### 🔗 Link Utama (Buka di Browser Apapun)
```
http://localhost:3000/clock
```

---

## 💻 **WINDOWS**

### Metode 1: Browser Langsung
1. **Chrome / Edge / Firefox**
   - Buka: `http://localhost:3000/clock`
   - Atau: `http://127.0.0.1:3000/clock`

2. **Dari Command Prompt:**
   ```cmd
   start http://localhost:3000/clock
   ```

3. **Buat Shortcut Desktop:**
   - Klik kanan Desktop → New → Shortcut
   - Masukkan: `http://localhost:3000/clock`
   - Beri nama: "Jam Dunia Indonesia"
   - Finish

### Metode 2: PWA (Progressive Web App)
1. Buka `http://localhost:3000/clock`
2. Klik ⋮ (menu) → "Install app"
3. Aplikasi akan installed seperti program normal

---

## 🍎 **MACOS / APPLE**

### Metode 1: Browser Safari / Chrome
1. **Safari:**
   - Buka: `http://localhost:3000/clock`
   - Cmd + Shift + D untuk tambah ke Desktop

2. **Chrome:**
   - Buka: `http://localhost:3000/clock`
   - Cmd + Shift + B (toggle bookmark bar)
   - Klik ⋮ → "Create shortcut"

3. **Dari Terminal:**
   ```bash
   open http://localhost:3000/clock
   ```

### Metode 2: PWA Installation
1. Buka `http://localhost:3000/clock` di Safari
2. Tap bagian bawah → "Add to Home Screen"
3. Aplikasi akan muncul di Launchpad

---

## 📱 **ANDROID**

### Metode 1: Chrome Browser
1. **Install Chrome** (jika belum ada)
2. Buka Chrome → ketik: `http://localhost:3000/clock`
3. Tap ⋮ (menu 3 garis) → "Add to Home screen"
4. Aplikasi akan muncul di Home Screen

### Metode 2: Akses Lokal Network
Jika ingin akses dari device Android lain di jaringan yang sama:

**Step 1: Cari IP Address PC Windows/Mac**

**Windows:**
```cmd
ipconfig
```
Cari "IPv4 Address" (biasanya 192.168.x.x)

**Mac:**
```bash
ifconfig | grep inet
```

**Step 2: Di Android, buka Chrome dan akses:**
```
http://[IP_ADDRESS]:3000/clock
```

Contoh: `http://192.168.1.100:3000/clock`

### Metode 3: PWA Installation (Android)
1. Buka Chrome
2. Akses: `http://localhost:3000/clock`
3. Tap ⋮ (menu) → "Install app" / "Add to Home screen"
4. Aplikasi akan installed

---

## 🌐 **AKSES ONLINE (Semua Platform)**

Untuk akses dari mana saja tanpa lokal server, deploy ke hosting:

### Option 1: Vercel (Gratis & Mudah)
```bash
npm install -g vercel
vercel
```
Setelah deploy, dapatkan URL public seperti:
```
https://imajinasii.vercel.app/clock
```

**Akses di semua platform:**
- 💻 Windows: `https://imajinasii.vercel.app/clock`
- 🍎 Mac: `https://imajinasii.vercel.app/clock`
- 📱 Android: `https://imajinasii.vercel.app/clock`

### Option 2: Netlify (Gratis)
1. Push ke GitHub
2. Connect ke Netlify
3. Dapatkan URL public

### Option 3: Heroku (Berbayar)
Deploy untuk akses dari mana saja

---

## ⚙️ **SETUP AWAL - JALANKAN SERVER LOKAL**

### Windows:
```cmd
cd path\to\imajinasii
npm install
npm run dev
```

Server berjalan di: `http://localhost:3000`

### Mac/Linux:
```bash
cd path/to/imajinasii
npm install
npm run dev
```

Server berjalan di: `http://localhost:3000`

---

## 📋 AKSES CEPAT - BOOKMARK/SHORTCUT

### Windows - Buat Shortcut:
1. Klik kanan di Desktop
2. New → Shortcut
3. Target: `C:\Program Files\Google\Chrome\Application\chrome.exe http://localhost:3000/clock`
4. Finish

### Mac - Buat Bookmark:
1. Safari → Bookmark → Bookmark This Page
2. Atau: Cmd + D

### Android - Add to Home Screen:
1. Chrome → ⋮ → Install app
2. Icon akan muncul di Home Screen

---

## 🔐 TROUBLESHOOTING

### ❌ "Cannot connect to localhost"
**Solusi:**
1. Pastikan server running: `npm run dev`
2. Coba: `http://127.0.0.1:3000/clock`
3. Clear browser cache (Ctrl+Shift+Delete)

### ❌ "ERR_CONNECTION_REFUSED"
**Solusi:**
1. Port 3000 sudah dipakai
2. Jalankan: `npm run dev -- -p 3001`
3. Akses: `http://localhost:3001/clock`

### ❌ Android tidak bisa akses Windows/Mac
**Solusi:**
1. Pastikan di network yang sama (WiFi)
2. Cari IP: `ipconfig` (Windows) atau `ifconfig` (Mac)
3. Akses: `http://[IP]:3000/clock`
4. Pastikan Firewall tidak block port 3000

### ❌ "Offline" di PWA
**Solusi:**
1. PWA memerlukan HTTPS di production
2. Untuk lokal, gunakan Chrome dengan flag: `--unsafely-treat-insecure-origin-as-secure=localhost:3000`

---

## 📊 TABEL RINGKAS AKSES

| Platform | Lokal | Network | Online |
|----------|-------|---------|--------|
| **Windows** | http://localhost:3000/clock | http://192.168.x.x:3000/clock | https://vercel-app.vercel.app/clock |
| **Mac** | http://localhost:3000/clock | http://192.168.x.x:3000/clock | https://vercel-app.vercel.app/clock |
| **Android** | N/A (perlu network) | http://192.168.x.x:3000/clock | https://vercel-app.vercel.app/clock |
| **iOS** | N/A (perlu network) | http://192.168.x.x:3000/clock | https://vercel-app.vercel.app/clock |

---

## 🎯 REKOMENDASI BEST PRACTICE

✅ **Untuk Development (Lokal):**
- Gunakan: `http://localhost:3000/clock`
- Untuk testing antar device: Gunakan IP address

✅ **Untuk Production (Live):**
- Deploy ke Vercel/Netlify
- Gunakan domain: `https://yourdomain.com/clock`
- Setup SSL/HTTPS

✅ **Untuk Mobile (PWA):**
- Install sebagai app
- Lebih cepat & offline support
- Icon di home screen

---

## 📞 SUPPORT

Jika ada masalah:
1. Check terminal apakah server running
2. Coba clear cache browser (Ctrl+Shift+Delete)
3. Restart browser
4. Restart server (Stop & `npm run dev` lagi)

---

**KONVEKSI ERP SYSTEM - JAM DUNIA INDONESIA** ✅
**Akses di Windows • Mac • Android • iOS** 🌍
