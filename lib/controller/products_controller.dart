import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import '../model/product.dart';
class ProductsController extends GetxController{
static ProductsController get productGetter=>Get.find<ProductsController>();

  final List<Product> loadedProducts =[
    Product(
      'p1',
      'Red Shirt',
      'A red shirt - it is pretty red!',
      29.99,
      'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      'p2',
      'Trousers',
      'A nice pair of trousers.',
      59.99,
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      'p3',
      'Yellow Scarf',
      'Warm and cozy - exactly what you need for the winter.',
      19.99,
      'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      'p4',
      'A Pan',
      'Prepare any meal you want.',
      49.99,
      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ].obs;




  Product findById(String? id){
    return loadedProducts.firstWhere((element) => element.id==id);
  }

  RxBool isFav=false.obs;


 List<Product> get favourieProductsList{
   if (isFav.value) {
     return loadedProducts.where((element) => element.isFavourite.value).toList();
   }
   return loadedProducts;

}
Future<void> addNewProduct(Product product)async{
   final url =Uri.parse('https://shopapp-getx-default-rtdb.asia-southeast1.firebasedatabase.app/products.json');
   final response=await http.post(url,body:json.encode({
     'title':product.title,
     'description':product.description,
     'price':product.price,
     'imageUrl':product.imgUrl,
     'isFav':product.isFavourite.value,
   }));
   if (response.statusCode==200) {
     print(json.decode(response.body)['name']);
     final newProduct=Product(json.decode(response.body)['name'],product.title, product.description,product.price,product.imgUrl,);
     print(newProduct.id);
     loadedProducts.add(newProduct);
     Get.back();
   }

}
void updateProduct(String id,Product product){
int index=loadedProducts.indexWhere((element) => element.id==id);
if (index>=0) {
  loadedProducts[index]=product;
  Get.back();
}else{
  print('no found');
}

}
void deleteProduct(String id){
   loadedProducts.removeWhere((element) => element.id==id);
}

}