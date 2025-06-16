import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

// Untuk menjalankan aplikasi secara langsung
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SimpanPage(), // Halaman utama adalah SimpanPage
    );
  }
}

// KELAS UTAMA ANDA
class SimpanPage extends StatefulWidget {
  const SimpanPage({super.key});

  @override
  State<SimpanPage> createState() => _SimpanPageState();
}

class _SimpanPageState extends State<SimpanPage> {
  // Controller untuk mengontrol zoom dan posisi peta secara dinamis
  late MapZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller peta dengan posisi awal default
    _zoomPanBehavior = MapZoomPanBehavior(
      focalLatLng: const MapLatLng(0, 0), // Default, akan di-update nanti
      zoomLevel: 5,
    );
  }

  /// Fungsi untuk mendapatkan lokasi saat ini dari perangkat.
  /// Mengembalikan `LocationData` jika berhasil, atau `null` jika gagal.
  Future<LocationData?> _getCurrentLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // 1. Cek apakah layanan lokasi di perangkat aktif.
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      // Jika tidak aktif, minta pengguna untuk mengaktifkannya.
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // Jika pengguna menolak, kembalikan null.
        return null;
      }
    }

    // 2. Cek apakah aplikasi memiliki izin akses lokasi.
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      // Jika belum ada izin, minta izin kepada pengguna.
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        // Jika pengguna menolak izin, kembalikan null.
        return null;
      }
    }

    // 3. Jika layanan dan izin sudah oke, dapatkan lokasi dan kembalikan datanya.
    return await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peta Lokasi Saat Ini'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      // Gunakan FutureBuilder untuk menangani proses asynchronous (menunggu data lokasi)
      body: FutureBuilder<LocationData?>(
        future:
            _getCurrentLocation(), // Hubungkan ke fungsi yang mengambil data
        builder: (BuildContext context, AsyncSnapshot<LocationData?> snapshot) {
          // KASUS 1: Sedang menunggu data lokasi
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Mencari lokasi...'),
                ],
              ),
            );
          }
          // KASUS 2: Terjadi error saat mengambil lokasi
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // KASUS 3: Tidak ada data atau izin ditolak
          else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Tidak bisa mendapatkan lokasi. Pastikan layanan lokasi dan izin untuk aplikasi ini telah diaktifkan.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          // KASUS 4: Data lokasi berhasil didapatkan
          else {
            final locationData = snapshot.data!;
            final currentLocation = MapLatLng(
              locationData.latitude!,
              locationData.longitude!,
            );

            // Update posisi tengah peta dan zoom level ke lokasi pengguna
            _zoomPanBehavior.focalLatLng = currentLocation;
            _zoomPanBehavior.zoomLevel = 15;

            return SfMaps(
              layers: [
                MapTileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  zoomPanBehavior: _zoomPanBehavior, // Gunakan controller
                  // Siapkan 1 penanda (marker) untuk ditampilkan
                  initialMarkersCount: 1,
                  // Bangun widget untuk penanda
                  markerBuilder: (BuildContext context, int index) {
                    return MapMarker(
                      latitude: currentLocation.latitude,
                      longitude: currentLocation.longitude,
                      // Atur tampilan penanda
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 35,
                      ),
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
