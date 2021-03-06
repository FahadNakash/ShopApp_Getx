import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:shopapp_getx/helper_functions/custom_exception.dart';
import '../model/product.dart';
class ProductsController extends GetxController{
static ProductsController get productGetter=>Get.find<ProductsController>();
 final loadedProducts=<Product>[].obs;
  //  List<Product> loadedProducts =[
  //   Product(
  //     'p1',
  //     'Red Shirt',
  //     'A red shirt - it is pretty red!',
  //     29.99,
  //     'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
  //   ),
  //   Product(
  //     'p2',
  //     'Trousers',
  //     'A nice pair of trousers.',
  //     59.99,
  //     'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
  //   ),
  //   Product(
  //     'p3',
  //     'Yellow Scarf',
  //     'Warm and cozy - exactly what you need for the winter.',
  //     19.99,
  //     'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
  //   ),
  //   Product(
  //     'p4',
  //     'A Pan',
  //     'Prepare any meal you want.',
  //     49.99,
  //     'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
  //   ),
  // ].obs;


   //find by id
  Product findById(String? id){
    return loadedProducts.firstWhere((element) => element.id==id);
  }
 //isFav status
  RxBool isFav=false.obs;

  Future<void>  isToggle(List<Product> product,int index)async{
    product[index].isFavourite.value=!product[index].isFavourite.value;
    var url=Uri.parse('https://shopapp-getx-default-rtdb.asia-southeast1.firebasedatabase.app/products/${product[index].id}.json');
    final response=await http.patch(url,body: json.encode({
      'isFav':product[index].isFavourite.value
    }));
  }

 List<Product> get favourieProductsList{
   if (isFav.value) {
     return loadedProducts.where((element) => element.isFavourite.value).toList();
   }
   return loadedProducts;
}
// add new product
Future<void> addNewProduct(Product product)async{
   try {
     final url = Uri.parse('https://shopapp-getx-default-rtdb.asia-southeast1.firebasedatabase.app/products.json');
     final response = await http.post(url, body: json.encode(product.toJson()));
       final newProduct = Product(json.decode(response.body)['name'], product.title, product.description, product.price, product.imgUrl,);
       loadedProducts.add(newProduct);
   }catch(error){
     throw error;
   }
}
//fetch new product
Future<void> fetchProduct()async{
     final url = Uri.parse('https://shopapp-getx-default-rtdb.asia-southeast1.firebasedatabase.app/products.json');
     final response=await http.get(url);
     final Map<String,dynamic> extractedData=json.decode(response.body);
     // print('1 :${extractedData}');
     loadedProducts.clear();
     extractedData.keys.forEach((id) {
      Map<String ,dynamic> temp=extractedData[id]; //fetch object by id and get complete object
      // print('2: $temp');
      temp.addAll({'id': id});    //also add id in map
      // print('3 : $temp');
      loadedProducts.add(Product.fromJson(temp));
      // print('4 :${loadedProducts.value}');   //list of objects
    });
     // loadedProducts.value=_loadedProduct;
     // print('1');
     // print(extractedData);
     //
     // print('2');
     // extractedData.forEach((prodID, proData) {
     //   _loadedProduct.add(Product(
     //     prodID,
     //     proData['description']!,
     //     proData['ImageUrl']!,
     //     proData['price']!,
     //     proData['title']!,
     //   ));
     //
     // });
}

Future<void> updateProduct(String id,Product product)async{
int index=loadedProducts.indexWhere((element) => element.id==id);
if (index>=0) {
  final url = Uri.parse('https://shopapp-getx-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json');
  final response=await http.patch(url,body: json.encode({
    'title':product.title,
    'description':product.description,
    'imageUrl':product.imgUrl,
    'price':product.price,
  }));
  loadedProducts[index]=product;
  Get.back();
}else{
  print('no found');
}}

Future<void> deleteProduct(String id)async{
  final url = Uri.parse('https://shopapp-getx-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json');
  final deleteProductIndex=loadedProducts.value.indexWhere((pro) => id==pro.id);
  var deleteProduct=loadedProducts.value[deleteProductIndex];
  final response=await http.delete(url);
  if (response.statusCode>=400) {
    throw HttpException('error');
  }
  loadedProducts.remove(deleteProduct);

}
}