import 'package:flutter/material.dart';
import '../model/cart.dart';
import '../controller/cart_controller.dart';
import'package:get/get.dart';
class CartItems extends StatelessWidget {
  final Cart cartdata;
  final String productid;
  CartItems(this.cartdata,this.productid);
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
      confirmDismiss: (direction){
         return Get.defaultDialog(
           title: 'Alert',
           middleText: 'Your are really to delete the item?',
           actions: [
           FlatButton(
             shape: StadiumBorder(),
              color: Colors.green,
               onPressed: (){
              cartController.deleteCartItems(productid);
              Get.back();
           }, child: Text('submit')),
           FlatButton(
             shape: StadiumBorder(),
             color: Colors.red,
               onPressed: (){
           Get.back();
           }, child: Text('denied')
           ),
           ]
         );
      },
      onDismissed: (direction){
        cartController.deleteCartItems(productid);
      },
      child: Card(
        margin: EdgeInsets.all(10),
        child:Padding(
          padding: EdgeInsets.all(10),
          child:  ListTile(
            leading: CircleAvatar(
              child: FittedBox(child: Text('\$${cartdata.price}')),
            ),
            title: Text('${cartdata.title}',style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text('Total:\$${(cartdata.price!.toDouble()*cartdata.quantity!.toInt()).toStringAsFixed(2)}'),
            trailing: Text('${cartdata.quantity}x',style: TextStyle(fontWeight: FontWeight.bold),),
          ),
        )
      ),
    );
  }
}
