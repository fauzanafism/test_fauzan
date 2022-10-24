// To parse this JSON data, do
//
//     final userResult = userResultFromJson(jsonString);

import 'dart:convert';

ListUser userResultFromJson(String str) => ListUser.fromJson(json.decode(str));

String userResultToJson(ListUser data) => json.encode(data.toJson());

class ListUser {
  ListUser({
    required this.id,
    required this.page,
    required this.perPage,
    required this.totalrecord,
    required this.totalPages,
    required this.data,
  });

  final String id;
  final int page;
  final int perPage;
  final int totalrecord;
  final int totalPages;
  final List<Datum> data;

  factory ListUser.fromJson(Map<String, dynamic> json) => ListUser(
        id: json["\u0024id"],
        page: json["page"],
        perPage: json["per_page"],
        totalrecord: json["totalrecord"],
        totalPages: json["total_pages"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\u0024id": id,
        "page": page,
        "per_page": perPage,
        "totalrecord": totalrecord,
        "total_pages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.datumId,
    required this.name,
    required this.email,
    required this.profilepicture,
    required this.location,
    required this.createdat,
  });

  final String id;
  final int datumId;
  final String name;
  final String email;
  final String profilepicture;
  final String location;
  final DateTime createdat;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["\u0024id"],
        datumId: json["id"],
        name: json["name"],
        email: json["email"],
        profilepicture: json["profilepicture"],
        location: json["location"],
        createdat: DateTime.parse(json["createdat"]),
      );

  Map<String, dynamic> toJson() => {
        "\u0024id": id,
        "id": datumId,
        "name": name,
        "email": email,
        "profilepicture": profilepicture,
        "location": location,
        "createdat": createdat.toIso8601String(),
      };
}
