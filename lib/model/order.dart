import 'package:flutter/cupertino.dart';

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
}