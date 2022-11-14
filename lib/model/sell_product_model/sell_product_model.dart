// To parse this JSON data, do
//
//     final sellProduct = sellProductFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SellProduct sellProductFromJson(String str) =>
    SellProduct.fromJson(json.decode(str));

String sellProductToJson(SellProduct data) => json.encode(data.toJson());

class SellProduct {
  SellProduct({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory SellProduct.fromJson(Map<String, dynamic> json) => SellProduct(
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
    required this.productName,
    required this.productPrice,
    required this.collectionName,
    required this.collectionId,
    required this.stockTotal,
    required this.batchUuid,
    required this.batchStock,
    required this.batchExpiry,
  });

  String productName;
  int productPrice;
  String collectionName;
  int collectionId;
  String stockTotal;
  String batchUuid;
  int batchStock;
  DateTime batchExpiry;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        productName: json["productName"],
        productPrice: json["productPrice"],
        collectionName: json["collectionName"],
        collectionId: json["collectionID"],
        stockTotal: json["stockTotal"],
        batchUuid: json["batchUUID"],
        batchStock: json["batchStock"],
        batchExpiry: DateTime.parse(json["batchExpiry"]),
      );

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "productPrice": productPrice,
        "collectionName": collectionName,
        "collectionID": collectionId,
        "stockTotal": stockTotal,
        "batchUUID": batchUuid,
        "batchStock": batchStock,
        "batchExpiry": batchExpiry.toIso8601String(),
      };
}
