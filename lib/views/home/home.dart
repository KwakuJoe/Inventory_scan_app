import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scaanthetic/common/theme_helper.dart';
import 'package:scaanthetic/views/home/widgets/overview.dart';
import 'package:scaanthetic/views/home/widgets/scan_options.dart';

import 'widgets/bottom_sheet.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // get storage initializer
  var userStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('1B2430'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Compnay name and user logged in
              Row(
                children: [
                  // logout bottom sheet
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        HomeBottomSheet(),
                        backgroundColor: HexColor('1B2430'),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.purple,
                      ),
                      child: Center(
                        child: Text(
                          '${userStorage.read('username')[0]}'.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // name and user
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: const Text(
                          'Franko Trading Enterprise ',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '${userStorage.read('username')}'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              // welcome
              Overview(),
              const SizedBox(
                height: 20,
              ),
              const ScanOptions(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
