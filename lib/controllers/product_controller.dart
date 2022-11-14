import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

import '../common/constant.dart';
import '../model/product_detail/product_detail.dart';

class ProductController extends GetxController {
  ProductDetail? product;
  final String baseUrl = Constant().baseUrl.toString();
  var isLoading = false.obs;

  RxBool checkLoading() => isLoading;
  // get one product
  Future getProduct(String id) async {
    try {
      isLoading(true);
      var client = http.Client();
      var response = await client.get(
        Uri.parse('http://192.168.43.152:3333/api/get-product/$id'),
      );

      // print(response);
      if (response.statusCode == 200) {
        print('response is 200 for products');
        var result = jsonDecode(response.body);
        // print(result);
        product = ProductDetail.fromJson(result);

        if (product!.success == true) {
          product = product;
        } else {
          product = null;
        }

        return product;
      } else {
        // error
        debugPrint('status response not 200 product');
        product = null;
      }
    } catch (e) {
      debugPrint('Error while getting data is $e');
      Get.toNamed('/errorConnectPage');
    } finally {
      isLoading(false);
    }
  }
}
