import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:scaanthetic/model/collection_model/collection.dart';
import '../common/constant.dart';
import '../model/product_detail/product_detail.dart';
import '../model/products_model/products.dart';

class OverviewController extends GetxController {
  Collection? collections;
  Products? products;
  ProductDetail? product;
  var isLoading = false.obs;

  final String baseUrl = Constant().baseUrl.toString();

  RxBool checkLoading() => isLoading;

  @override
  void onInit() {
    getCollection();
    super.onInit();
  }

  //  collection
  Future getCollection() async {
    try {
      var client = http.Client();

      isLoading(true);
      // url assigned to response
      var response = await client.get(
        Uri.parse('http://192.168.43.152:3333/api/get-collections'),
        // headers: {
        //   'Content-type': 'application/json',
        //   'Accept': 'application/json',
        // },
      );

      // print(response.body);

      if (response.statusCode == 200) {
        print('response is 200 for collection');
        var result = jsonDecode(response.body);
        // print(result);
        collections = Collection.fromJson(result);

        if (collections!.success == true) {
          collections = collections;
        } else {
          collections = null;
        }

        return collections;
      } else {
        // error
        debugPrint('status response not 200 collection');
        collections = null;
      }
    } catch (e) {
      debugPrint('Error while getting data is $e');
      Get.snackbar('Error:',
          '$e, check your wifi connection and server status, try again',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: const Icon(
            FontAwesomeIcons.wifi,
            color: Colors.white,
          ));
      Get.toNamed('/errorConnectPage');
    } finally {
      isLoading(false);
    }
  }

  // products under each collection
  Future getProducts(String id) async {
    try {
      isLoading(true);
      var client = http.Client();
      var response = await client.get(
        Uri.parse('http://192.168.43.152:3333/api/get-products/$id'),
      );

      // print(response);
      if (response.statusCode == 200) {
        print('product is 200 for products');
        var result = jsonDecode(response.body);
        // print(result);

        products = Products.fromJson(result);

        if (products!.success == true) {
          products = products;
        } else {
          products = null;
        }

        return products;
      } else {
        // error
        debugPrint('status response not 200 for products');
        products = null;
      }
    } catch (e) {
      debugPrint('Error while getting data is $e');
      Get.snackbar('Error:',
          '$e, check your wifi connection and server status, try again',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: const Icon(
            FontAwesomeIcons.wifi,
            color: Colors.white,
          ));
      Get.toNamed('/errorConnectPage');
    } finally {
      isLoading(false);
    }
  }
}
