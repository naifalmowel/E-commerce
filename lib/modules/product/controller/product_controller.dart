import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/product_model.dart';
import '../../../util/firestore_service.dart';

enum SortOption { priceLowToHigh, priceHighToLow, nameAsc, nameDesc }

class ProductController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();
  var products = <Product>[].obs;
  var allProducts = <Product>[].obs;
  var filterProducts = <Product>[].obs;
  var filterProductsAdmin = <Product>[].obs;
  var isLoading = false.obs;
  var isUploading = false.obs;
  var catId = '0'.obs;
  var currentPage = 0.obs;
  RxList<String> imagesUrl = <String>[].obs;
  RxList<String> oldImagesUrl = <String>[].obs;
  final RxList<String> selectedCategories = List<String>.from(
          Get.find<SharedPreferences>().getStringList('catList') ?? [])
      .obs;
  RxInt itemsPerPage = 10.obs;
  Future<void> fetchProducts(String categoryId) async {
    try {
      Get.find<SharedPreferences>().remove('catList');
      selectedCategories.clear();
      Get.find<SharedPreferences>().remove('lowPrice');
      Get.find<SharedPreferences>().remove('topPrice');
      currentPage.value = 0;
      isLoading(true);
      products.value = categoryId == '0'
          ? await _firestoreService.getAllProducts()
          : await _firestoreService.getProducts(categoryId);
      products.value = products.where((e)=>e.active).toList();
    }catch(e){
      print('fetch Products Error  : $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getProductWithFilter({
    required List<String> catList,
    required double? lowPrice,
    required double? topPrice,
  }) async {
    try {
      isLoading(true);
      currentPage.value = 0;
      var allProduct = await _firestoreService.getAllProducts();
      products.value = allProduct.where((element) {
        return (element.active) &&(catList.isEmpty
                ? true
                : catList.contains(element.catId.toString())) &&
            (((element.offerPrice??0)==0?element.price:element.offerPrice!) >= (lowPrice ?? 1) &&
                ((element.offerPrice??0)==0?element.price:element.offerPrice!) <= (topPrice ?? 5000));
      }).toList();
    } finally {
      isLoading(false);
    }
  }

  Future<void> getAllProduct() async {
    try {
      isLoading(true);
      allProducts.value = await _firestoreService.getAllProducts();
      filterProductsAdmin.value = allProducts;
      filterProducts.value = allProducts.where((e)=>e.active).toList();
    } finally {
      isLoading(false);
    }
  }

  void filterPlayer(String playerName) {
    List<Product> results = [];
    if (playerName.isEmpty) {
      results = allProducts.where((e)=>e.active).toList();
    } else {
      results = allProducts.where((e)=>e.active).toList().where((element) {
        return element.brand
                .toString()
                .toLowerCase()
                .contains(playerName.toLowerCase()) ||
            element.model
                .toString()
                .toLowerCase()
                .contains(playerName.toLowerCase()) ||
            element.price
                .toString()
                .toLowerCase()
                .contains(playerName.toLowerCase());
      }).toList();
    }
    filterProducts.value = results;
    update();
  }
  void filterPlayerAdmin(String playerName) {
    List<Product> results = [];
    if (playerName.isEmpty) {
      results = allProducts;
    } else {
      results = allProducts.where((element) {
        return element.brand
                .toString()
                .toLowerCase()
                .contains(playerName.toLowerCase()) ||
            element.model
                .toString()
                .toLowerCase()
                .contains(playerName.toLowerCase()) ||
            element.price
                .toString()
                .toLowerCase()
                .contains(playerName.toLowerCase());
      }).toList();
    }
    filterProductsAdmin.value = results;
    update();
  }

  Future<bool> deleteProduct(
      {required String proId, required List<String> images}) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(proId)
          .delete();
      for (var i in images) {
        deleteImage(i);
      }
      getAllProduct();
      return true;
    } catch (e) {
      return false;
    }
  }

  void deleteImage(String url) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child(url);
      await ref.delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> addNewProduct({
    required String brand,
    required String dis,
    required String model,
    required String size,
    required String catId1,
    required int currentQty,
    required double price,
    required double offerPrice,
    required bool available,
    required bool active,
    required List<String> images,
  }) async {
    try {
      var data = {
        "brand": brand,
        "image": images.isNotEmpty ? images[0] : '',
        "dis": dis,
        "model": model,
        "size": size,
        "catId": catId1,
        "qty": 0,
        "currentQty": currentQty,
        "price": price,
        "offerPrice": offerPrice,
        "available": available,
        "images": images,
        "active": active,
      };
      await FirebaseFirestore.instance.collection('products').add(data);
      getAllProduct();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
  Future<bool> editProduct({
    required String id,
    required String brand,
    required String dis,
    required String model,
    required String size,
    required String catId1,
    required int currentQty,
    required double price,
    required double offerPrice,
    required bool available,
    required bool active,
    required List<String> images,
  }) async {
    try {
      var data = {
        "brand": brand,
        "image": images.isNotEmpty ? images[0] : '',
        "dis": dis,
        "model": model,
        "size": size,
        "catId": catId1,
        "qty": 0,
        "currentQty": currentQty,
        "price": price,
        "offerPrice": offerPrice,
        "available": available,
        "images": images,
        "active": active,
      };
      await FirebaseFirestore.instance.collection('products').doc(id).update(data);
      getAllProduct();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
