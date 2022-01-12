import 'dart:convert';

import 'package:get/get.dart';
import 'package:shopapp_getx/helper_functions/custom_exception.dart';
import 'package:shopapp_getx/model/product.dart';
import '../model/order.dart';
import '../model/cart.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  RxList orderItems = <Order>[].obs;
  RxBool isExpandable = false.obs;

  static OrderController get orderGetter => Get.find<OrderController>();

  Future<void> addOrder(List<Cart> cartItems, double price) async {
    try {
      var url=Uri.parse('https://shopapp-getx-default-rtdb.asia-southeast1.firebasedatabase.app/Order.json');
      final timeStamp=DateTime.now();
      final response= await http.post(url,body: json.encode({
        'id':timeStamp.toIso8601String(),
        'price':price,
        'DateTime':timeStamp.toIso8601String(),
        'products':cartItems.map((item) => {
        'id':item.id,
        'title':item.title,
        'price':item.price,
        'quantity':item.quantity,
        }).toList()
      }));
      orderItems.insert(0, Order(
          id: json.decode(response.body)['name'],
          date: DateTime.now(),
          price: price,
          product: cartItems));
    }catch(error){
      throw HttpException('${error}');
    }
  }
  
  Future<void> fetchOrder()async{
  try{
    var url =Uri.parse('https://shopapp-getx-default-rtdb.asia-southeast1.firebasedatabase.app/Order.json');
    final response=await http.get(url);
    final extractedData=json.decode(response.body) as Map<String,dynamic>;
    orderItems.clear();
    // extractedData.forEach((orderID, orderData) {
    //   loadedOrders.add(
    //     Order(
    //         id: orderID,
    //         price:orderData['price'],
    //         product:(orderData['products'] as List<dynamic>).map((cartItems) =>Cart(
    //             id: cartItems['id'],
    //             title: cartItems['title'],
    //             price: cartItems['price'],
    //             quantity: cartItems['quantity']
    //         ) ).toList(),
    //         date: DateTime.parse(orderData['DateTime']))
    //   );
    // });
    // orderItems.value=loadedOrders;
    //this approach is best
    extractedData.keys.forEach((id) {
      Map<String,dynamic> temp=extractedData[id];
      orderItems.add(Order.fromJson(temp));
    });
  }catch(error){
    throw HttpException('${error}');
  }



  }
}
