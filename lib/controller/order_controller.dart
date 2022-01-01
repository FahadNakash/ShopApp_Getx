import 'package:get/get.dart';
import '../model/order.dart';
import '../model/cart.dart';
class OrderController extends GetxController{
  RxList orderItems=<Order>[].obs;
  static OrderController get orderGetter=>Get.find<OrderController>();

  void addOrder(List<Cart> cartItems,double price){
    orderItems.insert(0, Order(id: DateTime.now().toString(),date: DateTime.now(),price:price,product: cartItems ));
    print(orderItems);


  }




}