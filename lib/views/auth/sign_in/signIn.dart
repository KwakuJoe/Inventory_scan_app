import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../common/theme_helper.dart';
import '../../../controllers/internet_controller.dart';
import '../../../controllers/sign_in_controller.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // sign controller
  final SignInController signInController = Get.put(SignInController());
  // internet provider
  final InternetController internetController = Get.put(InternetController());

  // buttons controllers
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();

  // form controllers
  final TextEditingController _username = TextEditingController();
  final TextEditingController _passcode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('1B2430'),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 100, left: 25, right: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/gifs/splash_logo.gif",
                  height: 80,
                  width: 80,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Scanventory Mobile scanner',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Inventory management scanner app',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 20,
                ),
                // forms Start
                Form(
                  child: Column(
                    children: [
                      TextField(
                        controller: _username,
                        decoration: ThemeHelper().textInputDecoration(
                          'Enter your username',
                          Icons.email_outlined,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: _passcode,
                        obscureText: true,
                        decoration: ThemeHelper().textInputDecoration(
                          'Enter your passcode',
                          Icons.lock,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // Rounded buttons
                      RoundedLoadingButton(
                        controller: _buttonController,
                        width: MediaQuery.of(context).size.width * 0.9,
                        elevation: 0,
                        borderRadius: 10,
                        color: Colors.purple,
                        onPressed: _handleGoogleSignIn,
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // functon to handle sign it google
  Future _handleGoogleSignIn() async {
    await internetController.initConnectivity();

    if (internetController.hasInternet().isFalse) {
      Get.snackbar(
        'Connection error!',
        'Please connect to your local network wifi',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 10),
        isDismissible: true,
        icon: const Icon(
          FontAwesomeIcons.wifi,
          color: Colors.white,
        ),
        snackStyle: SnackStyle.FLOATING,
      );
      _buttonController.reset();
    } else {
      if (_username.text.isEmpty || _passcode.text.isEmpty) {
        Get.snackbar(
          'Empty field',
          'Kindly fill both username and passcode fill',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 10),
          isDismissible: true,
          icon: const Icon(
            FontAwesomeIcons.shield,
            color: Colors.white,
          ),
          snackStyle: SnackStyle.FLOATING,
        );
        _buttonController.reset();
      } else {
        await signInController.login(_username.text, _passcode.text);
        _buttonController.reset();
      }
      // signInController.signInWithGoogle();
    }
  }

  handleAfterSignIn() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      Get.offAllNamed('/');
    });
  }
}
