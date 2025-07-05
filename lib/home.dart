import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async'; // ⏰ Penting untuk Timer

import 'package:presensi/login.dart';
import 'package:presensi/simpan-page.dart';
import 'package:presensi/model/presensi.dart';

class HomePage extends StatefulWidget {
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

  DateTime now = DateTime.now(); // ⏰ variabel jam
  late Timer timer;

  String get baseUrl =>
      kIsWeb ? "http://localhost:8000" : "http://10.0.2.2:8000";

  @override
  void initState() {
    super.initState();
    _getPresensi();
    _startTimer(); // ⏰ nyalakan timer real-time
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          now = DateTime.now(); // ⏰ update jam setiap detik
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel(); // ⛔ hentikan timer saat keluar halaman
    super.dispose();
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  Future<void> _getPresensi() async {
    if (mounted) setState(() => isLoading = true);

    try {
      final url = Uri.parse('$baseUrl/api/get-presensi');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${widget.token}',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> listData = responseData['data'];

        final List<dynamic> dataHariIniList = listData.where((item) {
          try {
            final itemTanggal = DateTime.parse(item['tanggal']);
            final now = DateTime.now();
            return itemTanggal.year == now.year &&
                itemTanggal.month == now.month &&
                itemTanggal.day == now.day;
          } catch (e) {
            return false;
          }
        }).toList();

        dynamic dataHariIni =
            dataHariIniList.isNotEmpty ? dataHariIniList.last : null;

        if (mounted) {
          setState(() {
            riwayat = listData.map((e) => Presensi.fromJson(e)).toList();
            jamMasuk = dataHariIni != null ? dataHariIni['masuk'] : null;
            jamPulang = dataHariIni != null ? dataHariIni['pulang'] : null;
          });
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Gagal ambil data. Status: ${response.statusCode}')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SimpanPage()),
          ).then((_) => _getPresensi());
        },
        child: const Icon(Icons.add),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _getPresensi,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  Text(
                    'Halo, ${widget.name}!',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
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
                          DateFormat('HH:mm:ss').format(now), // ⏰ Jam aktif
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(now),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (riwayat.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Belum ada riwayat presensi.'),
                      ),
                    ),
                  ...riwayat.map((presensi) {
                    DateTime tanggal =
                        DateTime.tryParse(presensi.tanggal) ?? DateTime.now();
                    String tanggalFormatted =
                        DateFormat('EEEE, d MMMM yyyy', 'id_ID')
                            .format(tanggal);

                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text(tanggalFormatted),
                        subtitle: Text(
                          'Masuk: ${presensi.jamMasuk ?? '--:--'} • Pulang: ${presensi.jamPulang ?? '--:--'}',
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
    );
  }

  Widget _buildPresensiInfo(String label, String? time) {
    return Column(
      children: [
        Text(
          time ?? '--:--',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
