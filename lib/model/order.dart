import '../model/cart.dart';

class Order{
  late final String id;
  late final double price;
  late final List<Cart> product;
  late DateTime date;
  Order({
    required this.id,
    required this.price,
    required this.product,
    required this.date
  });

  Order.fromJson(Map<String,dynamic> json){
    id=json['id'];
    price=json['price'];
    product=json['product'];
    date=json['date'];
  }

  // Map<String,dynamic> toJson(){
  //   return{
  //     'id':id,
  //     'price':price,
  //     'product':product
  //   }
  // }
}