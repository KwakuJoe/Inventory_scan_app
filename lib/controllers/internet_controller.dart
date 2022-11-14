// ignore_for_file: public_member_api_docs, prefer_final_fields

import 'dart:async';
import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';

class InternetController extends GetxController {
  var _hasInternet = false.obs;
  RxBool hasInternet() => _hasInternet;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await Connectivity().checkConnectivity();
      if (result != ConnectivityResult.none) {
        _hasInternet(true);
      } else {
        _hasInternet(false);
      }
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
  }
}
