import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_getx/model/product.dart';
import '../widgets/product_item.dart';
import '../controller/products_controller.dart';
import '../constant/icon_text_button.dart';
import '../controller/cart_controller.dart';
import '../screens/cart_screen.dart';
 enum FilterOptions{
  IsFavorite,
  All,
}
class ProductOverViewScreen extends StatelessWidget {
 final proController=ProductsController.productGetter;
 final cartController=CartController.cartGetter;
  @override
  Widget build(BuildContext context) {
    List<Product> data=proController.loadedProducts;
    print('build overview screen');
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
        actions: [
          Obx(()=>TextIconButton(cartController.cartItems.value.length.toString(),(){
            Get.to(CartScreen(),duration: Duration(milliseconds: 900),);
          }),),
          PopupMenuButton(
            itemBuilder: (_)=>[
              PopupMenuItem(child: Text('OnlyFavourite'),value: FilterOptions.IsFavorite,),
              PopupMenuItem(child: Text('All'),value: FilterOptions.All,),
            ],
            onSelected: (FilterOptions value){
              if (value==FilterOptions.IsFavorite) {
                proController.isFav();
              }else{
                proController.isNotFav();
              }
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body:GridView.builder(
          padding: EdgeInsets.all(7),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              childAspectRatio: 3/2,
              crossAxisSpacing: 10
          ),
          itemCount: data.length,
          itemBuilder:(BuildContext,index){
            return ProductItem(data,index);
          } ,
        ),
      );
  }
}
