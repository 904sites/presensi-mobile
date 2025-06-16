# Nama: Ahdina Sabilal Muna
# NIM: 221240001329

Persiapan Awal Komprehensif (Langkah Demi Langkah untuk Pemula)
Fase 1: Pemahaman dan Perencanaan (Mirip Poin 1 & 2 Whiteboard)

Langkah 1.1: Memahami Masalah Inti (Brainstorming - Diskusi dengan Pengguna)

Tujuan: Benar-benar mengerti mengapa aplikasi ini dibutuhkan dan masalah apa yang ingin diselesaikannya.

Tindakan (Jika Anda memiliki "pengguna" atau "klien" nyata):

Jadwalkan Diskusi: Ajak bicara orang yang akan menggunakan aplikasi ini (misalnya, jika ini untuk perusahaan kecil, bicara dengan pemilik atau beberapa calon pegawai).

Siapkan Pertanyaan:

"Apa kesulitan yang Anda hadapi saat ini dalam mencatat kehadiran?"

"Fitur apa yang paling penting menurut Anda untuk aplikasi presensi?"

"Bagaimana proses presensi yang ideal menurut Anda?"

"Apakah ada batasan khusus yang perlu diperhatikan (misalnya, area kantor tertentu)?"

"Informasi apa saja yang perlu dilihat oleh admin terkait presensi?"

Dengarkan Aktif & Catat: Catat semua masukan, keluhan, dan ide. Jangan menyela, biarkan mereka bercerita.

Tanyakan "Mengapa": Untuk setiap permintaan fitur, coba gali "mengapa" mereka membutuhkannya. Ini membantu memahami akar masalah.

Tindakan (Jika ini proyek pribadi/belajar):

Bayangkan Anda adalah Pengguna: Posisikan diri Anda sebagai pegawai dan sebagai admin. Masalah apa yang ingin Anda selesaikan?

Definisikan Tujuan Pribadi: Apa yang ingin Anda capai dengan membuat aplikasi ini (belajar teknologi, membuat portofolio, dll.)?

Output: Catatan detail hasil diskusi atau pemikiran Anda, daftar masalah utama yang ingin diselesaikan.

Langkah 1.2: Riset Aplikasi Sejenis

Tujuan: Mendapatkan inspirasi, memahami standar industri, dan melihat fitur apa saja yang umum ada.

Tindakan:

Cari di App Store/Play Store: Ketik kata kunci seperti "aplikasi presensi", "employee attendance", "time clock app".

Unduh & Coba Beberapa Aplikasi: Perhatikan:

Alur pengguna (bagaimana cara login, presensi, lihat riwayat).

Desain antarmuka (UI) dan pengalaman pengguna (UX).

Fitur-fitur yang ditawarkan.

Kelebihan dan kekurangan masing-masing aplikasi.

Baca Ulasan Pengguna: Ulasan bisa memberikan insight berharga tentang apa yang disukai dan tidak disukai pengguna.

Output: Daftar fitur umum, ide desain, dan pemahaman tentang apa yang berhasil (dan tidak) di aplikasi lain.

Langkah 1.3: Menentukan Cakupan MVP (Minimum Viable Product)

Tujuan: Memilih fitur-fitur paling inti yang harus ada agar aplikasi bisa berfungsi dan memberikan nilai minimal kepada pengguna. Ini penting agar proyek tidak terlalu besar di awal.

Tindakan:

Review Catatan Brainstorming & Riset: Dari semua ide dan fitur yang terkumpul.

Prioritaskan: Gunakan metode seperti MoSCoW (Must have, Should have, Could have, Won't have) atau tanyakan pada diri sendiri/klien: "Tanpa fitur ini, apakah aplikasi masih bisa disebut aplikasi presensi yang berfungsi?"

Must have (Harus Ada): Login, Presensi Masuk, Presensi Pulang, Lihat Status Hari Ini, Lihat Riwayat Dasar (Mobile). Tampilan Rekap Presensi, Tambah User (Web Admin).

Should have (Sebaiknya Ada): Notifikasi, Lupa Password (mungkin bisa ditunda setelah MVP).

Could have (Bisa Ada Nanti): Laporan detail, export data, pengajuan izin.

Won't have (Tidak Akan Ada di MVP ini): Fitur yang terlalu kompleks atau di luar fokus utama.

Fokus pada Alur Inti: Pastikan alur utama dari login hingga presensi tercakup.

Output: Daftar fitur yang terpilih untuk MVP. Ini akan menjadi dasar untuk SRS.

Contoh MVP dari SRS sebelumnya sudah cukup baik: Login, Presensi Mobile (Masuk & Pulang dengan GPS), Status & Riwayat Mobile, Manajemen User & Rekap Presensi Web Admin.

Fase 2: Dokumentasi (Mirip Poin 3 Whiteboard)

Langkah 2.1: Penyusunan Dokumen SRS (Software Requirements Specification)

Tujuan: Mendokumentasikan secara formal semua kebutuhan aplikasi (fungsional dan non-fungsional) agar ada panduan yang jelas bagi tim pengembang (atau diri Anda sendiri).

Tindakan:

Gunakan Template SRS: Anda bisa menggunakan template SRS yang sudah kita buat sebelumnya sebagai dasar.

Isi Setiap Bagian:

Pendahuluan: Jelaskan tujuan aplikasi, lingkup MVP yang sudah ditentukan.

Deskripsi Keseluruhan: Jelaskan bagaimana aplikasi akan bekerja, siapa penggunanya, dan lingkungan operasinya.

Persyaratan Fungsional:

Detailkan setiap fitur MVP. Contoh: Untuk "Login Pengguna (Mobile)", tuliskan inputnya (email, password), prosesnya (validasi ke API), dan outputnya (berhasil login, token disimpan, atau pesan error).

Buat diagram alur pengguna (seperti yang diminta dengan Mermaid) untuk fitur-fitur utama. Ini sangat membantu memvisualisasikan interaksi.

Persyaratan Non-Fungsional: Pikirkan aspek seperti:

Kinerja: Seberapa cepat aplikasi harus merespons?

Keamanan: Bagaimana data pengguna dan password akan dilindungi?

Usabilitas: Seberapa mudah aplikasi harus digunakan?

Persyaratan Antarmuka Eksternal: Deskripsikan tampilan (UI) secara kasar dan bagaimana API akan berinteraksi.

Model Data Awal: Gambarkan struktur tabel database yang akan digunakan (misalnya, tabel users dan presensi).

Jelas dan Tidak Ambigu: Gunakan bahasa yang mudah dimengerti. Hindari istilah teknis yang berlebihan jika audiensnya non-teknis.

Dapat Diuji: Setiap persyaratan harus bisa diuji untuk memastikan apakah sudah terpenuhi atau belum.

Output: Dokumen SRS versi pertama yang lengkap dan detail.

Fase 3: Perancangan Teknis Awal (Mirip Poin 4 Whiteboard)

Langkah 3.1: Memilih Teknologi (Jika Belum Ditentukan)

Tujuan: Menentukan tools dan framework yang akan digunakan. Dalam kasus ini, sudah ditentukan: Flutter untuk mobile dan Laravel untuk backend.

Tindakan:

Pastikan Versi: Tentukan versi spesifik Flutter dan Laravel yang akan digunakan (biasanya versi stabil terbaru adalah pilihan baik).

Database: Pilih sistem database (misalnya, MySQL, PostgreSQL). MySQL seringkali menjadi pilihan awal yang baik untuk Laravel.

Server: Pikirkan di mana backend akan di-hosting (untuk pengembangan awal, bisa di komputer lokal dulu. Untuk punyazawa.com/presensi, itu berarti sudah ada rencana hosting).

Output: Daftar teknologi dan versinya yang akan digunakan.

Langkah 3.2: Merancang Arsitektur Backend Awal (Laravel)

Tujuan: Merencanakan bagaimana komponen-komponen backend akan disusun.

Tindakan:

Desain Struktur Database Detail:

Berdasarkan model data di SRS, tentukan tipe data untuk setiap kolom, relasi antar tabel (misalnya, user_id di tabel presensi adalah foreign key ke id di tabel users), dan constraint (misalnya, email harus unik).

Ini akan menjadi dasar untuk membuat migrations di Laravel.

Desain Endpoint API Detail:

Untuk setiap API yang disebutkan di SRS (login, simpan presensi, get presensi):

Tentukan URL lengkap (misalnya, /api/login).

Tentukan metode HTTP (POST, GET).

Tentukan request body yang diharapkan (jika ada, misalnya untuk login dan simpan presensi).

Tentukan format response JSON yang akan dikembalikan (baik untuk sukses maupun gagal).

Pikirkan header yang dibutuhkan (misalnya, Authorization untuk token, Content-Type).

Rencanakan Struktur Folder Backend: Bagaimana Anda akan mengorganisir Controllers, Models, Routes, dll. di proyek Laravel.

Otentikasi API: Putuskan bagaimana otentikasi API akan diimplementasikan (Laravel Sanctum adalah pilihan populer dan relatif mudah untuk API mobile).

Output:

Skema database yang lebih detail.

Spesifikasi API yang lebih rinci (sering disebut juga kontrak API).

Rencana struktur folder proyek Laravel.

Langkah 3.3: Merancang Arsitektur Frontend Awal (Flutter)

Tujuan: Merencanakan bagaimana komponen-komponen aplikasi mobile akan disusun.

Tindakan:

Rancang Alur Navigasi Detail:

Buat diagram sederhana (atau coretan tangan) yang menunjukkan bagaimana pengguna berpindah dari satu layar ke layar lainnya (misalnya, Splash Screen -> Login Screen -> Home Screen -> Presensi Map Screen).

Pilih State Management: Ini keputusan penting di Flutter.

Untuk Pemula:

Provider: Cukup populer, relatif mudah dipelajari, dan didukung baik oleh komunitas.

GetX: Menawarkan state management, routing, dan dependency injection dengan sintaks yang ringkas. Beberapa pemula merasa lebih cepat untuk memulai.

Hindari BLoC/Cubit jika ini proyek pertama Anda dan Anda sendirian, karena kurva belajarnya mungkin lebih curam.

Identifikasi Komponen UI yang Dapat Digunakan Ulang (Widgets): Pikirkan apakah ada bagian UI yang akan muncul di banyak layar (misalnya, tombol kustom, card item riwayat). Ini bisa dibuat sebagai reusable widgets.

Rencanakan Struktur Folder Frontend: Bagaimana Anda akan mengorganisir screens (layar), widgets (komponen UI), services (untuk logika API), models (untuk representasi data dari API), utils (fungsi bantuan), dll.

Identifikasi Packages/Plugins yang Dibutuhkan:

HTTP client: http atau dio (dio lebih powerful).

Penyimpanan lokal aman untuk token: flutter_secure_storage.

State management (sesuai pilihan Anda).

Navigasi (jika menggunakan GetX, sudah termasuk. Jika tidak, Navigator bawaan atau go_router).

GPS/Lokasi: geolocator.

Peta: google_maps_flutter (membutuhkan setup API Key Google Maps).

Format Tanggal/Waktu: intl.

Output:

Diagram alur navigasi.

Pilihan state management.

Rencana struktur folder proyek Flutter.

Daftar package/plugin yang akan digunakan.

Langkah 3.4: Menyiapkan Lingkungan Pengembangan

Tujuan: Memastikan semua alat yang dibutuhkan sudah terinstal dan berfungsi.

Tindakan:

Install Flutter SDK: Ikuti panduan resmi di flutter.dev.

Install IDE: Visual Studio Code (VS Code) dengan ekstensi Flutter dan Dart, atau Android Studio.

Setup Emulator/Device Fisik: Untuk menjalankan dan menguji aplikasi Flutter.

Install PHP, Composer, dan Laravel Installer: Ikuti panduan resmi di laravel.com dan getcomposer.org.

Install Database Server Lokal: XAMPP/MAMP (sudah termasuk Apache, MySQL, PHP) atau install MySQL/PostgreSQL secara terpisah.

Install Git: Untuk version control.

Install Postman (atau Insomnia): Untuk menguji API.

Output: Lingkungan pengembangan yang siap digunakan. Anda bisa membuat proyek "Hello World" sederhana di Flutter dan Laravel untuk memastikan semuanya berjalan.

Setelah menyelesaikan semua langkah persiapan awal ini, Anda akan memiliki pemahaman yang jauh lebih baik tentang apa yang akan dibangun, bagaimana cara membangunnya, dan alat apa yang akan digunakan. Ini akan sangat mengurangi risiko kebingungan dan kesalahan saat Anda mulai masuk ke fase implementasi (iterasi-iterasi berikutnya).

Jangan ragu untuk kembali ke fase ini jika ada ketidakjelasan atau jika kebutuhan berubah selama proses pengembangan (meskipun untuk MVP, usahakan untuk tetap pada lingkup awal).