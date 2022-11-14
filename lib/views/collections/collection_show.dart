// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:scaanthetic/common/theme_helper.dart';
import 'package:scaanthetic/controllers/overview_controller.dart';

import '../../common/constant.dart';
import '../../controllers/product_controller.dart';

class ShowCollection extends StatefulWidget {
  const ShowCollection({Key? key}) : super(key: key);

  @override
  State<ShowCollection> createState() => _ShowCollectionState();
}

class _ShowCollectionState extends State<ShowCollection> {
  OverviewController overviewController = Get.put(OverviewController());
  ProductController productController = Get.put(ProductController());
  String collectionName = '';

  @override
  void initState() {
    setState(() {
      collectionName = Get.arguments[0].toString();
    });
    super.initState();
  }

  // base url
  String baseUrl = Constant().baseUrl;
  @override
  Widget build(BuildContext context) {
    String productId = '';
    return Scaffold(
      backgroundColor: HexColor('1B2430'),
      appBar: AppBar(
        title: Text(collectionName),
        elevation: 0,
        backgroundColor: HexColor('1B2430'),
      ),
      body: Obx(
        (() => overviewController.checkLoading().isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : overviewController.products!.data.product.isEmpty
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
                          'No product available under this collection.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: overviewController.products?.data.product.length,
                    itemBuilder: (context, index) {
                      String id = 'Unknown';
                      String name = 'Unknown';
                      String price = 'Unknown';
                      String image = 'Unknown';

                      id = overviewController.products!.data.product[index].id
                          .toString();

                      name = overviewController
                          .products!.data.product[index].name
                          .toString();

                      price = overviewController
                          .products!.data.product[index].price
                          .toString();

                      image = overviewController
                          .products!.data.product[index].image
                          .toString();
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed('/productDetail',
                              arguments: [collectionName]);
                          productController.getProduct(
                            overviewController.products!.data.product[index].id
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image:
                                                NetworkImage('$baseUrl$image'),
                                          ),
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
                                                0.3,
                                            child: Text(
                                              name,
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
                                            collectionName,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),

                                  // expiry indicator
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      '\$$price.00',
                                      style: const TextStyle(
                                          fontSize: 30,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600),
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
