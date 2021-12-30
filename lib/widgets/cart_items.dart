import 'package:flutter/material.dart';
import '../model/cart.dart';
class CartItems extends StatelessWidget {
  final Cart cartdata;
  CartItems(this.cartdata);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child:Padding(
        padding: EdgeInsets.all(10),
        child:  ListTile(
          leading: CircleAvatar(
            child: FittedBox(child: Text('\$${cartdata.price}'))
          ),
          title: Text('${cartdata.title}',style: TextStyle(fontWeight: FontWeight.bold),),
          subtitle: Text('Total:\$${(cartdata.price!.toDouble()*cartdata.quantity!.toInt())}'),
          trailing: Text('${cartdata.quantity}x',style: TextStyle(fontWeight: FontWeight.bold),),
        ),
      )
    );
  }
}
