import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:scaanthetic/common/theme_helper.dart';

import '../../common/constant.dart';
import '../../controllers/overview_controller.dart';
import '../../controllers/product_controller.dart';

class ProductDetailPage extends StatefulWidget {
  ProductDetailPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  ProductController productController = Get.put(ProductController());
  String collectionName = '';
  String baseUrl = Constant().baseUrl;

  String id = '';
  @override
  void initState() {
    setState(() {
      collectionName = Get.arguments[0].toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('1B2430'),
        appBar: AppBar(
          title: const Text('Iphone 7plus'),
          elevation: 0,
          backgroundColor: HexColor('1B2430'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                productController.getProduct(id);
              },
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
        body: Obx(() => productController.checkLoading().isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : productController.product?.success == true
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            '${baseUrl}${productController.product?.data.product.image}',
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // name an price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                      '${productController.product?.data.product.name}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 28,
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
                              ),
                              // price
                              Text(
                                '\$${productController.product?.data.product.price}.00',
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                            child: Divider(),
                          ),
                          // batch stock and total stock
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Batch Stock',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${productController.product?.data.stockTotal}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          // Complete Button
                          Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.purple),
                            child: TextButton.icon(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Go back',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: Text('Could nto get product, try again'),
                  )));
  }
}
