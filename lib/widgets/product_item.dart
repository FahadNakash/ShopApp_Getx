import 'package:flutter/material.dart';
import '../model/product.dart';
import 'package:get/get.dart';

class ProductItem extends StatelessWidget {
  final List<Product> data;
  final int index;
  ProductItem(this.data, this.index);
  @override
  Widget build(BuildContext context) {
    return GridTile(
        child:InkWell(
          child:  Image.network(
            data[index].imgUrl,
            fit: BoxFit.cover,
          ),
          onTap: (){
            Get.toNamed('/product_screen_screen?title=${data[index].title}&id=${data[index].id}');
          },
        ),
      footer:ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10),),
        child: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(onPressed: (){},icon: Icon(Icons.favorite,color: Theme.of(context).accentColor,),),
          title: FittedBox(child: Text(data[index].title)),
          trailing:IconButton(onPressed: (){},icon: Icon(Icons.add_shopping_cart,color: Theme.of(context).accentColor),),
        ),
      )
    );
  }
}
