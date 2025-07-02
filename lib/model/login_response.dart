// lib/model/login_response.dart

// Model ini dibuat berdasarkan struktur respons JSON dari API login Anda.
// Contoh JSON: { "success": true, "data": { "name": "...", "token": "..." } }

class LoginResponseModel {
  final bool success;
  final Data data;

  LoginResponseModel({
    required this.success,
    required this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json["success"],
      // Mengambil objek 'data' dan mem-parsingnya menggunakan Data.fromJson
      data: Data.fromJson(json["data"]),
    );
  }
}

class Data {
  final String name;
  final String token;

  Data({
    required this.name,
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json["name"],
      token: json["token"],
    );
  }
}
