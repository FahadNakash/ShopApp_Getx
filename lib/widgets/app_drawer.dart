import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('ShopApp'),
            automaticallyImplyLeading: true,
          ),
          Divider(height: 5,),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: (){
              Get.toNamed('/product_overview_screen');
              // Get.to(()=>ProductOverViewScreen(),duration: Duration(milliseconds: 900));
            },
          ),
          Divider(height: 1,thickness: 1,),
          ListTile(
            leading: Icon(Icons.card_travel),
            title: Text('Orders'),
            onTap: (){
              Get.toNamed('/order_screen');
            },
          ),
          Divider(height: 1,thickness: 1,),
          ListTile(
            leading: Icon(Icons.card_travel),
            title: Text('Manage Proucts'),
            onTap: (){
              Get.toNamed('/user_product_screen');
            },
          ),
          Divider(height: 1,thickness: 1,),
          ListTile(
            leading: Icon(Icons.card_travel),
            title: Text('SignOut'),
            onTap: (){
              Get.toNamed('/auth_screen');
            },
          )

        ],
      ),

    );
  }
}
