// To parse this JSON data, do
//
//     final collection = collectionFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Collection collectionFromJson(String str) =>
    Collection.fromJson(json.decode(str));

String collectionToJson(Collection data) => json.encode(data.toJson());

class Collection {
  Collection({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
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
    required this.collections,
  });

  List<CollectionElement> collections;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        collections: List<CollectionElement>.from(
            json["collections"].map((x) => CollectionElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "collections": List<dynamic>.from(collections.map((x) => x.toJson())),
      };
}

class CollectionElement {
  CollectionElement({
    required this.id,
    required this.uuid,
    required this.name,
    required this.summary,
    required this.expiryCategoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.expiryCategory,
  });

  int id;
  String uuid;
  String name;
  String summary;
  int expiryCategoryId;
  DateTime createdAt;
  DateTime updatedAt;
  ExpiryCategory expiryCategory;

  factory CollectionElement.fromJson(Map<String, dynamic> json) =>
      CollectionElement(
        id: json["id"],
        uuid: json["uuid"],
        name: json["name"],
        summary: json["summary"],
        expiryCategoryId: json["expiry_category_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        expiryCategory: ExpiryCategory.fromJson(json["expiryCategory"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "name": name,
        "summary": summary,
        "expiry_category_id": expiryCategoryId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "expiryCategory": expiryCategory.toJson(),
      };
}

class ExpiryCategory {
  ExpiryCategory({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory ExpiryCategory.fromJson(Map<String, dynamic> json) => ExpiryCategory(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
