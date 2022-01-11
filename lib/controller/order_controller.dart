import 'dart:convert';

import 'package:get/get.dart';
import '../model/order.dart';
import '../model/cart.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  RxList orderItems = <Order>[].obs;
  RxBool isExpandable = false.obs;

  static OrderController get orderGetter => Get.find<OrderController>();

  Future<void> addOrder(List<Cart> cartItems, double price) async {
    var url = Uri.parse(
        'https://shopapp-getx-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json');
    final  timeStamp =DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'DateTime':timeStamp.toIso8601String(),
          'price': price,
          'product': cartItems.map((items) => {
                    'id': items.id,
                    'title': items.title,
                    'price': items.price,
                    'quantity': items.quantity
                  })
              .toList(),
        }));
      orderItems.insert(0, Order(
              id: jsonDecode(response.body)['name'],
              date: DateTime.now(),
              price: price,
              product: cartItems));
  }
}
