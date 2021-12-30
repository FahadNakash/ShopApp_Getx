
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_getx/model/cart.dart';
class CartController extends GetxController{
  static CartController get cartGetter=>Get.find<CartController>();
  RxMap cartItems=<String,Cart>{}.obs;

  void addItemsToCart(String proid,String title,double price){
    print(cartItems.value);
   // cartItems.value.values.toList().forEach((element) {print(element.title);});
    Map<String,Cart> temp=Map.from(cartItems.value);
    if (temp.containsKey(proid)) {
      print('exist');
      temp.update(proid, (existingvalue) => Cart(id: existingvalue.id, title: existingvalue.title, price: existingvalue.price, quantity:(existingvalue.quantity??0)+1 ));
      cartItems.value=temp;
      //add quantity
    }else{
      print('new add');
      temp.putIfAbsent(proid, () => Cart(id: DateTime.now().toString(), title: title, price: price,quantity: 1));
      cartItems.value=temp;
      Get.snackbar('Items added', 'Yours Product add Successfully',duration: Duration(seconds: 1),snackPosition:SnackPosition.BOTTOM);
    }
  }

  double get totalPrice{
    double total=0;
    cartItems.value.forEach((key, cartItem) {
      total =total+cartItem.price*cartItem.quantity;
    });
    return total;
  }

}