import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controller/cart_controller.dart';
import 'controller/products_controller.dart';
import 'screens/product_overview_screen.dart';
import 'screens/product_detail_screen.dart';
void main() {
  Get.put(CartController());
  Get.put(ProductsController());
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.purple
        ),
        primaryColor: Colors.purple,
        accentColor: Colors.orangeAccent,
        fontFamily: 'Lato'
      ),
      home: ProductOverViewScreen(),
      getPages: [
        GetPage(name: '/product_detail_screen', page: ()=>ProductDetailScreen()),
      ],
    );
  }
}


