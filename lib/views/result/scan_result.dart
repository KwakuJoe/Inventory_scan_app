import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:scaanthetic/common/theme_helper.dart';

import '../../common/constant.dart';
import '../../controllers/scan_controller.dart';

class ScanResult extends StatefulWidget {
  ScanResult({Key? key}) : super(key: key);

  @override
  State<ScanResult> createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResult> {
  final ScanController scanController = Get.put(ScanController());
  String baseUrl = Constant().baseUrl;

  @override
  void initState() {
    scanController.getOneProduct(Get.arguments[0].toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: HexColor('51557E'),
            content: const Text(
              "Click the Go back button on this page to exit",
              style: TextStyle(color: Colors.white),
            ),
            duration: const Duration(seconds: 5),
          ),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: HexColor('1B2430'),
        appBar: AppBar(
          title: const Text('Scan Result'),
          elevation: 0,
          backgroundColor: HexColor('1B2430'),
          centerTitle: true,
        ),
        body: Obx(
          () => scanController.checkLoading().isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : scanController.product?.success == true
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // image
                            Image.network(
                              '$baseUrl${scanController.product?.data.batch.product.image}',
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
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      child: Text(
                                        '${scanController.product?.data.batch.product.name}',
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
                                      '${scanController.product?.data.collectionName}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                // price
                                Text(
                                  '\$${scanController.product?.data.batch.product.price}.00',
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
                            const Text(
                              'Batch Info',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // batch Info

                            // batch id
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Batch ID',
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
                                  '${scanController.product?.data.batch.uuid}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // total stock
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Stock Total',
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
                                  '${scanController.product?.data.stockTotal}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            scanController.product?.data.batch.product
                                        .collectionId ==
                                    1
                                ? const SizedBox()
                                :
                                // Expiry Date
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Batch batch expiry',
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
                                        '${scanController.product?.data.batch.expiryDate}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
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
                                  Get.offAllNamed('/home');
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
                  // Could not find prduct
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/gifs/empty-box.gif",
                          ),
                          const Text(
                            '!Oops, Could not find this product with QRcode',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: ThemeHelper().boxDecoration(),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: HexColor('1B2430'),
                                        child: const Text(
                                          '!',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: const Text(
                                          'Kindly make sure the product is added your inventory and assigned with valid generated qr code. Connection issue might cause this error tos display.',
                                          maxLines: 3,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton.icon(
                              onPressed: () {
                                Get.offAllNamed('/home');
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Go back',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
