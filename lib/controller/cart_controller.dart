
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_getx/model/cart.dart';
class CartController extends GetxController{
  static CartController get cartGetter=>Get.find<CartController>();
  RxMap cartItems=<String,Cart>{}.obs;

  void addItemsToCart(String proid,String title,double price){
   // cartItems.value.values.toList().forEach((element) {print(element.title);});
    if (cartItems.value.containsKey(proid)) {
      print('exist');
      cartItems.value.update(proid, (existingvalue) => Cart(id: existingvalue.id, title: existingvalue.title, price: existingvalue.price, quantity:existingvalue.quantity+1 ));
      //add quantity
    }else{
      print('new add');
      cartItems.value.putIfAbsent(proid, () => Cart(id: DateTime.now().toString(), title: title, price: price,quantity: 1));
      Get.snackbar('Items added', 'Yours Product add Successfully',duration: Duration(seconds: 1),snackPosition:SnackPosition.BOTTOM);

    }
  }
}