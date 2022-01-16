import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopapp_getx/screens/product_overview_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../screens/auth_screen.dart';
// class AuthController extends GetxController{
//   late String _token;
//   late String _userId;
//   late Rx<DateTime> _expiry=DateTime.now().obs;
//
//   bool? get isAuth{
//     return token!=null;
//   }
//
//   String? get token{
//     if (_token!=null && _expiry.value.isAfter(DateTime.now()) && _expiry!=null) {
//       return token;
//     }
//     return null;
//   }
//
//   final String apiKey='AIzaSyAZ8wWGnsLXHEjntBYzf4LJZFhosPa_Ow8';
//
//   static AuthController get authGetter=>Get.find<AuthController>();
//   //signup
//   Future<void> sigUp(String email,String password)async{
// try{
//   var url=Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiKey');
//   final response=await http.post(url,body:json.encode({
//     'email':email,
//     'password':password,
//     'returnSecureToken':true
//   }));
//   if (json.decode(response.body)['error']!=null) {
//     throw HttpException(json.decode(response.body)['error']['message']);
//   }
//   _token=json.decode(response.body)['idToken'];
//   _userId=json.decode(response.body)['localId'];
//   _expiry.value=DateTime.now().add(Duration( seconds: json.decode(response.body)['expiresIn']));
// }catch(error){
//  throw(error);
// }
//   }
//
//   //login
//   Future<void> logIn(String email,String password)async{
//    try{
//      var url=Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$apiKey');
//      final response=await http.post(url,body: json.encode({
//        'email':email,
//        'password':password,
//        'returnSecureToken':true
//      }));
//      print(json.decode(response.body));
//      if (json.decode(response.body)['error']!=null){
//        throw HttpException(json.decode(response.body)['error']['message']);
//      }
//    }catch(error){
//      throw error;
//    }
//
//
//
//   }
//
//
//
//
// }
class AuthController extends GetxController{
  static AuthController get authGetter =>Get.find<AuthController>();
  FirebaseAuth _auth=FirebaseAuth.instance;
  //get the username ,email,password
  late Rx<User?> user;
  @override
  void onReady() {
    super.onReady();
    user=Rx<User?>(_auth.currentUser);
    //our user now notify...
    user.bindStream(_auth.userChanges());
    //triggle whenever userchanges appear
    ever(user, _initialScreen);
  }
  
  _initialScreen(User? user){
    if (user==null) {
      Get.offAll(()=>AuthScreen());
    }else{
      Get.offAll(()=>ProductOverViewScreen());
    }
  }

  Future<void> signUp(String email,String password)async{
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print('Success');
    }on FirebaseAuthException catch(e){
      Fluttertoast.showToast(msg: e.message.toString());
     // Get.defaultDialog(title: 'Alert',content: Text(e.message.toString()),actions: [TextButton(onPressed: (){Get.back();}, child: Text('ok'))]);
    }catch(error){
      Get.snackbar('Alert', error.toString(),duration: Duration(seconds: 1));
    }


  }
  Future<void> logIn(String email,String password)async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print('Success');
    }on FirebaseAuthException catch(e){
      Fluttertoast.showToast(msg: e.message.toString(),gravity: ToastGravity.TOP);
     // Get.defaultDialog(title: 'Alert',content: Text(e.message.toString()),actions: [TextButton(onPressed: (){Get.back();}, child: Text('ok'))]);

    }
    catch(error){
      Get.defaultDialog(title: 'Alert',content: Text(error.toString()),actions: [TextButton(onPressed: (){Get.back();}, child: Text('ok'))]);
    }


  }
  Future<void> signOut(String email,String password)async{
    try{
      await _auth.signOut();
    }catch(error){
      Get.snackbar('Alert', error.toString(),duration: Duration(seconds: 1));
    }


  }

}