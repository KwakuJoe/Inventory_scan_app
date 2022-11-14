// To parse this JSON data, do
//
//     final productDetail = productDetailFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductDetail productDetailFromJson(String str) =>
    ProductDetail.fromJson(json.decode(str));

String productDetailToJson(ProductDetail data) => json.encode(data.toJson());

class ProductDetail {
  ProductDetail({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
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
    required this.product,
    required this.stockTotal,
  });

  Product product;
  String stockTotal;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        product: Product.fromJson(json["product"]),
        stockTotal: json["stockTotal"],
      );

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "stockTotal": stockTotal,
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
