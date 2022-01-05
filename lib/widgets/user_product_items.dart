import 'package:flutter/material.dart';
import '../model/product.dart';
import '../screens/edit_product_screen.dart';
import 'package:get/get.dart';
class UserProductItems extends StatelessWidget {
  final Product proData;
  UserProductItems({ required this.proData});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(10),
      leading: CircleAvatar(
        backgroundImage:NetworkImage(proData.imgUrl),
      ),
      title: Text(proData.title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(icon:Icon(Icons.edit,color: Colors.purple,),onPressed:(){
              Get.toNamed('/edit_product_screen');
            }),
            IconButton(icon:Icon(Icons.delete,color: Colors.red,),onPressed:(){}),
          ],
        ),
      ),

    );
  }
}
