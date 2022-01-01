import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/order_controller.dart';
import '../controller/cart_controller.dart';
import '../widgets/cart_items.dart';
import '../model/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cartController = CartController.cartGetter;
    final orderController = OrderController.orderGetter;
    // print(cartController.cartItems.runtimeType);
    final List<Cart> cartObjects =
    // cartController.cartItems.value.values.toList()//this line show error list<dynamic cannt assign List<Cart>
    cartController.cartItems.value.values.toList() as List<Cart>;  //list of objects
    // print(cartObjects);
    final cartKeys =
        cartController.cartItems.value.keys.toList(); //list of keys
    // print(cartKeys);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Obx(
                      () => Text(
                        cartController.totalPrice.toStringAsFixed(2).toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    backgroundColor: Colors.purple,
                  ),
                  TextButton(
                      onPressed: () {
                        orderController.addOrder(cartObjects, cartController.totalPrice);
                        cartController.cartItems.clear();
                        Get.toNamed('/order_screen');
                      },
                      child: Text(
                        'Order Now',
                        style: TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          ),
          Obx(() => Expanded(
              child: ListView.builder(
                  itemCount: cartController.cartItems.value.length,
                  itemBuilder: (context, index) {
                    return CartItems(
                      cartObjects[index],
                      cartKeys[index],
                    );
                  })))
        ],
      ),
    );
  }
}
