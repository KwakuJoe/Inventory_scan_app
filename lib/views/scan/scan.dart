import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';
import 'package:scaanthetic/controllers/scan_controller.dart';

class ScanPage extends StatelessWidget {
  ScanPage({super.key});

  MobileScannerController cameraController = MobileScannerController();
  ScanController scanController = Get.put(ScanController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scan Product',
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
            Get.toNamed('/scanResult', arguments: [code]);
            debugPrint('Barcode found! $code');
            Get.delete<MobileScannerController>();
            // scanController.getOneProduct(code);
          }
        },
      ),
    );
  }
}
