import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumer/modules/checkout/controller/checkout_controller.dart';
import 'package:sumer/modules/user/controller/user_controller.dart';

import '../../../model/product_model.dart';

class CartController extends GetxController {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  var cartItems = <Product>[].obs;
  var cartItemsQTY = 0.obs;
  var cartItemsTotal = 0.0.obs;
  var shipTotal = 0.0.obs;
  var finalTotal = 0.0.obs;
RxBool loadingDelete = false.obs;
  String userId = Get.find<UserController>().userId.value;

  @override
  void onInit() {
    super.onInit();
    Get.find<UserController>().getUserInfo();
    loadCartItems();
  }
  Future loadCartItems()async {
    userId = Get.find<UserController>().userId.value;
    userId == '' ? null : await _dbRef.child('cart/$userId').once().then((DatabaseEvent event) {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.value != null) {
        Map<dynamic, dynamic>? items = dataSnapshot.value as Map<dynamic, dynamic>?;
        if (items != null) {
          cartItems.clear();
          cartItems.assignAll(
            items.entries.map((entry) {
              return Product.fromMap(entry.value, entry.key);
            }).toList(),
          );
        }
      }
    });
    cartItemsQTY(0);
    cartItemsTotal(0);
    shipTotal(0);
    finalTotal(0);
    for(var i in cartItems){
      cartItemsQTY.value += i.qty??0;
      cartItemsTotal.value += (i.qty! * ((i.offerPrice??0)>0?i.offerPrice!:i.price));
    }
    finalTotal.value = cartItemsTotal.value;
  }
  Future getTotals()async {
    shipTotal(0);
    finalTotal(0);
    if(Get.find<CheckoutController>().selectedShip.contains('Slow')){
      shipTotal.value = 25;
    }else if(Get.find<CheckoutController>().selectedShip.contains('Fast')){
      shipTotal.value = 50;
    }else{
      shipTotal.value = 0;
    }
    finalTotal.value = cartItemsTotal.value + shipTotal.value;
  }

  Future addItem(Product item)async  {
    userId = Get.find<UserController>().userId.value;
    if((item.qty??0)==0){
      item.qty = 1;
    }else if ((item.qty??0) > 0) {
      item.qty = item.qty!  + 1 ;
    }
    userId == '' ? null :
   await _dbRef.child('cart/$userId/${item.id}').set(item.toMap());
    cartItems.add(item);
   await loadCartItems();
  }
  Future updateProductInCart(String productId, int newQty)async {

    _dbRef.child('cart/$userId/$productId').update({'qty': newQty}).then((_) {

      int index = cartItems.indexWhere((product) => product.id == productId);
      if (index != -1) {
        cartItems[index].qty = newQty;
        cartItems.refresh();
      }
    });   await loadCartItems();

  }

  Future removeItem(Product item)async {
    loadingDelete(true);
    userId = Get.find<UserController>().userId.value;
    item.qty = null;
    userId == '' ? null :
   await _dbRef.child('cart/$userId/${item.id}').remove();
    cartItems.length == 1 ? cartItems.clear() :  cartItems.remove(item);
   await loadCartItems();
    loadingDelete(false);
  }

  Future clearCart()async {
    userId = Get.find<UserController>().userId.value;
    userId == '' ? null :
   await _dbRef.child('cart/$userId').remove();
    cartItems.clear();
    loadCartItems();
  }
}
