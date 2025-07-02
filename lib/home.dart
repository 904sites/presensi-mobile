// lib/home.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// --- Import file-file dari project Anda ---
import 'package:presensi/login.dart';
import 'package:presensi/simpan-page.dart';
import 'package:presensi/model/presensi.dart';

class HomePage extends StatefulWidget {
  // Menerima nama dan token dari halaman login
  final String name;
  final String token;

  const HomePage({
    Key? key,
    required this.name,
    required this.token,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? jamMasuk;
  String? jamPulang;
  List<Presensi> riwayat = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getPresensi();
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Hapus semua data (token & nama)

    if (!mounted) return;
    // Kembali ke halaman login, hapus semua halaman sebelumnya dari stack
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  Future<void> _getPresensi() async {
    setState(() => isLoading = true);

    try {
      // Sesuaikan alamat IP ini jika perlu
      final url = Uri.parse('http://10.0.2.2:8000/api/get-presensi');

      final response = await http.get(
        url,
        headers: {
          'Authorization':
              'Bearer ${widget.token}', // Gunakan token dari widget
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> listData = responseData['data'];

        final String tanggalHariIni =
            DateFormat('yyyy-MM-dd').format(DateTime.now());
        final dataHariIni = listData.firstWhere(
          (item) => item['tanggal'] == tanggalHariIni,
          orElse: () => null,
        );

        setState(() {
          riwayat = listData.map((e) => Presensi.fromJson(e)).toList();
          jamMasuk = dataHariIni != null ? dataHariIni['masuk'] : null;
          jamPulang = dataHariIni != null ? dataHariIni['pulang'] : null;
        });
      } else {
        print('Gagal ambil data. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Terjadi error: $e');
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Variabel ini sekarang digunakan di dalam UI
    final formatter = DateFormat('EEEE, d MMMM yyyy', 'id_ID');
    final today = formatter.format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Presensi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _logout,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SimpanPage()),
          );
          if (result == true) {
            _getPresensi(); // Refresh data jika presensi berhasil
          }
        },
        child: const Icon(Icons.location_on),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _getPresensi,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Halo, ${widget.name}!',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Berikut adalah ringkasan presensi Anda.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            today, // <-- VARIABEL DIGUNAKAN DI SINI
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildPresensiInfo('Masuk', jamMasuk),
                              _buildPresensiInfo('Pulang', jamPulang),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Riwayat Presensi',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    riwayat.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text('Belum ada riwayat presensi.'),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: riwayat.length,
                            itemBuilder: (context, index) {
                              final presensi = riwayat[index];
                              final tanggalFormatted =
                                  DateFormat('EEEE, d MMM yyyy', 'id_ID')
                                      .format(DateTime.parse(presensi.tanggal));
                              return Card(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: ListTile(
                                  title: Text(tanggalFormatted),
                                  subtitle: Row(
                                    children: [
                                      Text(
                                          'Masuk: ${presensi.jamMasuk ?? '-'}'),
                                      const SizedBox(width: 12),
                                      Text(
                                          'Pulang: ${presensi.jamPulang ?? '-'}'),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
    );
  }

  // Widget helper untuk membuat UI info jam lebih rapi
  Widget _buildPresensiInfo(String label, String? time) {
    return Column(
      children: [
        Text(
          time ?? '-',
          style: const TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        )
      ],
    );
  }
}
