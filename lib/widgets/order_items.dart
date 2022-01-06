import 'package:flutter/material.dart';
import '../model/order.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class OrderItems extends StatelessWidget {
  final Order orderdata;
  OrderItems(this.orderdata);
  @override
  Widget build(BuildContext context) {
    return  Card(
      child: ExpansionTile(
        textColor: Colors.black54,
        title: Text('\$${orderdata.price.toStringAsFixed(2)}'),
        subtitle: Text('${DateFormat('dd MM yyyy  hh:mm').format(orderdata.date)}'),
       children: [
         Container(
           height: min(orderdata.product.length *10+20, 100),
           child: ListView(
              shrinkWrap: true,
             children: orderdata.product.map((productData){
               return Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(productData.title.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                   Text('${productData.quantity}x \$${productData.price}')
                 ],
               );
             }).toList(),
           ),
         )
       ]
      ),
    );
  }
}
