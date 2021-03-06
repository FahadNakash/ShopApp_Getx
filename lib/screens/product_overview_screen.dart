import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/products_controller.dart';
import '../constant/icon_text_button.dart';
import '../controller/cart_controller.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/product_grid.dart';
enum FilterOptions {
  IsFavorite,
  All,
}
class ProductOverViewScreen extends StatefulWidget {
  @override
  State<ProductOverViewScreen> createState() => _ProductOverViewScreenState();
}
class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  final proController = ProductsController.productGetter;
  final cartController = CartController.cartGetter;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
        actions: [
          Obx(
            () => TextIconButton(
                cartController.cartItems.value.length.toString(), () {
              Get.to(
                () => CartScreen(),
                duration: Duration(milliseconds: 900),
              );
            }),
          ),
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('OnlyFavourite'),
                value: FilterOptions.IsFavorite,
              ),
              PopupMenuItem(
                child: Text('All'),
                value: FilterOptions.All,
              ),
            ],
            onSelected: (FilterOptions value) {
              if (value == FilterOptions.IsFavorite) {
               setState(() {
                 proController.isFav.value=true;
               });
              } else {
               setState(() {
                 proController.isFav.value=false;
               });
              }
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body:FutureBuilder(
        future: proController.fetchProduct(),
        builder: (context,snapShot){
          if (snapShot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(color: Colors.purple,));
          }
           return ProductGrid();
        },
      ),
    );
  }
}
