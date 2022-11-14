import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../common/theme_helper.dart';

class HomeBottomSheet extends StatelessWidget {
  HomeBottomSheet({Key? key}) : super(key: key);
  // get storage initializer
  var userStorage = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'User Logged In',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 24,
                  child: Text(
                    '${userStorage.read('username')[0]}'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  '${userStorage.read('username')}'.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  'Franko Trading Enterprise',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: ThemeHelper().boxDecoration(),
                child: ListTile(
                  onTap: () async {
                    await userStorage.erase();
                    Get.offAllNamed('/signInPage');
                  },
                  leading: const Icon(
                    FontAwesomeIcons.arrowRightFromBracket,
                  ),
                  title: const Text(
                    'Logout',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
