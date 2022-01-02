import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/order.dart';
import '../model/cart.dart';
class OrderController extends GetxController{
  RxList orderItems=<Order>[].obs;
  static OrderController get orderGetter=>Get.find<OrderController>();

  void addOrder(List<Cart> cartItems,double price){
    if(cartItems.isNotEmpty){
      print('add order successfully');
      orderItems.insert(0, Order(id: DateTime.now().toString(),date: DateTime.now(),price:price,product: cartItems ));
    }else {
      Get.snackbar('No product Select', 'Plase Select Add Items!!!');
    }
  }




}