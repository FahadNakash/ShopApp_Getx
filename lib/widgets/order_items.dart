import 'package:flutter/material.dart';
class OrderItems extends StatelessWidget {
  const OrderItems({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Card(
      child: ListTile(
        title: Text('price'),
        subtitle: Text('date'),
      ),
    );
  }
}
