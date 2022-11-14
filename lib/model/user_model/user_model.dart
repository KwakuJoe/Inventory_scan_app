// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory User.fromJson(Map<String, dynamic> json) => User(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.uuid,
    required this.pincode,
    required this.username,
    required this.isMobileUser,
    required this.brandName,
    required this.rememberMeToken,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String uuid;
  String pincode;
  String username;
  int isMobileUser;
  String brandName;
  dynamic rememberMeToken;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        uuid: json["uuid"],
        pincode: json["pincode"],
        username: json["username"],
        isMobileUser: json["is_mobile_user"],
        brandName: json["brand_name"],
        rememberMeToken: json["remember_me_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "pincode": pincode,
        "username": username,
        "is_mobile_user": isMobileUser,
        "brand_name": brandName,
        "remember_me_token": rememberMeToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
