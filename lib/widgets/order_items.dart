import 'package:flutter/material.dart';
import '../model/order.dart';
import 'package:intl/intl.dart';
class OrderItems extends StatelessWidget {
  final Order orderdata;
  OrderItems(this.orderdata);
  @override
  Widget build(BuildContext context) {
    return  Card(
      child: ExpansionTile(
        textColor: Colors.black54,
        title: Text('\$${orderdata.price}'),
        subtitle: Text('${DateFormat('dd MM yyyy  hh:mm').format(orderdata.date)}'),
       children: orderdata.product.map((productData){
         return Container(
           padding: EdgeInsets.all(5),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text(productData.title.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
               Text('${productData.quantity}x \$${productData.price}')
             ],
           ),
         );
       }).toList()
      ),
    );
  }
}
