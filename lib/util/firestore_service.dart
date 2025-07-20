import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumer/model/address_model.dart';
import 'package:sumer/model/carousel_model.dart';
import 'package:sumer/model/invoice_model.dart';
import 'package:sumer/model/social_media_model.dart';
import '../model/category_model.dart';
import '../model/product_model.dart';
import '../model/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Category>> getCategories() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('categories').get();
      return snapshot.docs.map((doc) => Category.fromDocument(doc)).toList();
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }

  Future<List<Product>> getAllProducts() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('products').get();
      return snapshot.docs.map((doc) => Product.fromDocument(doc)).toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<List<SalesInvoice>> getAllInvoices() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('invoices')
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs.map((doc) => SalesInvoice.fromMap(doc)).toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<List<SalesInvoice>> getAllInvoicesForUser(
      {required String userId}) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('invoices')
          .where('customerId', isEqualTo: userId)
          // .where('archived', isEqualTo: false)
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs.map((doc) => SalesInvoice.fromMap(doc)).toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<List<Product>> getProducts(String categoryId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('products')
          .where('catId', isEqualTo: categoryId)
          .get();
      return snapshot.docs.map((doc) => Product.fromDocument(doc)).toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<List<Address>> getAddress() async {
    var userId = Get.find<SharedPreferences>().getString('userId');
    if (userId == null) {
      return [];
    }
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('addresses')
          .get();
      return snapshot.docs.map((doc) => Address.fromDocument(doc)).toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<List<Address>> getAddressForUser({required String userID}) async {
    var userId = userID;
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('addresses')
          .get();
      return snapshot.docs.map((doc) => Address.fromDocument(doc)).toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<UserModel?> getUserByEmail(String email) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return UserModel.fromDocument(snapshot.docs.first , 0 , 0.0);
      } else {
        print('User not found');
        return null;
      }
    } catch (e) {
      print('Error fetching user by email: $e');
      return null;
    }
  }

  Future<List<UserModel>> getUsers() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').get();
      var sales = await getAllInvoices();
      return snapshot.docs.map((doc) {
        String userId = doc.id;
        var invoicesSnapshot =
            sales.where((e) => e.customerId == userId).toList();
        int invoiceCount = invoicesSnapshot.length;
        double totalSpending = invoicesSnapshot.fold(0.0, (double sum, doc) {
          if (doc.status == 'Paid') {
            return sum + (doc.totalAmount);
          }
          return sum;
        });
        return UserModel.fromDocument(doc ,invoiceCount , totalSpending);
      }).toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<List<CarouselModel>> getCarousel() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('carousel').get();

      return snapshot.docs.map((doc) => CarouselModel.fromMap(doc)).toList();
    } catch (e) {
      print('Error fetching carousel: $e');
      return [];
    }
  }

  Future<List<SocialModel>> getSocial() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('Social').get();
      return snapshot.docs.map((doc) => SocialModel.fromDocument(doc)).toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<void> addData(String collectionName, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionName).add(data);
      print('Document added successfully');
    } catch (e) {
      print('Error adding document: $e');
    }
  }
}
