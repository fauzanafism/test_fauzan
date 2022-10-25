// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'dart:convert';

UserAccount registerFromJson(String str) =>
    UserAccount.fromJson(json.decode(str));

String registerToJson(UserAccount data) => json.encode(data.toJson());

class UserAccount {
  UserAccount({
    required this.code,
    required this.message,
    required this.data,
  });

  final int code;
  final String message;
  final Data? data;

  factory UserAccount.fromJson(Map<String, dynamic> json) => UserAccount(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    required this.dataId,
    required this.name,
    required this.email,
    required this.token,
  });

  final int dataId;
  final String name;
  final String email;
  final String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        dataId: json["Id"],
        name: json["Name"],
        email: json["Email"],
        token: json["Token"],
      );

  Map<String, dynamic> toJson() => {
        "Id": dataId,
        "Name": name,
        "Email": email,
        "Token": token,
      };
}
