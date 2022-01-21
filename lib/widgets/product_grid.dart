import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/product_item.dart';
import '../controller/products_controller.dart';
import '../model/product.dart';
class ProductGrid extends StatelessWidget {
  final proController = ProductsController.productGetter;
  @override
  Widget build(BuildContext context) {
    List<Product> proData =proController.loadedProducts;
    return  GridView.builder(
      padding: EdgeInsets.all(7),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10),
      itemCount: proData.length,
      itemBuilder: (BuildContext, index) {
        return ProductItem(proData, index) ;
      },
    );

  }
}
