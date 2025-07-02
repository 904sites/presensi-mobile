class RiwayatPresensi {
  final String tanggal;
  final String masuk;
  final String pulang;

  RiwayatPresensi({
    required this.tanggal,
    required this.masuk,
    required this.pulang,
  });

  bool isHariIni() {
    final today = DateTime.now();
    return tanggal
        .contains("${today.day} ${_namaBulan(today.month)} ${today.year}");
  }

  String _namaBulan(int bulan) {
    const bulanIndo = [
      "",
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember"
    ];
    return bulanIndo[bulan];
  }
}
