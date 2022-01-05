import 'package:flutter/material.dart';
import 'package:shopapp_getx/model/product.dart';
import '../widgets/user_product_items.dart';
import '../controller/products_controller.dart';
class UserProductScreen extends StatelessWidget {
  const UserProductScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final proController = ProductsController.productGetter;
    final List<Product> proData=proController.loadedProducts;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
      ),
      body: ListView.builder(
        itemCount: proController.loadedProducts.length,
          itemBuilder: (contex,index){
        return Column(
          children: [
            Divider(height: 1,),
            UserProductItems(proData: proData[index]),
          ],
        );
      }),
    );
  }
}
