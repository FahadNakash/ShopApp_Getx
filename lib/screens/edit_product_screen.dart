

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_getx/model/product.dart';
import '../controller/products_controller.dart';
class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}
class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocus = FocusNode();
  final _description = FocusNode();
  final _url = FocusNode();
  final TextEditingController _imageUrlController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final proController = ProductsController.productGetter;
   bool  _isFav=false;
   Product? _editedProduct=Product(null, '', '', 0, '',);
    String? id;
     bool _isLoading=false;
    var initValue={
      'title':'',
      'description':'',
      'price':'',
      'imgUrl':'',
    };
  @override
  void dispose() {
    _imageUrlController.dispose();
    _url.dispose();
    _description.dispose();
    _priceFocus.dispose();
    super.dispose();
  }
  @override
  void initState() {
    _url.addListener(_updateImage);
    super.initState();
    id=Get.parameters['id'];
   if (id!=null) {
     _editedProduct= proController.findById(id);
     _isFav=_editedProduct!.isFavourite.value;
     print(_isFav);
     initValue={
       'title':_editedProduct!.title,
       'description':_editedProduct!.description,
       'price':_editedProduct!.price.toString(),
       'imgUrl':_editedProduct!.imgUrl,
     };
     _imageUrlController.text=_editedProduct!.imgUrl;
     print(_editedProduct!.title);
   }
  }
  void _updateImage(){
    if(!_url.hasFocus){
      setState(() {
      });
    }
  }
  Future<void> saveForm()async{
    _formkey.currentState!.validate();
    _formkey.currentState!.save();
    setState(() {
      _isLoading=true;
    });
    if(_editedProduct!.id!=null){
      _editedProduct!.isFavourite.value=_isFav;
      await proController.updateProduct(_editedProduct!.id!, _editedProduct!);
    }else {
     try{
       await proController.addNewProduct(_editedProduct!);
       Get.back();
     }catch(error){
      await Get.defaultDialog(
           title:'OOPS somethings wrong',
           content: Row(
             mainAxisAlignment: MainAxisAlignment.end,
             children: [
               FlatButton(onPressed: (){
                 Get.back();
               }, child: Text('Okey',style: TextStyle(color: Colors.red),)
               )
             ],
           )
       );
     }finally{
       setState(() {
         _isLoading=false;
       });}
    }}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(onPressed:()=>saveForm(), icon: Icon(Icons.save))
        ],
      ),
      body:_isLoading?Center(child: CircularProgressIndicator(),):Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: initValue['title'],
                decoration: InputDecoration(
                    labelText: 'Title',
                    hintText: 'Enter the title',
                    border: OutlineInputBorder()),
               onSaved: (value){
                  _editedProduct=Product(_editedProduct!.id, value!, _editedProduct!.description,_editedProduct!.price , _editedProduct!.imgUrl,);
               },
                keyboardType: TextInputType.text,
                keyboardAppearance: Brightness.dark,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                validator: (value){
                 if (value!.isEmpty) {
                   return 'Please enter the tilte';
                 }
                 if (value.contains(RegExp(r'[0-9]'))) {
                   return 'Please Enter the Alphabet';
                 }
                 if (value.length<2) {
                   return 'Your title is Less';
                 }
                 return null;
                },
              ),
              Divider(
                height: 5,
              ),
              TextFormField(
                initialValue: initValue['price'],
                decoration: InputDecoration(
                  labelText: 'Price',
                  hintText: 'Enter the price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                focusNode: _priceFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_description);
                },
                onSaved: (value){
                  _editedProduct=Product(_editedProduct!.id, _editedProduct!.title, _editedProduct!.description,double.parse(value!) , _editedProduct!.imgUrl,);
                },
                validator: (value){
                  if(value!.isEmpty){
                    return 'Please Enter the value';
                  }
                  if (double.tryParse(value)==null) {
                    return 'Please enter the Correct Price';
                  }
                  if (double.tryParse(value)!<=0) {
                    return 'invalid Price';
                  }
                  return null;
                },
              ),
              Divider(
                height: 5,
              ),
              TextFormField(
                initialValue: initValue['description'],
                decoration: InputDecoration(
                  labelText: 'Descrption',
                  hintText: 'Enter the Description',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.multiline,
                focusNode: _description,
                maxLines: 3,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_url);
                },
                onSaved: (value){
                  _editedProduct=Product(_editedProduct!.id, _editedProduct!.title, value!,_editedProduct!.price , _editedProduct!.imgUrl,);
                },
                validator: (value){
                  if(value!.isEmpty){
                    return 'Please Enter the Value';
                  }
                  if (value.length<=10) {
                    return 'Should be at least 10 Character';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(right: 7),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.black12,
                      width: 2,
                    )),
                    child: _imageUrlController.text.isEmpty
                        ? Center(
                            child: Text(
                            'Please Enter Url First!',
                          ))
                        : Image.network(
                            _imageUrlController.text,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter the url',
                      ),
                      focusNode: _url,
                      controller: _imageUrlController,
                      onSaved: (value){
                        _editedProduct=Product(_editedProduct!.id, _editedProduct!.title, _editedProduct!.description,_editedProduct!.price ,value!,);
                      },
                      onFieldSubmitted:(_){saveForm();},
                      validator: (value){
                        if(value!.isEmpty) {
                          return 'Please Enter The url';
                        }
                        if (!value.startsWith('https')) {
                          return 'Please enter the valid url';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


}
