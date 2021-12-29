import 'package:get/get.dart';
import 'package:shopapp_getx/model/Cart.dart';
class CartController extends GetxController{
  static CartController get cartGetter=>Get.find<CartController>();
  RxMap cartItems=<String,dynamic>{}.obs;

  void addItemsToCart(String proid,String title,double price){
    if (cartItems.value.containsKey(proid)) {

      //add quantity
    }else{
      cartItems.value.putIfAbsent(proid, () => Cart(id: DateTime.now().toString(), title: title, price: price,quantity: 1)
      );
    }
    print(cartItems);

  }




}