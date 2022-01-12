import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/order.dart';
import '../controller/order_controller.dart';
import '../widgets/order_items.dart';
import '../widgets/app_drawer.dart';
class OrderScreen extends StatefulWidget {
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final orderController = OrderController.orderGetter;
  @override
  Widget build(BuildContext context) {
    final List<Order> orderData=orderController.orderItems.value as List<Order>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer:AppDrawer(),
      body: FutureBuilder(
        future: orderController.fetchOrder(),
        builder: (context,snapshot){
          if (snapshot.connectionState==ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colors.purple,),);
          }
          return Obx(()=>ListView.builder(
              itemCount: orderController.orderItems.value.length,
              itemBuilder: (context,index){
                return OrderItems(
                  orderData[index],
                );
              }
          ));
        },
      )
    );
  }
}
