import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../common/theme_helper.dart';
import '../../../controllers/internet_controller.dart';
import '../../../controllers/sign_in_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // sign controller
  final SignInController signInController = Get.put(SignInController());
  // internet provider
  final InternetController internetController = Get.put(InternetController());

  // buttons controllers
  final RoundedLoadingButtonController _googleController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController _facebookController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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

                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Create an account today?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'ed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                // forms Start
                Form(
                  child: Column(
                    children: [
                      TextField(
                        decoration: ThemeHelper().textInputDecoration(
                            'Full name', FontAwesomeIcons.user),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        decoration: ThemeHelper()
                            .textInputDecoration('Email', Icons.email_outlined),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        decoration: ThemeHelper()
                            .textInputDecoration('Password', Icons.lock),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        decoration: ThemeHelper().textInputDecoration(
                            'Confirm Password', Icons.lock),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // Rounded buttons
                      RoundedLoadingButton(
                        controller: _googleController,
                        width: MediaQuery.of(context).size.width * 0.9,
                        elevation: 0,
                        borderRadius: 10,
                        color: Colors.purple,
                        onPressed: _handleGoogleSignIn,
                        child: const Text(
                          'Create account',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      //forgot password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              'Already have an account?, Log in here.',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
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
        'Check your internet connection',
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
      _googleController.reset();
    } else {
      // signInController.signInWithGoogle();
    }
  }

  handleAfterSignIn() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      Get.offAllNamed('/');
    });
  }
}
