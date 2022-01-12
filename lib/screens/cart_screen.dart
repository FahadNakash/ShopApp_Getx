import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/order_controller.dart';
import '../controller/cart_controller.dart';
import '../widgets/cart_items.dart';
import '../model/cart.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen> {
  bool _isloading=false;
  @override
  Widget build(BuildContext context) {
    final cartController = CartController.cartGetter;
    final orderController = OrderController.orderGetter;
   // print(cartController.cartItems.value);
    final Map<String,Cart> cartData=cartController.cartItems.value as Map<String,Cart>;

    // print(cartController.cartItems.value);
    final List<Cart> cartObjects =cartController.cartItems.value.values.toList() as List<Cart>;  //list of objects
    // cartController.cartItems.value.values.toList()//this line show error list<dynamic cannt assign List<Cart>
    //print(cartObjects[0].title);
    final  cartKeys = cartController.cartItems.value.keys.toList();                             //list of keys
     // print(cartKeys[2]);
    // print(cartController.cartItems.value.length);
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
                        '\$${cartController.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    backgroundColor: Colors.purple,
                  ),
                  TextButton(
                      onPressed: (cartController.totalPrice<=0 || _isloading)? null:() async{
                        setState(() {
                          _isloading=true;
                        });
                        try{await orderController.addOrder(cartObjects, cartController.totalPrice);}
                        catch(error){
                          return Get.defaultDialog(
                              title: 'Alert',
                              middleText: 'Oops Something Wrong...',
                              actions: [
                                FlatButton(
                                    shape: StadiumBorder(),
                                    color: Colors.green,
                                    onPressed: (){
                                      setState(() {
                                        _isloading=false;
                                      });
                                      Get.back();
                                    }, child: Text('Ok')),
                              ]
                          );
                        }
                        // cartController.cartItems.clear(); // it cannot clear map,it throw an error so this not work
                        cartController.cartItems.value=<String,Cart>{}; // clear map
                        Get.toNamed('/order_screen');
                        setState(() {
                          _isloading=false;
                        });
                      },
                      child:_isloading?CircularProgressIndicator(color: Colors.purple,): Text(
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
                      cartController.cartItems.value.values.toList()[index],
                      cartController.cartItems.value.keys.toList()[index],
                    );
                  })
          )
          )
        ],
      ),
    );
  }
}
