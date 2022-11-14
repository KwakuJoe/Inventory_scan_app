// To parse this JSON data, do
//
//     final scanProduct = scanProductFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ScanProduct scanProductFromJson(String str) =>
    ScanProduct.fromJson(json.decode(str));

String scanProductToJson(ScanProduct data) => json.encode(data.toJson());

class ScanProduct {
  ScanProduct({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory ScanProduct.fromJson(Map<String, dynamic> json) => ScanProduct(
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
    required this.batch,
    required this.stockTotal,
    required this.collectionName,
  });

  Batch batch;
  String stockTotal;
  String collectionName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        batch: Batch.fromJson(json["batch"]),
        stockTotal: json["stockTotal"],
        collectionName: json["collectionName"],
      );

  Map<String, dynamic> toJson() => {
        "batch": batch.toJson(),
        "stockTotal": stockTotal,
        "collectionName": collectionName,
      };
}

class Batch {
  Batch({
    required this.id,
    required this.uuid,
    required this.batchStock,
    required this.expiryDate,
    required this.createdAt,
    required this.updatedAt,
    required this.productId,
    required this.product,
  });

  int id;
  String uuid;
  int batchStock;
  DateTime expiryDate;
  DateTime createdAt;
  DateTime updatedAt;
  int productId;
  Product product;

  factory Batch.fromJson(Map<String, dynamic> json) => Batch(
        id: json["id"],
        uuid: json["uuid"],
        batchStock: json["batch_stock"],
        expiryDate: DateTime.parse(json["expiry_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        productId: json["product_id"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "batch_stock": batchStock,
        "expiry_date": expiryDate.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product_id": productId,
        "product": product.toJson(),
      };
}

class Product {
  Product({
    required this.id,
    required this.uuid,
    required this.name,
    required this.price,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.collectionId,
  });

  int id;
  String uuid;
  String name;
  int price;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  int collectionId;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        uuid: json["uuid"],
        name: json["name"],
        price: json["price"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        collectionId: json["collection_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "name": name,
        "price": price,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "collection_id": collectionId,
      };
}
