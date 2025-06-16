## Laporan Progres Mingguan: Aplikasi Presensi Mobile

**Nama:** Ahdina Sabilal Muna
**NIM:** 221240001329
**Proyek:** Aplikasi Presensi Mobile
**Minggu ke:** 1 (Pelaporan Progres Awal Pengembangan)
**Tanggal Laporan:** [Tanggal Akhir Minggu ke-1 Pelaporan Anda]

---

### Tujuan yang Telah Dicapai (Progres Awal Pengembangan):

Menyelesaikan implementasi fungsionalitas otentikasi pengguna (login) secara penuh dari frontend (Flutter) ke backend (Laravel), serta membangun halaman utama (homepage) di aplikasi mobile yang dapat menampilkan data awal pengguna dan status presensi dari API backend.

---

### Progres Utama yang Telah Diselesaikan:

1.  **Setup Proyek & Fondasi Aplikasi:**
    *   **Backend (Laravel):** Proyek telah diinisialisasi, database (tabel `users` dan `presensi`) telah dikonfigurasi dan dimigrasi.
    *   **Frontend (Flutter):** Proyek telah diinisialisasi dengan struktur folder yang baik.

2.  **Otentikasi Pengguna (Mobile & Backend):**
    *   **Backend (Laravel):** API Login (`/api/login`) menggunakan Laravel Sanctum telah berhasil dibuat, diuji dengan Postman, dan berfungsi dengan baik.
    *   **Frontend (Flutter):** Halaman login UI telah diimplementasikan. Logika untuk mengirim permintaan login ke API backend, menerima, dan menyimpan token otentikasi (misalnya menggunakan `flutter_secure_storage`) telah selesai. Pengguna berhasil diarahkan ke halaman utama setelah login sukses.
    *   **Status Penyelesaian Modul Otentikasi: 100% Selesai.**

3.  **Halaman Utama (Homepage - Mobile) & API Data Awal:**
    *   **Backend (Laravel):** API untuk mengambil data presensi pengguna (`/api/get-presensi`) telah dibuat dan dapat mengembalikan data riwayat serta status presensi hari ini.
    *   **Frontend (Flutter):** UI dasar untuk homepage telah selesai, mampu menampilkan informasi pengguna (nama) dan data presensi awal (status hari ini & daftar riwayat) yang diterima dari API `/api/get-presensi`.
    *   **Status Penyelesaian Modul Tampilan Data Awal Homepage: 100% Selesai.**

---

### Task yang Sedang Dikerjakan / Fokus Berikutnya (Memasuki Fitur Inti Presensi):

*   **Backend (Laravel):**
    *   Finalisasi dan pengujian menyeluruh API untuk **menyimpan presensi** (`/api/simpan-presensi`). Ini mencakup logika untuk membedakan antara presensi masuk dan presensi pulang, serta validasi data lokasi.
*   **Frontend (Flutter):**
    *   Implementasi fitur pengambilan **lokasi GPS** dari perangkat pengguna.
    *   Integrasi dan tampilan **peta interaktif** (misalnya, Google Maps) pada halaman khusus untuk aksi presensi.
    *   Pembuatan UI untuk halaman aksi presensi (tombol "Simpan Presensi" di atas peta).
    *   Menghubungkan UI aksi presensi dengan API `/api/simpan-presensi` untuk mengirim data waktu dan lokasi.
    *   Memastikan data di homepage (status presensi hari ini dan riwayat) ter-refresh secara otomatis setelah pengguna berhasil melakukan presensi.

---

### Persentase Progres Keseluruhan MVP (Estimasi Kasar):

*   Mengingat modul otentikasi dan tampilan data awal di homepage adalah fondasi penting, kita bisa estimasikan sekitar **35-45%** dari total pekerjaan MVP telah diselesaikan. Implementasi mekanisme presensi itu sendiri (menyimpan data & peta) akan menjadi bagian besar berikutnya.

---

### Kendala / Tantangan yang Diantisipasi:

*   Memastikan akurasi dan keandalan pengambilan data lokasi GPS.
*   Konfigurasi dan kustomisasi tampilan peta agar user-friendly.
*   Penanganan berbagai skenario pada API simpan presensi (misalnya, pengguna mencoba presensi di luar jam kerja atau di luar radius yang diizinkan – jika fitur ini ada).

---

### Rencana untuk Minggu Depan (Minggu ke-2 Pelaporan):

1.  Menyelesaikan implementasi API `/api/simpan-presensi` di backend, termasuk pengujiannya.
2.  Mengimplementasikan fitur pengambilan lokasi GPS dan tampilan peta di aplikasi Flutter.
3.  Mulai menghubungkan aksi "Simpan Presensi" dari aplikasi mobile ke API backend.