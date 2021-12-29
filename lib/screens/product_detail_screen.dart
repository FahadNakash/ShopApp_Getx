import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/products_controller.dart';
class ProductDetailScreen extends StatelessWidget {
  final title=Get.parameters['title']; // first method
  final productID=Get.parameters['id'];
  final proController=ProductsController.productGetter;

  @override
  Widget build(BuildContext context) {
    //find product by id second method;
   // final loadedProduct=proController.loadedProducts.firstWhere((element) =>element.id==productID);
    //find product by id third method;
    final loadedProduct=proController.findById(productID);
    print(loadedProduct.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}
