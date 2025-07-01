import 'package:flutter/material.dart';
import 'package:presensi/login.dart';
// 1. Import package yang dibutuhkan untuk inisialisasi
import 'package:intl/date_symbol_data_local.dart';

// 2. Ubah 'void main()' menjadi 'Future<void> main() async'
Future<void> main() async {
  // 3. Tambahkan dua baris ini SEBELUM runApp()
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Presensi',
      home: LoginPage(),
    );
  }
}
