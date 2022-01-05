import 'package:flutter/material.dart';
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

  @override
  void dispose() {
    _imageUrlController.dispose();
    _url.dispose();
    _description.dispose();
    _priceFocus.dispose();
    _url.removeListener(_updateImage);
    super.dispose();
  }
  @override
  void initState() {
    _url.addListener(_updateImage);
    super.initState();
  }
  void _updateImage(){
    if(!_url.hasFocus){
      setState(() {

      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(onPressed:()=>proController.saveForm(_formkey), icon: Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Title',
                    hintText: 'Enter the title',
                    border: OutlineInputBorder()),
                validator: (value){

                },
                keyboardType: TextInputType.text,
                keyboardAppearance: Brightness.dark,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
              ),
              Divider(
                height: 5,
              ),
              TextFormField(
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
              ),
              Divider(
                height: 5,
              ),
              TextFormField(
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
                      onFieldSubmitted:(_){proController.saveForm(_formkey);}
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
