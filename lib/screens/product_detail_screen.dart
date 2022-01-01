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

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: Hero(
        tag: UniqueKey(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(loadedProduct.imgUrl,fit: BoxFit.fill,),
            ),
            SizedBox(height: 10,),
            Text('\$${loadedProduct.price}',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text(loadedProduct.description),


          ],
        ),
      ),
    );
  }
}
