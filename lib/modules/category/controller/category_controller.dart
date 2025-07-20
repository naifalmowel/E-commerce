import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../util/firestore_service.dart';
import '../../../model/category_model.dart';

class CategoryController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();
  var categories = <Category>[].obs;
  var allCategories = <Category>[].obs;
  var filterCategories = <Category>[].obs;
  var tempImage = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      allCategories.value = await _firestoreService.getCategories();
      categories.clear();
      categories.add(Category(
          id: '0',
          name: 'ALL',
          image:
              'https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/all.png?alt=media&token=915ebac5-bb93-4929-ba5e-7dbac88a56a6',
          description: ''));
      for (var i in allCategories) {
        categories.add(i);
      }
      filterCategories.value = allCategories;
    } finally {
      isLoading(false);
    }
  }

  void filterPlayer(String playerName) {
    List<Category> results = [];
    if (playerName.isEmpty) {
      results = allCategories;
    } else {
      results = allCategories.where((element) {
        return element.name
                .toString()
                .toLowerCase()
                .contains(playerName.toLowerCase()) ||
            element.id
                .toString()
                .toLowerCase()
                .contains(playerName.toLowerCase());
      }).toList();
    }
    filterCategories.value = results;
    update();
  }

  Future<bool> addNewCategory(
      {required String title,
      required String description,
      required String image}) async
  {
try{
  var data = {
    "name": title,
    "image": image,
    "description": description,
  };
  await FirebaseFirestore.instance.collection('categories').add(data);
  fetchCategories();
  return true;
}catch(e){
  print(e);
  return false;
}
  }
  Future<bool> editCategory(
      {required String catId,
        required String title,
        required String description,
        required String image}) async
  {
    try{
      var data = {
        "name": title,
        "image": image,
        "description": description,
      };
      await FirebaseFirestore.instance.collection('categories').doc(catId).update(data);
      fetchCategories();
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }
  Future<bool> deleteCategory({required String catId}) async {
    try{
      await FirebaseFirestore.instance.collection('categories').doc(catId).delete();
      fetchCategories();
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }
}
