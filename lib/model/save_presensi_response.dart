import 'dart:convert';

SavePresensiResponseModel savePresensiResponseModelFromJson(String str) =>
    SavePresensiResponseModel.fromJson(json.decode(str));

String savePresensiResponseModelToJson(SavePresensiResponseModel data) =>
    json.encode(data.toJson());

class SavePresensiResponseModel {
  bool success;
  String message;
  Data? data;

  SavePresensiResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory SavePresensiResponseModel.fromJson(Map<String, dynamic> json) =>
      SavePresensiResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int id;
  int userId;
  String latitude;
  String longitude;
  String tanggal;
  String? masuk;
  String? pulang;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.tanggal,
    this.masuk,
    this.pulang,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        tanggal: json["tanggal"],
        masuk: json["masuk"],
        pulang: json["pulang"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "latitude": latitude,
        "longitude": longitude,
        "tanggal": tanggal,
        "masuk": masuk,
        "pulang": pulang,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
