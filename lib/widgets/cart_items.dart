import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/cart.dart';
import '../controller/cart_controller.dart';
class CartItems extends StatelessWidget {
  final Cart cartdata;
  final String keys;
  CartItems(this.cartdata,this.keys);
  @override
  Widget build(BuildContext context) {
    final cartController=CartController.cartGetter;
    return Dismissible(
      key:ValueKey(cartdata.id),
      background: Container(
        margin: EdgeInsets.all(9.5),
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 250),
        color: Colors.red,
        child: Icon(Icons.delete,size: 40,color: Colors.white,),
      ),
      direction:DismissDirection.endToStart,
      onDismissed: (direction){
        cartController.deleteCartItems(keys);
      },
      child: Card(
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
      ),
    );
  }
}
