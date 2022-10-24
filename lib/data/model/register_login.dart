// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'dart:convert';

RegisterLogin registerFromJson(String str) =>
    RegisterLogin.fromJson(json.decode(str));

String registerToJson(RegisterLogin data) => json.encode(data.toJson());

class RegisterLogin {
  RegisterLogin({
    required this.id,
    required this.code,
    required this.message,
    this.data,
  });

  final String id;
  final int code;
  final String message;
  final Data? data;

  factory RegisterLogin.fromJson(Map<String, dynamic> json) => RegisterLogin(
        id: json["\u0024id"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "\u0024id": id,
        "code": code,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.dataId,
    required this.name,
    required this.email,
    required this.token,
  });

  final String id;
  final int dataId;
  final String name;
  final String email;
  final String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["\u0024id"],
        dataId: json["Id"],
        name: json["Name"],
        email: json["Email"],
        token: json["Token"],
      );

  Map<String, dynamic> toJson() => {
        "\u0024id": id,
        "Id": dataId,
        "Name": name,
        "Email": email,
        "Token": token,
      };
}
