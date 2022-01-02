import 'package:flutter/material.dart';
import '../model/order.dart';
import '../controller/order_controller.dart';
import '../widgets/order_items.dart';
import '../widgets/app_drawer.dart';
class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final orderController = OrderController.orderGetter;
    final List<Order> orderData=orderController.orderItems.value as List<Order>;
    print(orderData);
    print(orderController.orderItems);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer:AppDrawer(),
      body: ListView.builder(
        itemCount: orderController.orderItems.value.length,
          itemBuilder: (context,index){
            return OrderItems(
              orderData[index],
            );
          }
      ),
    );
  }
}
