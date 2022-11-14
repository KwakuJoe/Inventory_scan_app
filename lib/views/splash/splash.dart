import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../controllers/sign_in_controller.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var userStorage = GetStorage();

  // init state
  @override
  void initState() {
    final SignInController signInController = Get.put(SignInController());
    super.initState();
    if (userStorage.read('uuid') == null) {
      // timer to navigate
      Timer(const Duration(seconds: 4), () {
        Get.toNamed('/signInPage');
      });
    } else {
      Timer(const Duration(seconds: 4), () {
        Get.offAllNamed('/home');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#1B2430'),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/gifs/splash_logo.gif",
                height: 100,
                width: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'INVENTORY2 MOBILE SCANNER',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.purple,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
