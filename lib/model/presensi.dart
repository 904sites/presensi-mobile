// lib/model/presensi.dart

// File ini HANYA berisi definisi class (model) untuk data presensi.
// Ini adalah praktik yang baik untuk memisahkan model data dari UI.

class Presensi {
  final String tanggal;
  final String? jamMasuk;
  final String? jamPulang;

  Presensi({
    required this.tanggal,
    this.jamMasuk,
    this.jamPulang,
  });

  // Factory constructor untuk membuat objek Presensi dari JSON.
  // Ini akan dipanggil di home.dart saat mem-parsing data dari API.
  factory Presensi.fromJson(Map<String, dynamic> json) {
    return Presensi(
      tanggal: json['tanggal'],
      jamMasuk: json['masuk'], // Pastikan key 'masuk' cocok dengan API Anda
      jamPulang: json['pulang'], // Pastikan key 'pulang' cocok dengan API Anda
    );
  }
}
