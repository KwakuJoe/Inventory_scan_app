import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';
import 'package:scaanthetic/common/theme_helper.dart';
import 'package:scaanthetic/controllers/scan_controller.dart';

class SellPage extends StatelessWidget {
  SellPage({super.key});

  MobileScannerController cameraController = MobileScannerController();
  ScanController scanController = Get.put(ScanController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sell Product',
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return Icon(Icons.flash_off, color: Colors.grey.shade300);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.purple);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return Icon(
                      Icons.camera_front,
                      color: Colors.grey.shade300,
                    );
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear, color: Colors.purple);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        allowDuplicates: false,
        controller: cameraController,
        onDetect: (barcode, args) {
          if (barcode.rawValue == null) {
            debugPrint('Failed to scan Barcode');
            Get.snackbar('Error', 'Failed to Scan Barcode');
          } else {
            final String code = barcode.rawValue!;
            // Get.snackbar('Success', 'Barcode found! $code');
            Get.defaultDialog(
              titlePadding: const EdgeInsets.only(top: 15),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              barrierDismissible: false,
              cancelTextColor: Colors.white,
              confirmTextColor: Colors.purple,
              radius: 10,
              actions: [
                TextButton(
                  onPressed: () {
                    Get.offAllNamed('/home');
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/sellResult', arguments: [code]);
                  },
                  child: const Text(
                    'Proceed',
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                ),
              ],
              backgroundColor: HexColor('1B2430'),
              title: 'Confirm sale of product',
              content: Column(
                // ignore: prefer_const_constructors
                children: const [
                  Text(
                    'Are you sure you want to sell this product. Product sold would update your inventory.',
                  )
                ],
              ),
            );
            debugPrint('Barcode found! $code');
            Get.delete<MobileScannerController>();
            // scanController.getOneProduct(code);
          }
        },
      ),
    );
  }
}
