import 'package:flutter/material.dart';
import 'package:shopapp_getx/model/product.dart';
import '../widgets/product_item.dart';
import '../controller/products_controller.dart';
class ProductOverViewScreen extends StatelessWidget {
 final proController=ProductsController.productGetter;
  @override
  Widget build(BuildContext context) {
    List<Product> data=proController.loadedProducts;
    print('build overview screen');
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
      ),
      body: GridView.builder(
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
