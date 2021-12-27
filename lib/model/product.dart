import 'package:get/get.dart';
class Product {
  late final String id;
  late final String title;
  late final String description;
  late final double price;
  late final String imgUrl;
  RxBool isFavourite=false.obs;
  Product(this.id, this.title, this.description, this.price, this.imgUrl,);
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    imgUrl = json['imgUrl'];
    isFavourite.value= json['isFavourite'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imgUrl': imgUrl,
    };
  }
}
