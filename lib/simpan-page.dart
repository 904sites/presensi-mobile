import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:presensi/model/save_presensi_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:http/http.dart' as myHttp;

class SimpanPage extends StatefulWidget {
  const SimpanPage({super.key});

  @override
  State<SimpanPage> createState() => _SimpanPageState();
}

class _SimpanPageState extends State<SimpanPage> {
  late Future<LocationData?> _locationFuture;

  @override
  void initState() {
    super.initState();
    _locationFuture = _getCurrentLocation();
  }

  Future<LocationData?> _getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    Location location = Location();

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }

  Future<void> savePresensi(double? latitude, double? longitude) async {
    String baseUrl = "http://10.0.2.2:8000"; // untuk Android emulator
    if (kIsWeb) {
      baseUrl = "http://127.0.0.1:8000"; // untuk Flutter web
    }

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    try {
      Map<String, String> body = {
        "latitude": latitude.toString(),
        "longitude": longitude.toString()
      };

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      final response = await myHttp.post(
        Uri.parse("$baseUrl/api/save-presensi"),
        body: body,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final savePresensiResponseModel =
            SavePresensiResponseModel.fromJson(json.decode(response.body));

        if (savePresensiResponseModel.success) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('✅ Sukses menyimpan presensi')),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(savePresensiResponseModel.message)),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Presensi"),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<LocationData?>(
        future: _locationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Tidak bisa mendapatkan lokasi. Pastikan layanan lokasi aktif dan izin telah diberikan.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final currentLocation = snapshot.data!;

          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SfMaps(
                    layers: [
                      MapTileLayer(
                        urlTemplate:
                            "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        initialFocalLatLng: MapLatLng(
                          currentLocation.latitude!,
                          currentLocation.longitude!,
                        ),
                        initialZoomLevel: 15,
                        initialMarkersCount: 1,
                        markerBuilder: (context, index) {
                          return MapMarker(
                            latitude: currentLocation.latitude!,
                            longitude: currentLocation.longitude!,
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 40,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Lokasi Anda Saat Ini:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Lat: ${currentLocation.latitude}, Long: ${currentLocation.longitude}",
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            savePresensi(
                              currentLocation.latitude,
                              currentLocation.longitude,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Simpan Presensi",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
