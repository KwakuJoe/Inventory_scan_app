import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scaanthetic/common/theme_helper.dart';

import '../../../controllers/overview_controller.dart';

class Overview extends StatefulWidget {
  Overview({Key? key}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  final OverviewController overviewController = Get.put(OverviewController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Overview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  overviewController.getCollection();
                  // overviewController.get();
                },
                icon: const Icon(Icons.refresh_outlined),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          // overvew boxes
          GestureDetector(
            onTap: () {
              Get.toNamed('/allCollections');
            },
            child: Container(
              width: double.infinity,
              decoration: ThemeHelper().boxDecoration(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Column(
                  children: [
                    // icon a
                    Row(
                      children: const [
                        CircleAvatar(
                          backgroundColor: Colors.purple,
                          radius: 16,
                          child: Icon(
                            FontAwesomeIcons.cube,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ],
                    ),
                    // number
                    overviewController.isLoading.isTrue
                        ? Center(
                            child: LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.white,
                              size: 20,
                            ),
                          )
                        : Text(
                            overviewController
                                    .collections?.data.collections.length
                                    .toString() ??
                                'error',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    // collection text
                    const Text(
                      'Collection',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
