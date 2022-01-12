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
    product=(json['products'] as List<dynamic>).map((cartItems) =>Cart(id: cartItems['id'], title: cartItems['title'], price: cartItems['price'], quantity: cartItems['quantity'])).toList();
    date=DateTime.parse(json['DateTime']);
  }

  // Map<String,dynamic> toJson(){
  //   return{
  //     'id':id,
  //     'price':price,
  //     'product':product
  //   }
  // }
}