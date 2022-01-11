import 'package:flutter/material.dart';
import '../model/product.dart';
import 'package:get/get.dart';
import '../controller/products_controller.dart';
class UserProductItems extends StatefulWidget {
  final Product proData;
  UserProductItems({ required this.proData});

  @override
  State<UserProductItems> createState() => _UserProductItemsState();
}
class _UserProductItemsState extends State<UserProductItems> {
  bool _isloading=false;
  @override
  Widget build(BuildContext context) {
    final proController = ProductsController.productGetter;
    return ListTile(
      contentPadding: EdgeInsets.all(10),
      leading: CircleAvatar(
        backgroundImage:NetworkImage(widget.proData.imgUrl),
      ),
      title: Text(widget.proData.title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(icon:Icon(Icons.edit,color: Colors.purple,),onPressed:(){
              Get.toNamed('/edit_product_screen?id=${widget.proData.id}');
            }),
           _isloading?CircularProgressIndicator(color: Colors.red,):IconButton(icon:Icon(Icons.delete,color: Colors.red,),onPressed:()async{
             setState(() {
               _isloading=true;
             });
              try{
                await proController.deleteProduct(widget.proData.id!);
              }catch(error){
                Get.snackbar('Opps SomeThing Wrong', 'Please Check Your Internet Connection',);
                setState(() {
                  _isloading=false;
                });
              }

            }),
          ],
        ),
      ),

    );
  }
}
