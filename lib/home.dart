import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import package untuk format tanggal
import 'package:presensi/simpan-page.dart'; // Pastikan file ini ada

// Model data untuk riwayat, ini sudah bagus
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
  // Siapkan HomePage untuk menerima data dari login
  final String name;
  final String token;

  const HomePage({
    super.key,
    required this.name,
    required this.token,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Data dummy, kita akan gunakan ini untuk ditampilkan di list
  final List<RiwayatPresensi> daftarRiwayat = [
    RiwayatPresensi(
        tanggal: "27 Juni 2024", waktuMasuk: "07:01", waktuPulang: "17:03"),
    RiwayatPresensi(
        tanggal: "26 Juni 2024", waktuMasuk: "06:58", waktuPulang: "17:00"),
    RiwayatPresensi(
        tanggal: "25 Juni 2024", waktuMasuk: "07:05", waktuPulang: "17:10"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Presensi"),
        backgroundColor: Colors.white,
        elevation: 1,
        // Anda bisa tambahkan tombol logout di sini nanti
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Gunakan `widget.name` untuk menampilkan nama pengguna yang login
              Text(
                "Halo, ${widget.name}!",
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Berikut adalah ringkasan presensi Anda.",
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // Kartu informasi presensi hari ini
              _buildInfoCard(),

              const SizedBox(height: 30),
              const Text(
                "Riwayat Presensi",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Gunakan Expanded + ListView.builder untuk daftar riwayat
              Expanded(
                child: ListView.builder(
                  itemCount: daftarRiwayat.length,
                  itemBuilder: (context, index) {
                    final riwayat = daftarRiwayat[index];
                    // Tampilkan riwayat menggunakan widget terpisah
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
          // Navigasi ke halaman untuk melakukan presensi baru
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SimpanPage()),
          );
        },
        tooltip: "Lakukan Presensi",
        child: const Icon(Icons.add_location_alt_outlined),
      ),
    );
  }

  // Helper widget untuk kartu informasi hari ini
  Widget _buildInfoCard() {
    // Format tanggal menjadi "Jumat, 28 Juni 2024"
    final String tanggalHariIni =
        DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.now());

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue[800],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              tanggalHariIni,
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

  // Helper widget untuk kartu riwayat presensi
  Widget _buildHistoryCard(RiwayatPresensi riwayat) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
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

  // Helper widget untuk menampilkan kolom waktu (masuk/pulang)
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
