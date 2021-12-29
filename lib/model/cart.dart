import 'package:flutter/cupertino.dart';

class Cart {
 final String? id;
 final String? title;
 final double? price;
 final int? quantity;
  Cart({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quantity});

  // Map<String ,dynamic> toJson(){
  //   return {
  //     'id':id,
  //     'title':title,
  //     'price':price,
  //     'quantity':quantity,
  //   };
  // }

}