import 'package:flutter/material.dart';
import '../model/product.dart';
import 'package:get/get.dart';
import '../controller/cart_controller.dart';

class ProductItem extends StatelessWidget {
final List<Product> data;
final int index;
ProductItem(this.data, this.index);
final cartController=CartController.cartGetter;

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: InkWell(
          child: Image.network(
            data[index].imgUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Get.toNamed(
                '/product_detail_screen?title=${data[index].title}&id=${data[index].id}');
          },
        ),
        footer: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          child: GridTileBar(
            backgroundColor: Colors.black54,
            leading:IconButton(
              onPressed: () {
                data[index].isFavourite.value=!data[index].isFavourite.value;
              },
              icon: Obx(()=>Icon(
                data[index].isFavourite.value?Icons.favorite:Icons.favorite_border_outlined,
                color: data[index].isFavourite.value?Colors.red:Colors.orangeAccent,
              ),),
            ),
            title: FittedBox(child: Text(data[index].title)),
            trailing:IconButton(
              onPressed: () {
              cartController.addItemsToCart(data[index].id, data[index].title, data[index].price);
              },
              icon: Icon(Icons.add_shopping_cart,
                  color: Theme.of(context).accentColor),
            ),
          ),
        ));;
  }
}

//
