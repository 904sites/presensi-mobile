import 'package:flutter/material.dart';
import 'package:presensi/simpan-page.dart';

class RiwayatPresensi {
  final String tanggal;
  final String waktuMasuk;
  final String waktuPulang;

  RiwayatPresensi({
    required this.tanggal,
    required this.waktuMasuk,
    required this.waktuPulang,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Data dummy, sudah bagus
  final List<RiwayatPresensi> daftarRiwayat = [
    RiwayatPresensi(
        tanggal: "1 Juni 2025", waktuMasuk: "07:01", waktuPulang: "17:03"),
    RiwayatPresensi(
        tanggal: "31 Mei 2025", waktuMasuk: "06:58", waktuPulang: "17:00"),
    RiwayatPresensi(
        tanggal: "30 Mei 2025", waktuMasuk: "07:05", waktuPulang: "17:10"),
  ];

  @override
  Widget build(BuildContext context) {
    // === PERUBAHAN DI SINI ===
    // Mengambil tanggal hari ini tanpa menggunakan `intl`
    final now = DateTime.now();
    // Membuat format tanggal manual, contoh: "3/6/2025"
    final String tanggalHariIni = "${now.day}/${now.month}/${now.year}";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Presensi"),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Halo, Pegawai Rajin!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Berikut adalah ringkasan presensi Anda.",
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // Kartu informasi akan menampilkan tanggal format baru
              _buildInfoCard(tanggalHariIni),

              const SizedBox(height: 30),
              const Text(
                "Riwayat Presensi",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: daftarRiwayat.length,
                  itemBuilder: (context, index) {
                    final riwayat = daftarRiwayat[index];
                    return _buildHistoryCard(riwayat);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SimpanPage()),
          );
        },
        child: const Icon(Icons.add_location_alt_outlined),
        tooltip: "Lakukan Presensi",
      ),
    );
  }

  // Widget-widget helper tidak perlu diubah, karena mereka hanya menerima String
  Widget _buildInfoCard(String tanggal) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              tanggal,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text("07.00",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text("Jam Masuk",
                        style: TextStyle(color: Colors.white70, fontSize: 14)),
                  ],
                ),
                Column(
                  children: [
                    Text("17.00",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text("Jam Pulang",
                        style: TextStyle(color: Colors.white70, fontSize: 14)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryCard(RiwayatPresensi riwayat) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(riwayat.tanggal,
                style: const TextStyle(fontWeight: FontWeight.w500)),
            Row(
              children: [
                _buildTimeColumn("Masuk", riwayat.waktuMasuk),
                const SizedBox(width: 25),
                _buildTimeColumn("Pulang", riwayat.waktuPulang),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeColumn(String label, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(time,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
