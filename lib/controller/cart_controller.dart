import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_getx/model/cart.dart';

class CartController extends GetxController {
  static CartController get cartGetter => Get.find<CartController>();
  RxMap cartItems = <String, Cart>{}.obs;

  void addItemsToCart(String proid, String title, double price) {
    // cartItems.value.values.toList().forEach((element) {print(element.title);});
    Map<String, Cart> temp = Map.from(cartItems.value);
    if (temp.containsKey(proid)) {
      temp.update(proid, (existingvalue) =>Cart(
              id: existingvalue.id,
              title: existingvalue.title,
              price: existingvalue.price,
              quantity: (existingvalue.quantity ?? 0) + 1));
      cartItems.value = temp;
      Get.snackbar('Add Quantity', 'Yours Product Quantity is Increase Successfully',duration: Duration(seconds: 2),snackPosition:SnackPosition.BOTTOM,mainButton: TextButton(onPressed: (){ removeSinglecartItem(proid); }, child: Text('Undo')),);
      // Get.snackbar('Quantity  is Increase', 'Product is already added',duration: Duration(milliseconds: 900), snackPosition: SnackPosition.BOTTOM,borderColor: Colors.purple,borderRadius: 10,borderWidth: 2,margin: EdgeInsets.all(10));
      //add quantity
    } else {
      temp.putIfAbsent(proid,() => Cart(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
      cartItems.value = temp;
       Get.snackbar('Items added', 'Yours Product add Successfully',duration: Duration(seconds: 2),snackPosition:SnackPosition.BOTTOM,mainButton: TextButton(onPressed: (){ removeSinglecartItem(proid); }, child: Text('Undo')),);

    }
  }

  double get totalPrice {
    double total = 0;
    cartItems.value.forEach((key, cartItem) {
      total = total + cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void deleteCartItems(String id) {
    Map<String, Cart> temp = Map.from(cartItems.value);
    // Get.defaultDialog(
    //   title: 'Alert',
    //   titleStyle: TextStyle(color: Colors.red),
    //   middleText: 'Are u really want to delete an items?',
    //   confirm: Text('Submit'),
    //   onConfirm: (){},
    //     cancel: Text('Denied'),
    //   onCancel: (){}
    // );
    temp.remove(id);
    cartItems.value = temp;
  }


  void removeSinglecartItem(String productid){
    late Map<String, Cart> temp = Map.from(cartItems.value);
    if(!temp.containsKey(productid)){
      return;
    }
    if(temp[productid]!.quantity!>1){
      temp.update(productid, (existingproduct) => Cart(id: existingproduct.id, title: existingproduct.title, price: existingproduct.price, quantity:existingproduct.quantity!-1));
    }else{
      temp.remove(productid);
    }
    cartItems.value = temp;
    
  }


}
