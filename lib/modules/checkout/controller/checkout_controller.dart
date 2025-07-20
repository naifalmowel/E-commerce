import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumer/model/address_model.dart';

import '../../../model/invoice_model.dart';
import '../../../util/firestore_service.dart';
import '../../cart/controller/cart_controller.dart';
import '../../user/controller/user_controller.dart';

class CheckoutController extends GetxController {
  RxString country = ''.obs;
  RxList<Address> address = <Address>[].obs;
  RxBool loading = false.obs;
  RxBool submitLoading = false.obs;
  RxList<Address> addressDetails = <Address>[].obs;
  final FirestoreService _firestoreService = FirestoreService();
  RxString addressInfo = ''.obs;
  RxString selectedAddress = ''.obs;
  RxString selectedShip = ''.obs;
  RxString selectedPay = ''.obs;
RxMap<String , dynamic> salesPrint = <String , dynamic>{}.obs;
  Future getAllAddress() async {
    try {
      loading(true);
      address.value = await _firestoreService.getAddress();
    } finally {
      loading(false);
    }
  }
  Future getAllAddressForUser({required String userId}) async {
    try {
      loading(true);
      addressDetails.value = await _firestoreService.getAddressForUser(userID: userId);
    } finally {
      loading(false);
    }
  }

  Future deleteAddress({required String addressId , String? userId1}) async {
    var userId = userId1??Get.find<SharedPreferences>().getString('userId');
    if (userId == null) {
      return;
    }
    try {
      loading(true);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('addresses')
          .doc(addressId)
          .delete();
    } finally {
      loading(false);
      await getAllAddress();
    }
  }

  Future getAddressDetailsFromId(String addId ) async {
    addressDetails.value = address.where((e) {
      return e.id == addId;
    }).toList();
  }
Future<SalesInvoice> initBill({required bool isCard})async{
  final FirestoreService
  firestoreService =
  FirestoreService();
  var userInfo = await firestoreService
      .getUserByEmail(
      Get.find<UserController>()
          .email
          .toString());
  List<Item> items = [];
  for (var i
  in Get.find<CartController>()
      .cartItems) {
    var price = ((i.offerPrice ?? 0) > 0
        ? (i.offerPrice)
        : (i.price));
    items.add(Item(
        productId: i.id,
        productName:
        "${i.brand}  ${i.model}",
        quantity: i.qty ?? 0,
        price: price ?? 0,
        total:
        (i.qty ?? 0) * (price ?? 0),
        image: i.image));
  }
  var shipAmount = 0.0;
  var subTotal = 0.0;
  var finalTotal = 0.0;
  if (Get.find<CheckoutController>()
      .selectedShip
      .contains('Slow')) {
    shipAmount = 25 ;
    subTotal = Get.find<CartController>()
        .finalTotal
        .value - shipAmount ;
    finalTotal = Get.find<CartController>()
        .finalTotal
        .value;
  }
  else if(Get.find<CheckoutController>()
      .selectedShip
      .contains('Free')){
    shipAmount = 0 ;
    subTotal = Get.find<CartController>()
        .finalTotal
        .value - shipAmount ;
    finalTotal = Get.find<CartController>()
        .finalTotal
        .value;
  }else{
    shipAmount = 50 ;
    subTotal = Get.find<CartController>()
        .finalTotal
        .value - shipAmount ;
    finalTotal = Get.find<CartController>()
        .finalTotal
        .value;
  }

  var now = DateTime.now();
  SalesInvoice sales = SalesInvoice(
      date:
      "${now.year}-${now.month}-${now.day}",
      time:
      "${now.hour}:${now.minute}:${now.second}",
      customerName:
      userInfo?.username ?? '',
      customerId: userInfo?.id ?? '',
      items: items,
      subTotal: subTotal,
      tax: 0,
      totalAmount:
      finalTotal,
      paymentMethod:
      Get.find<CheckoutController>()
          .selectedPay
          .value,
      status: isCard ? 'Paid' :'Due',
      delivered: false,
      addressId:
      Get.find<CheckoutController>()
          .selectedAddress
          .value,
      addressInfo:
      Get.find<CheckoutController>()
          .addressInfo
          .value,
      shipmentType:
      Get.find<CheckoutController>()
          .selectedShip
          .value,
      shipmentAmount: shipAmount,
      invoiceNumber: '',
      createdAt: Timestamp.now(),
      archived: false,
      read: false,
      paidAmount:isCard?finalTotal : 0.0
  );
  return sales;
}
  Future<bool> addInvoiceWithMaterialMovements(Map<String, dynamic> salesInvoice) async {
    try {
      DocumentReference counterRef =
      FirebaseFirestore.instance.collection('counters').doc('invoiceCounter');

      CollectionReference invoicesRef =
      FirebaseFirestore.instance.collection('invoices');

      CollectionReference materialMovementsRef =
      FirebaseFirestore.instance.collection('materialMovements');

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot counterSnapshot = await transaction.get(counterRef);

        if (!counterSnapshot.exists) {
          transaction.set(counterRef, {'lastInvoiceNumber': 0});
        }

        int lastInvoiceNumber =
        counterSnapshot.exists ? counterSnapshot['lastInvoiceNumber'] : 0;

        int newInvoiceNumber = lastInvoiceNumber + 1;
        String invoiceNumber =
            '#IN${newInvoiceNumber.toString().padLeft(4, '0')}';

        transaction.update(counterRef, {'lastInvoiceNumber': newInvoiceNumber});

        salesInvoice['invoiceNumber'] = invoiceNumber;


        DocumentReference newInvoiceRef = invoicesRef.doc();
        salesInvoice['id'] = newInvoiceRef.id;
        transaction.set(newInvoiceRef, salesInvoice);

        List<dynamic> items = salesInvoice['items'];
        for (var item in items) {
          Map<String, dynamic> materialMovement = {
            "invoiceId": newInvoiceRef.id,
            "productId": item['productId'],
            "productName": item['productName'],
            "quantity": item['quantity'],
            "movementType": "Sale",
            "date": DateTime.now(),
          };

          DocumentReference newMovementRef = materialMovementsRef.doc();
          transaction.set(newMovementRef, materialMovement);
        }
      });
      salesPrint.value = salesInvoice;
      print('Invoice added successfully with material movements.');
      return true;
    } catch (e) {
      print('Error adding invoice: $e');
      return false;
    }
  }

}
