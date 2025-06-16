# Nama: Ahdina Sabilal Muna
# NIM: 221240001329

# Software Requirements Specification: Aplikasi Presensi Mobile

Dokumen Versi: 1.1
Tanggal: 20 Mei 2025 (Tanggal disesuaikan)

1. Pendahuluan

1.1 Tujuan
Aplikasi Presensi Mobile dirancang untuk memungkinkan pengguna (pegawai) melakukan pencatatan kehadiran (presensi) melalui perangkat mobile dan menyediakan antarmuka web admin untuk manajemen data.

1.2 Lingkup Produk (MVP - Minimum Viable Product)
MVP dari Aplikasi Presensi Mobile akan mencakup fitur-fitur berikut:

Aplikasi Mobile (Flutter):
1. Login pengguna (email & password).
2. Melakukan presensi masuk (clock-in) dengan pencatatan waktu dan lokasi GPS.
3. Melakukan presensi pulang (clock-out) dengan pencatatan waktu dan pembaruan lokasi GPS.
4. Menampilkan status presensi hari ini (jam masuk & jam pulang).
5. Menampilkan riwayat presensi pengguna.

Aplikasi Backend (Laravel) & Web Admin:
1. Menyediakan API RESTful untuk otentikasi dan manajemen presensi.
2. Menyediakan antarmuka web admin untuk:
    - Manajemen pengguna (tambah, lihat daftar pengguna).
    - Melihat rekapitulasi data presensi semua pengguna dengan fitur pencarian dan paginasi.
3. Hosting awal pada `punyazawa.com/presensi` (atau domain serupa).

1.3 Referensi
- Video Demonstrasi Aplikasi: [Deskripsi video yang dianalisis, misal: video presentasi internal tanggal DD-MM-YYYY]
- Repositori Backend GitHub: `https://github.com/SeptiawanAjiP/presensi-backend`
- Catatan Whiteboard Proses Pengembangan (Gambar terlampir dari permintaan awal)

2. Deskripsi Keseluruhan

2.1 Perspektif Produk
Aplikasi Presensi Mobile adalah aplikasi yang menerapkan sistem client-server. Klien adalah aplikasi mobile yang dikembangkan menggunakan Flutter, yang berinteraksi dengan server backend yang dikembangkan menggunakan Laravel. Backend juga menyediakan antarmuka web admin untuk manajemen.

2.2 Fungsi Produk
Fungsi utama produk adalah:
1.  Otentikasi pengguna aman melalui API.
2.  Pencatatan presensi masuk dan pulang berbasis lokasi GPS dan waktu real-time.
3.  Penyajian riwayat presensi untuk pengguna mobile secara personal.
4.  Manajemen pengguna (registrasi dan daftar) oleh admin melalui antarmuka web.
5.  Rekapitulasi dan pemantauan data presensi seluruh pengguna untuk admin.

2.3 Karakteristik Pengguna
Pegawai:
- Memiliki smartphone (Android/iOS) dengan akses internet dan GPS.
- Memahami cara menggunakan aplikasi mobile dasar.
- Membutuhkan cara yang cepat dan mudah untuk mencatat kehadiran.
Administrator:
- Memiliki pemahaman dasar tentang manajemen data dan penggunaan antarmuka web.
- Membutuhkan akses untuk mengelola akun pengguna dan memantau data presensi secara keseluruhan.
- Mengakses sistem melalui browser web standar.

2.4 Lingkungan Operasi
Aplikasi Mobile:
- Platform: Android (target awal, iOS dapat dikembangkan kemudian).
- Konektivitas: Membutuhkan koneksi internet aktif (Wi-Fi/Mobile Data) untuk sinkronisasi data.
- Sensor: Membutuhkan akses ke layanan lokasi (GPS).
Aplikasi Web Admin:
- Browser: Google Chrome, Mozilla Firefox, Safari, Microsoft Edge (versi terbaru yang stabil).
Server Backend:
- Platform: Server web yang mendukung PHP (versi >= 7.4 atau sesuai kebutuhan Laravel) dan Laravel (versi terbaru yang stabil).
- Database: MySQL (versi >= 5.7) atau PostgreSQL (versi >= 10).
- Hosting: Lingkungan hosting yang mendukung Laravel (misalnya, VPS, shared hosting dengan dukungan SSH jika diperlukan).

2.5 Batasan Desain dan Implementasi
1.  Aplikasi mobile harus dikembangkan menggunakan Flutter.
2.  Backend dan API harus dikembangkan menggunakan Laravel.
3.  API harus dirancang mengikuti prinsip RESTful dan menggunakan JSON sebagai format utama pertukaran data.
4.  Otentikasi API harus menggunakan token (misalnya, Bearer Token yang dihasilkan oleh Laravel Sanctum/Passport).
5.  Struktur data backend harus dinormalisasi dan dirancang untuk skalabilitas dan efisiensi query.
6.  UI/UX harus dirancang dengan mempertimbangkan kemudahan penggunaan (user-friendly) dan mengikuti pedoman desain platform (misalnya, Material Design).

2.6 Asumsi dan Ketergantungan
1.  Pengguna memiliki perangkat mobile yang kompatibel dengan GPS aktif dan koneksi internet yang stabil saat melakukan presensi.
2.  Akurasi data lokasi bergantung pada kualitas sinyal GPS perangkat pengguna dan lingkungan sekitar.
3.  Server backend dan API memiliki uptime yang tinggi dan dapat diakses secara konsisten oleh aplikasi mobile.
4.  Email pengguna bersifat unik dalam sistem dan digunakan sebagai identifier utama untuk login.
5.  Untuk MVP, pendaftaran pengguna baru (registrasi) dilakukan melalui panel web admin.

3. Persyaratan Spesifik

3.1 Persyaratan Fungsional

3.1.1 Manajemen Otentikasi Pengguna
FR1.1 - Login Pengguna (Mobile):
Deskripsi: Pengguna dapat login ke aplikasi mobile menggunakan email dan password yang telah didaftarkan oleh admin.
Pre-kondisi: Pengguna memiliki akun yang sudah terdaftar di sistem.
Input: Email, Password.
Proses: 1.  Aplikasi mobile mengirimkan kredensial (email dan password) ke endpoint API login.
        2.  Server backend memvalidasi kredensial terhadap data pengguna di database.
        3.  Jika valid, server mengembalikan token otentikasi (Bearer Token).
        4.  Aplikasi mobile menyimpan token tersebut secara aman di perangkat.
Output: Pengguna berhasil login dan diarahkan ke halaman utama aplikasi. Pesan error yang informatif ditampilkan jika login gagal (misalnya, "Email atau password salah").

        Diagram Alur Pengguna (Mermaid):
        ```mermaid
        sequenceDiagram
            participant P as Pengguna
            participant AM as Aplikasi Mobile
            participant API as Backend API
            participant DB as Database

            P->>AM: Membuka Aplikasi
            AM->>P: Menampilkan Halaman Login
            P->>AM: Memasukkan Email & Password
            P->>AM: Menekan Tombol "Login"
            AM->>API: Kirim Request Login (Email, Password)
            API->>DB: Validasi Kredensial
            DB-->>API: Hasil Validasi
            alt Kredensial Valid
                API-->>AM: Response Sukses (Token)
                AM->>AM: Simpan Token
                AM->>P: Arahkan ke Halaman Utama
            else Kredensial Tidak Valid
                API-->>AM: Response Gagal (Pesan Error)
                AM->>P: Tampilkan Pesan Error
            end
        ```

FR1.2 - Login Administrator (Web):
Deskripsi: Administrator dapat login ke panel web admin menggunakan email dan password yang sesuai.
Pre-kondisi: Administrator memiliki akun yang valid.
Input: Email, Password.
Proses: Sistem memvalidasi kredensial admin.
Output: Administrator berhasil login dan diarahkan ke dashboard admin. Pesan error jika gagal.

3.1.2 Manajemen Presensi (Mobile)
FR2.1 - Presensi Masuk (Clock-in):
Deskripsi: Pengguna dapat melakukan presensi masuk untuk hari berjalan.
Pre-kondisi: Pengguna sudah login. Pengguna belum melakukan presensi masuk untuk hari itu.
Input: Aksi pengguna pada tombol presensi.
Proses: 1.  Pengguna menekan tombol "Presensi" (misalnya, FAB '+') di halaman utama.
        2.  Aplikasi meminta izin akses lokasi jika belum pernah diberikan atau jika izin dicabut.
        3.  Aplikasi mengambil koordinat GPS (latitude, longitude) saat ini dan menampilkan peta dengan penanda lokasi pengguna.
        4.  Pengguna menekan tombol "Simpan Presensi" pada halaman peta.
        5.  Aplikasi mobile mengirimkan data waktu saat ini (otomatis dari perangkat/server) dan koordinat GPS ke endpoint API simpan presensi.
        6.  Server backend menyimpan data tersebut sebagai entri presensi baru (jam masuk) untuk pengguna tersebut pada tanggal hari ini.
Output: Pesan sukses ("Sukses simpan presensi") ditampilkan. Status presensi hari ini di halaman utama diperbarui untuk menampilkan jam masuk yang baru saja dicatat.
        Diagram Alur Pengguna (Mermaid):
        ```mermaid
        sequenceDiagram
            participant P as Pengguna
            participant AM as Aplikasi Mobile
            participant GPS as Layanan Lokasi
            participant API as Backend API
            participant DB as Database

            P->>AM: Di Halaman Utama, Menekan Tombol FAB (+)
            AM->>GPS: Meminta Izin & Ambil Koordinat Lokasi
            GPS-->>AM: Koordinat (Lat, Lon)
            AM->>P: Menampilkan Halaman Peta dengan Lokasi
            P->>AM: Menekan Tombol "Simpan Presensi"
            AM->>API: Kirim Request Simpan Presensi (Lat, Lon, Token Auth)
            API->>DB: Simpan Data Presensi Masuk (user_id, tanggal, jam_masuk, lokasi)
            DB-->>API: Konfirmasi Simpan
            API-->>AM: Response Sukses
            AM->>P: Tampilkan Pesan Sukses
            AM->>AM: Perbarui Tampilan Halaman Utama (Jam Masuk)
        ```

FR2.2 - Presensi Pulang (Clock-out):
Deskripsi: Pengguna dapat melakukan presensi pulang untuk hari berjalan.
Pre-kondisi: Pengguna sudah login dan sudah melakukan presensi masuk pada hari itu, tetapi belum melakukan presensi pulang.
Input: Aksi pengguna pada tombol presensi.
Proses: 1.  Pengguna menekan tombol "Presensi" (misalnya, FAB '+') di halaman utama.
        2.  Aplikasi mengambil koordinat GPS (latitude, longitude) saat ini dan menampilkan peta dengan penanda lokasi pengguna.
        3.  Pengguna menekan tombol "Simpan Presensi" pada halaman peta.
        4.  Aplikasi mobile mengirimkan data waktu saat ini dan koordinat GPS ke endpoint API simpan presensi.
        5.  Server backend mencari entri presensi masuk pengguna untuk hari itu, kemudian memperbarui entri tersebut dengan jam pulang dan (opsional) lokasi pulang.
Output: Pesan sukses ("Sukses simpan presensi") ditampilkan. Status presensi hari ini di halaman utama diperbarui untuk menampilkan jam pulang yang baru saja dicatat.
        Diagram Alur Pengguna (Mermaid):
        ```mermaid
        sequenceDiagram
            participant P as Pengguna
            participant AM as Aplikasi Mobile
            participant GPS as Layanan Lokasi
            participant API as Backend API
            participant DB as Database

            P->>AM: Di Halaman Utama, Menekan Tombol FAB (+)
            AM->>GPS: Meminta Izin & Ambil Koordinat Lokasi
            GPS-->>AM: Koordinat (Lat, Lon)
            AM->>P: Menampilkan Halaman Peta dengan Lokasi
            P->>AM: Menekan Tombol "Simpan Presensi"
            AM->>API: Kirim Request Simpan Presensi (Lat, Lon, Token Auth)
            API->>DB: Update Data Presensi (jam_pulang, lokasi_pulang) untuk entri hari ini
            DB-->>API: Konfirmasi Update
            API-->>AM: Response Sukses
            AM->>P: Tampilkan Pesan Sukses
            AM->>AM: Perbarui Tampilan Halaman Utama (Jam Pulang)
        ```

3.1.3 Pelaporan dan Riwayat Presensi (Mobile)
FR3.1 - Tampilan Status Presensi Hari Ini:
Deskripsi: Aplikasi menampilkan status presensi pengguna untuk hari berjalan (tanggal, jam masuk, dan jam pulang jika sudah ada) di bagian atas halaman utama.
Proses: Saat halaman utama dimuat atau setelah aksi presensi, aplikasi mengambil data presensi terbaru untuk hari ini dari server (melalui API `get-presensi`).
Output: Tampilan visual yang jelas mengenai status presensi hari ini.
FR3.2 - Tampilan Riwayat Presensi:
Deskripsi: Aplikasi menampilkan daftar riwayat presensi pengguna untuk hari-hari sebelumnya.
Proses: Aplikasi mengambil daftar data riwayat presensi dari server (melalui API `get-presensi`).
Output: Daftar yang dapat di-scroll, menampilkan entri presensi per hari (Tanggal, Jam Masuk, Jam Pulang).

3.1.4 Manajemen Pengguna (Web Admin)
FR4.1 - Tambah Pengguna Baru:
Deskripsi: Administrator dapat menambahkan pengguna (pegawai) baru ke sistem melalui panel web admin.
Pre-kondisi: Admin sudah login.
Input: Nama, Email, Password, Konfirmasi Password.
Proses: Data pengguna baru disimpan ke tabel `users` di database. Password di-hash.
Output: Pengguna baru berhasil ditambahkan. Pesan sukses ditampilkan. Admin diarahkan kembali ke daftar pengguna atau halaman dashboard.
FR4.2 - Lihat Daftar Pengguna:
Deskripsi: Administrator dapat melihat daftar semua pengguna yang terdaftar di sistem.
Pre-kondisi: Admin sudah login.
Output: Tabel yang menampilkan daftar pengguna (misalnya, ID, Nama, Email). Paginasi jika jumlah pengguna banyak.

3.1.5 Rekapitulasi Presensi (Web Admin)
FR5.1 - Lihat Rekap Presensi:
Deskripsi: Administrator dapat melihat rekapitulasi data presensi semua pengguna.
Pre-kondisi: Admin sudah login.
Output: Tabel yang menampilkan data presensi dengan kolom: Nama Pegawai, Waktu (Hari, Tanggal), Jam Masuk, Jam Pulang, Lokasi (Latitude, Longitude).
Fitur Tambahan:
- Pencarian data presensi (misalnya, berdasarkan nama pegawai atau rentang tanggal).
- Paginasi untuk menampilkan data dalam jumlah besar.
- (Opsional MVP) Filter berdasarkan tanggal.

3.2 Persyaratan Non-Fungsional
3.2.1 Kinerja
NFR1.1: Waktu respons API (login, simpan presensi, get presensi) harus kurang dari 2 detik dalam kondisi jaringan normal (misalnya, 3G/4G).
NFR1.2: Aplikasi mobile harus memuat halaman utama dan menampilkan data presensi awal dalam waktu kurang dari 3 detik setelah login berhasil.
NFR1.3: Proses pengambilan data lokasi GPS dan penampilan peta harus selesai dalam waktu kurang dari 5 detik.

3.2.2 Keamanan
NFR2.1: Password pengguna harus di-hash menggunakan algoritma yang kuat (misalnya, bcrypt) sebelum disimpan di database.
NFR2.2: Komunikasi antara aplikasi mobile dan API harus dienkripsi menggunakan HTTPS.
NFR2.3: Akses ke endpoint API yang memerlukan otentikasi harus dilindungi oleh Bearer Token. Token harus memiliki masa berlaku yang wajar dan mekanisme refresh jika diperlukan.
NFR2.4: Validasi input harus dilakukan secara ketat baik di sisi klien (aplikasi mobile) maupun di sisi server (backend API) untuk mencegah serangan umum seperti XSS, SQL Injection, dll.
NFR2.5: Akses ke panel web admin harus dilindungi dengan mekanisme otentikasi yang kuat dan sesi yang aman.

3.2.3 Usabilitas
NFR3.1: Antarmuka pengguna (mobile dan web) harus intuitif, konsisten, dan mudah dipelajari oleh pengguna target.
NFR3.2: Aplikasi harus memberikan feedback visual yang jelas kepada pengguna untuk setiap aksi penting (misalnya, pesan sukses, pesan error, indikator loading).
NFR3.3: Proses presensi (masuk dan pulang) harus dapat diselesaikan dengan jumlah klik/interaksi minimal.

3.2.4 Keandalan
NFR4.1: Sistem backend harus mampu menangani setidaknya 50 pengguna aktif secara konkuren melakukan presensi (untuk MVP).
NFR4.2: Data presensi yang sudah berhasil disimpan di server tidak boleh hilang atau mengalami korupsi data. Mekanisme backup database reguler harus dipertimbangkan.
NFR4.3: Aplikasi mobile harus dapat menangani kondisi koneksi internet yang terputus atau tidak stabil dengan baik, misalnya dengan menyimpan antrian presensi lokal (jika diimplementasikan di luar MVP) atau menampilkan pesan error yang jelas.

3.3 Persyaratan Antarmuka Eksternal

3.3.1 Antarmuka Pengguna (UI)
Aplikasi Mobile (Flutter):
    Halaman Login: 
    * Input field untuk Email.
    * Input field untuk Password (dengan opsi tampilkan/sembunyikan password).
    * Tombol "Login".
    Halaman Utama (Dashboard Pengguna):
    * Header: Menampilkan nama pengguna (misalnya, "Pegawai A").
    * Kartu Informasi Presensi Hari Ini:
    - Menampilkan tanggal hari ini (misalnya, "Selasa, 23 Agustus 2022").
    - Menampilkan jam masuk (misalnya, "03:27 Masuk").
    - Menampilkan jam pulang (misalnya, "04:07 Pulang").
    Bagian Riwayat Presensi:
    - Judul "Riwayat Presensi".
    - Daftar (scrollable) entri riwayat, masing-masing menampilkan: Tanggal, Jam Masuk, Jam Pulang.
    - Tombol Aksi Mengambang (FAB) dengan ikon '+' untuk memulai proses presensi.
    Halaman Presensi (Peta):
    - Header: Judul "Presensi".
    - Area Peta: Menampilkan peta interaktif (misalnya, Google Maps) dengan penanda (marker) di lokasi GPS pengguna saat ini.
    - Tombol "Simpan Presensi" di bawah peta.
    Dialog:
    - Dialog konfirmasi izin akses lokasi.
    - Dialog/Snackbar untuk pesan sukses atau error.
*   **Aplikasi Web Admin (Laravel):**
    *   **Halaman Login Admin:**
        *   Input field untuk Email.
        *   Input field untuk Password.
        *   Tombol "Login".
    *   **Dashboard/Rekap Presensi:**
        *   Header dengan navigasi (misalnya, "Rekap Presensi", "Daftar User", "Logout", Nama Admin).
        *   Fitur "Show [X] entries" untuk jumlah data per halaman.
        *   Fitur "Search" untuk filter data tabel.
        *   Tabel Rekap Presensi: Kolom (No, Nama, Waktu, Masuk, Pulang, Lokasi (Latitude, Longitude)).
        *   Kontrol Paginasi ("Previous", "Next", nomor halaman).
    *   **Halaman Daftar User:**
        *   Tombol "+ Tambah User".
        *   Fitur "Show [X] entries" dan "Search".
        *   Tabel Daftar User: Kolom (No, Nama, Email).
        *   Paginasi.
    *   **Halaman/Form Tambah User:**
        *   Input field untuk Nama.
        *   Input field untuk Email Address.
        *   Input field untuk Password.
        *   Input field untuk Confirm Password.
        *   Tombol "Register".

3.3.2 Antarmuka API
*   **Base URL:** `https://punyazawa.com/presensi/public` (Contoh dari video, bisa disesuaikan)
*   **Endpoint 1: Login**
    *   **URL:** `/api/login`
    *   **Metode:** `POST`
    *   **Request Body (JSON):** `{ "email": "user@example.com", "password": "password123" }`
    *   **Response Sukses (JSON, 200 OK):**
        ```json
        {
          "success": true,
          "message": "Hi [Nama Pengguna], selamat datang di sistem presensi",
          "data": {
            "id": 2,
            "name": "Pegawai A",
            "email": "pegawai_a@gmail.com",
            "email_verified_at": null,
            "created_at": "2022-08-19T13:59:29.000000Z",
            "updated_at": "2022-08-19T13:59:29.000000Z"
          },
          "token": "eyJh... (Bearer Token)",
          "token_type": "Bearer"
        }
        ```
    *   **Response Gagal (JSON, 401 Unauthorized / 422 Unprocessable Entity):**
        ```json
        { "success": false, "message": "Email atau password salah." } // Contoh
        ```
*   **Endpoint 2: Get Presensi (Riwayat & Status Hari Ini)**
    *   **URL:** `/api/get-presensi`
    *   **Metode:** `GET`
    *   **Headers:** `Authorization: Bearer <token>`, `Accept: application/json`
    *   **Response Sukses (JSON, 200 OK):**
        ```json
        {
          "success": true,
          "data": [
            {
              "id": 1,
              "user_id": 2,
              "latitude": "-7.45756",
              "longitude": "109.29880",
              "tanggal": "Sabtu, 20 Agustus 2022",
              "masuk": "03:15",
              "pulang": "03:21",
              "created_at": "...",
              "updated_at": "...",
              "is_hari_ini": false // Indikator apakah ini presensi hari ini
            },
            // ... entri lain
            {
              "id": 4,
              "user_id": 2,
              "latitude": "-7.45756",
              "longitude": "109.29880",
              "tanggal": "Selasa, 23 Agustus 2022",
              "masuk": "03:27",
              "pulang": "03:59", // Bisa null jika belum pulang
              "created_at": "...",
              "updated_at": "...",
              "is_hari_ini": true
            }
          ],
          "message": "Sukses menampilkan data"
        }
        ```
*   **Endpoint 3: Simpan Presensi**
    *   **URL:** `/api/simpan-presensi`
    *   **Metode:** `POST`
    *   **Headers:** `Authorization: Bearer <token>`, `Accept: application/json`, `Content-Type: application/json`
    *   **Request Body (JSON):** `{ "latitude": "-7.12345", "longitude": "110.54321" }`
    *   **Response Sukses (JSON, 200 OK / 201 Created):**
        ```json
        {
          "success": true,
          "message": "Sukses simpan presensi",
          "data": { // Data presensi yang baru disimpan/diupdate
            "id": 4,
            "user_id": 2,
            "latitude": "-7.12345",
            "longitude": "110.54321",
            "tanggal": "Selasa, 23 Agustus 2022",
            "masuk": "03:27", // Jika ini presensi masuk
            "pulang": "04:07"  // Jika ini presensi pulang (update)
            // ...
          }
        }
        ```
    *   **Response Gagal (JSON, 400 Bad Request / 422 Unprocessable Entity):**
        ```json
        { "success": false, "message": "Gagal menyimpan presensi. Data tidak valid." } // Contoh
        ```

---

4. Model Data (Gambaran Umum)

*   **Tabel `users`:**
    *   `id` (BIGINT, Primary Key, Auto Increment, Unsigned)
    *   `name` (VARCHAR(255))
    *   `email` (VARCHAR(255), Unique)
    *   `password` (VARCHAR(255), Hashed)
    *   `email_verified_at` (TIMESTAMP, Nullable)
    *   `remember_token` (VARCHAR(100), Nullable)
    *   `created_at` (TIMESTAMP, Nullable)
    *   `updated_at` (TIMESTAMP, Nullable)
*   **Tabel `presensi` (atau `attendances`):**
    *   `id` (BIGINT, Primary Key, Auto Increment, Unsigned)
    *   `user_id` (BIGINT, Unsigned, Foreign Key ke `users.id` on DELETE CASCADE)
    *   `tanggal` (DATE)
    *   `jam_masuk` (TIME)
    *   `jam_pulang` (TIME, Nullable)
    *   `latitude` (VARCHAR(50) atau DECIMAL(10, 8))
    *   `longitude` (VARCHAR(50) atau DECIMAL(11, 8))
    *   `created_at` (TIMESTAMP, Nullable)
    *   `updated_at` (TIMESTAMP, Nullable)

    *Catatan: Penggunaan `VARCHAR` untuk latitude/longitude umum jika presisi tidak terlalu kritis. `DECIMAL` lebih akurat. `tanggal` dan `jam_masuk`/`jam_pulang` dipisah untuk query yang lebih mudah.*

---

5. Rencana Iterasi Pengembangan (Sesuai Whiteboard)

Proses pengembangan yang diuraikan di whiteboard akan diikuti, dengan penekanan pada iterasi dan feedback berkelanjutan:
1.  **Brainstorming & Requirement Gathering:**
    *   Diskusi mendalam dengan pengguna (stakeholder) untuk memahami masalah dan kebutuhan.
    *   Analisis dan riset aplikasi sejenis sebagai referensi.
2.  **Definisi Cakupan MVP:** Menentukan fitur inti yang akan dibangun pertama kali.
3.  **Penyusunan Dokumen SRS:** Pembuatan dan finalisasi dokumen ini.
4.  **Perancangan Arsitektur Sistem:**
    *   Desain arsitektur backend (Laravel), termasuk struktur database dan API.
    *   Desain arsitektur frontend (Flutter), termasuk alur navigasi dan manajemen state.
    *   Perbaikan SRS jika ada temuan baru dari perancangan arsitektur.
5.  **Breakdown Iterasi & Perencanaan Timeline:**
    *   Membagi pekerjaan menjadi iterasi yang lebih kecil (misalnya, sprint 1-2 minggu).
    *   Menetapkan target dan timeline untuk setiap iterasi.
6.  **Implementasi dan Pengujian Iteratif:**
    *   **Pengembangan UI/UX (Frontend):**
        *   Desain wireframe dan mockup.
        *   Implementasi UI per halaman atau fitur dengan data dummy.
    *   **Pengembangan Backend & API:**
        *   Implementasi model, controller, dan route untuk API.
        *   Pengembangan struktur database dan migrasi.
    *   **Integrasi Frontend & Backend:**
        *   Menghubungkan UI aplikasi mobile dengan API backend.
        *   Mengganti data dummy dengan data real dari API.
    *   **Pengujian:**
        *   Pengujian unit untuk komponen backend dan frontend.
        *   Pengujian integrasi API.
        *   Pengujian fungsional dan usability oleh tim QA dan/atau pengguna.
    *   **Polishing & Refinement:** Penyempurnaan UI/UX berdasarkan feedback, perbaikan bug.
7.  **Deployment dan Rilis MVP.**
8.  **Monitoring dan Iterasi Lanjutan:** Pengumpulan feedback pasca-rilis dan perencanaan untuk pengembangan fitur selanjutnya.

---

6. Potensi Pengembangan di Masa Depan
*   Fitur registrasi pengguna langsung dari aplikasi mobile.
*   Fitur "Lupa Password" untuk pengguna mobile dan admin.
*   Notifikasi pengingat untuk melakukan presensi masuk atau pulang.
*   Mode offline untuk presensi: Pengguna dapat melakukan presensi saat tidak ada koneksi internet, dan data akan disinkronkan otomatis saat koneksi kembali tersedia.
*   Fitur export data rekap presensi (misalnya, ke format CSV atau Excel) dari panel web admin.
*   Manajemen shift kerja untuk pengguna.
*   Integrasi dengan kalender untuk pengajuan izin atau cuti.
*   Fitur geo-fencing untuk membatasi area presensi yang valid.
*   Dashboard analitik yang lebih kaya di panel admin.