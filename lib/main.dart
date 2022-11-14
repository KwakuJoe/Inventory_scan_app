import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'views/collections/collection_show.dart';
import 'views/collections/collections_all.dart';
import 'views/collections/product_detail_page.dart';
import 'views/error/connection_error.dart';
import 'views/home/home.dart';
import 'views/notFound/notFound.dart';
import 'views/result/sell_result.dart';
import 'views/result/scan_result.dart';
import 'views/scan/scan.dart';
import 'views/auth/sign_in/signIn.dart';
import 'views/scan/sell.dart';
import 'views/splash/splash.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        backgroundColor: HexColor('1B2430'),
        fontFamily: 'Lato',
      ),
      home: SplashScreen(),
      getPages: [
        GetPage(
          name: '/scanPage',
          page: () => ScanPage(),
        ),
        GetPage(
          name: '/sellResult',
          page: () => SellResult(),
        ),
        GetPage(
          name: '/home',
          page: () => const Home(),
        ),
        GetPage(
          name: '/notFound',
          page: () => const NotFound(),
        ),
        GetPage(
          name: '/signInPage',
          page: () => const SignInPage(),
        ),
        GetPage(
          name: '/allCollections',
          page: () => AllCollection(),
        ),
        GetPage(
          name: '/showCollections',
          page: () => const ShowCollection(),
        ),
        GetPage(
          name: '/scanResult',
          page: () => ScanResult(),
        ),
        GetPage(
          name: '/productDetail',
          page: () => ProductDetailPage(),
        ),
        GetPage(
          name: '/errorConnectPage',
          page: () => const ErrorConnectPage(),
        ),
        GetPage(
          name: '/sellPage',
          page: () => SellPage(),
        ),
      ],
    );
  }
}
