import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:scaanthetic/common/theme_helper.dart';
import 'package:scaanthetic/controllers/overview_controller.dart';

class AllCollection extends StatefulWidget {
  AllCollection({Key? key}) : super(key: key);

  @override
  State<AllCollection> createState() => _AllCollectionState();
}

class _AllCollectionState extends State<AllCollection> {
  final OverviewController overviewController = Get.put(OverviewController());

  // @override
  // void initState() {
  //   super.initState();
  //   overviewController.getCollection();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('1B2430'),
      appBar: AppBar(
        title: const Text('Collections'),
        elevation: 0,
        backgroundColor: HexColor('1B2430'),
        centerTitle: true,
      ),
      body: Obx(
        (() => overviewController.checkLoading().isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : overviewController.collections!.data.collections.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/gifs/empty-box.gif",
                        ),
                        const Text(
                          'There is no collection created.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount:
                        overviewController.collections?.data.collections.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          Get.toNamed('/showCollections', arguments: [
                            overviewController
                                .collections!.data.collections[index].name
                          ]);
                          await overviewController.getProducts(
                            overviewController
                                .collections!.data.collections[index].id
                                .toString(),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 2),
                          child: Container(
                            decoration: ThemeHelper().boxDecoration(),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // box
                                  Row(
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.purple,
                                        ),
                                        child: const Icon(
                                          FontAwesomeIcons.cube,
                                          size: 12,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      // name and user
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: Text(
                                              overviewController.collections!
                                                  .data.collections[index].name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            overviewController.collections!.data
                                                .collections[index].summary,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  // expiry indicator
                                  // expiry indicator
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        overviewController
                                            .collections!
                                            .data
                                            .collections[index]
                                            .expiryCategory
                                            .name,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )),
      ),
    );
  }
}
