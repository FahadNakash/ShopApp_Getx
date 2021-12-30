import 'package:flutter/material.dart';
import 'package:shopapp_getx/model/cart.dart';
import '../controller/cart_controller.dart';
import '../widgets/cart_items.dart';
class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController=CartController.cartGetter;
    final cart=cartController.cartItems.value.values.toList();
    print(cart);

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
                  Text('Total',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  Spacer(),
                  SizedBox(width: 10,),
                  Chip(label: Text(cartController.totalPrice.toStringAsFixed(2).toString(),style: TextStyle(color: Colors.white),),padding: EdgeInsets.only(left: 20,right: 20),backgroundColor: Colors.purple,),
                  TextButton(onPressed: (){}, child: Text('Order Now',style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold),))
                ],
              ),
            ),
          ),
          Expanded(child: ListView.builder(
            itemCount: cartController.cartItems.value.length,
              itemBuilder: (context,index){
                return CartItems(
                  cart[index]
                );
          })
          )
        ],
      ),
    );
  }
}
