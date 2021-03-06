import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_getx/model/product.dart';
import '../widgets/user_product_items.dart';
import '../controller/products_controller.dart';
class UserProductScreen extends StatelessWidget {
  final proController = ProductsController.productGetter;
  @override
  Widget build(BuildContext context) {
    final List<Product> proData=proController.loadedProducts;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(onPressed: (){
            Get.toNamed('/edit_product_screen');
          }, icon:Icon(Icons.add)),
        ],
      ),
      body:Obx(()=> ListView.builder(
          itemCount: proController.loadedProducts.length,
          itemBuilder: (contex,index){
            return Column(
              children: [
                Divider(height: 1,),
                UserProductItems(proData: proData[index]),
              ],
            );
          }),)
    );
  }
}
