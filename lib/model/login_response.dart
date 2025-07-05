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
