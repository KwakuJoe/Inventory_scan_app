import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:scaanthetic/common/theme_helper.dart';

class ScanOptions extends StatelessWidget {
  const ScanOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Scan options',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        // scan options boxes
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed('/sellPage');
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.43,
                decoration: ThemeHelper().boxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Column(
                    children: const [
                      // icon
                      Icon(
                        FontAwesomeIcons.qrcode,
                        color: Colors.white,
                        size: 70,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // scan text
                      Text(
                        'Sell Product',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed('/scanPage');
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.43,
                decoration: ThemeHelper().boxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Column(
                    children: const [
                      // icon
                      Icon(
                        FontAwesomeIcons.qrcode,
                        color: Colors.white,
                        size: 70,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // scan text
                      Text(
                        'Scan Product Info',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
