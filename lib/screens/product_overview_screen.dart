import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/products_controller.dart';
import '../constant/icon_text_button.dart';
import '../controller/cart_controller.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/product_grid.dart';
import '../controller/auth_controller.dart';
enum FilterOptions {
  IsFavorite,
  All,
  Theme,
}
class ProductOverViewScreen extends StatefulWidget {
  @override
  State<ProductOverViewScreen> createState() => _ProductOverViewScreenState();
}
class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  final proController = ProductsController.productGetter;
  final cartController = CartController.cartGetter;
  final authController=AuthController.authGetter;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('${authController.user.value!.email}'),
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
              PopupMenuItem(
                child: Text('Theme'),
                value: FilterOptions.Theme,
              ),
            ],
            onSelected: (FilterOptions value) {
              if (value == FilterOptions.IsFavorite) {
               setState(() {
                 proController.isFav.value=true;
                 print(proController.isFav.value);
               });
              } else if (value==FilterOptions.All) {
                setState(() {
                  proController.isFav.value = false;
                  print(proController.isFav.value);

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
