class Presensi {
  final String tanggal; // ini tetap format 'YYYY-MM-DD'
  final String? tanggalFormat; // dari Laravel: "Senin, 1 Juli 2024"
  final String? jamMasuk;
  final String? jamPulang;

  Presensi({
    required this.tanggal,
    this.tanggalFormat,
    this.jamMasuk,
    this.jamPulang,
  });

  factory Presensi.fromJson(Map<String, dynamic> json) => Presensi(
        tanggal: json["tanggal"],
        tanggalFormat: json["tanggal_format"],
        jamMasuk: json["masuk"],
        jamPulang: json["pulang"],
      );
}
