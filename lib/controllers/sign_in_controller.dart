// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../common/constant.dart';
import '../model/user_model/user_model.dart';

class SignInController extends GetxController {
  User? user;

  var isLoading = false.obs;

  String baseUrl = Constant().baseUrl.toString();
  Map<String, String> requestHeaders = Constant().requestHeaders;

  // initialize get storage
  var userStorage = GetStorage();

  // products under each collection
  Future login(String username, String passcode) async {
    try {
      isLoading(true);
      var client = http.Client();
      var response = await client.post(
        Uri.parse('http://192.168.43.152:3333/api/auth/login'),
        headers: requestHeaders,
        body: jsonEncode(
          <String, String>{
            'username': username,
            'passcode': passcode,
          },
        ),
      );

      print(response);
      if (response.statusCode == 200) {
        print('user response is 200');
        var result = jsonDecode(response.body);
        print(result);

        user = User.fromJson(result);

        if (user!.success == true) {
          user = user;
          userStorage.write('username', user!.data.username.toString());
          userStorage.write('uuid', user!.data.uuid.toString());
          Get.offAllNamed('/home');

          // store name and uuid with get storage
        } else {
          user = null;
        }

        return user;
      } else {
        // error
        print('status response not 200 for products');
        Get.snackbar(
          ' Authentication Failed',
          'Kindly check your credentials and try again or contact your admin',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 10),
          icon: const Icon(
            FontAwesomeIcons.arrowRightToBracket,
            color: Colors.white,
          ),
        );
        user = null;
      }
    } catch (e) {
      print('Error while getting data is $e');
      Get.snackbar(
        'Connection error!',
        '$e, Kindly check your wifi connectivity and server ',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 10),
        icon: const Icon(
          FontAwesomeIcons.wifi,
          color: Colors.white,
        ),
      );
    } finally {
      isLoading(false);
    }
  }
}
