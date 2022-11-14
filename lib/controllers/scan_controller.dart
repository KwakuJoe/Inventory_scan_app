import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../common/constant.dart';
import '../model/scan_product_model/scan_product_model.dart';
import '../model/sell_product_model/sell_product_model.dart';
// import '../views/services/scan_service.dart';

class ScanController extends GetxController {
  ScanProduct? product;
  SellProduct? productSold;
  var isLoading = false.obs;

  final String baseUrl = Constant().baseUrl.toString();

  String code = '';

  RxBool checkLoading() => isLoading;

  @override
  void onInit() {
    getOneProduct(code.toString());
    super.onInit();
  }

  Future getOneProduct(String code) async {
    try {
      isLoading(true);
      // url assigned to response
      var client = http.Client();
      var response = await client.get(
        Uri.parse('$baseUrl/api/scan/$code'),
      );
      // 4f4b7fe9-d9bc-4425-b59d-c437d3fc3f7b
      // print(response);
      if (response.statusCode == 200) {
        print('response is 200 for products');
        var result = jsonDecode(response.body);
        // print(result);
        product = ScanProduct.fromJson(result);

        if (product!.success == true) {
          product = product;
        } else {
          product = null;
        }

        return product;
      } else {
        // error
        debugPrint('status response not 200 product');
        // product = null;
      }
    } catch (e) {
      debugPrint('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }

  Future sellOneProduct(String code) async {
    try {
      isLoading(true);
      // url assigned to response
      var client = http.Client();
      var response = await client.get(
        Uri.parse('$baseUrl/api/scan-to-sell/$code'),
      );

      if (response.statusCode == 200) {
        print('response is 200 for products');
        var result = jsonDecode(response.body);
        // print(result);
        productSold = SellProduct.fromJson(result);

        if (productSold!.success == true) {
          productSold = productSold;
        } else {
          productSold = null;
        }

        return productSold;
      } else {
        // error
        debugPrint('status response not 200 product');
        productSold = null;
      }
    } catch (e) {
      debugPrint('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }
}
