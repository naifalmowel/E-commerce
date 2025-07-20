import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumer/model/invoice_model.dart';
import 'package:sumer/model/social_media_model.dart';
import 'package:sumer/model/user_model.dart';

import '../../model/carousel_model.dart';
import '../../util/firestore_service.dart';

class AdminController extends GetxController {
  RxList<SocialModel> socialMedia = <SocialModel>[
    SocialModel(
        id: '',
        tiktok: true,
        instagram: true,
        facebook: true,
        facebookUrl: '',
        instagramUrl: '',
        tiktokUrl: '',
        whats: true,
        whatsUrl: '', logo: '', withoutLogo: false)
  ].obs;

  final FirestoreService _firestoreService = FirestoreService();
  RxList<UserModel> users = <UserModel>[].obs;
  RxList<SalesInvoice> allInvoices = <SalesInvoice>[].obs;
  RxList<SalesInvoice> allInvoice = <SalesInvoice>[].obs;
  RxList<SalesInvoice> allUserInvoice = <SalesInvoice>[].obs;
  RxList<SalesInvoice> allInvoicesFilter = <SalesInvoice>[].obs;
  RxList<UserModel> usersFilter = <UserModel>[].obs;
  RxList<CarouselModel> listCarousel = <CarouselModel>[].obs;
  RxList<String> imagesUrl = <String>[].obs;
  RxList<String> selectOrder = <String>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingUser = false.obs;
  RxBool isLoadingC = false.obs;
  RxBool isLoadingOrder = false.obs;
  RxBool isLoadingPay = false.obs;
  RxBool isLoadingD = false.obs;
  RxBool isAll = false.obs;
  RxBool delivered = false.obs;
  RxBool read = false.obs;
  RxBool withoutLogo = false.obs;
  RxBool isUnRead = false.obs;
  RxString logoImages = ''.obs;
  RxString invoiceStatus = ''.obs;
  RxDouble paidAmount = 0.0.obs;
  RxInt currentPage = 0.obs;
  RxInt itemsPerPage = 10.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<UserModel>> getAllUsers() async {
    try {
      isLoading(true);
      users.value = await _firestoreService.getUsers();
      usersFilter.value = users;
      return users;
    } catch (e) {
      isLoading(false);
      return [];
    } finally {
      isLoading(false);
    }
  }

  Future<List<CarouselModel>> getCarousel() async {
    try {
      isLoadingC(true);
      return listCarousel.value = await _firestoreService.getCarousel();
    } catch (e) {
      Future.delayed(Duration(milliseconds: 200));
      isLoadingC(false);
      return [];
    } finally {
      Future.delayed(Duration(milliseconds: 200));
      isLoadingC(false);
    }
  }

  Future getSocialMediaLinks() async {
    try {
      isLoading(true);
      socialMedia.value = await _firestoreService.getSocial();
      logoImages.value =socialMedia.first.logo;
      withoutLogo.value = socialMedia.first.withoutLogo;
    } catch (e) {
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
//   service firebase.storage {
//   match /b/{bucket}/o {
//   match /{allPaths=**} {
//   allow read: if request.auth != null || request.resource.contentType.matches('image/.*');
//   allow write: if request.auth != null;
//   }
// }
// }
  Future<String> getDownloadUrl(String path) async {
    return await FirebaseStorage.instance.ref(path).getDownloadURL();
  }
  void filterUserPlayer(String playerName) {
    List<UserModel> results = [];
    if (playerName.isEmpty) {
      results = users;
    } else {
      results = users.where((element) {
        return element.username
                .toString()
                .toLowerCase()
                .contains(playerName.toLowerCase()) ||
            element.email
                .toString()
                .toLowerCase()
                .contains(playerName.toLowerCase()) ||
            element.phoneNo
                .toString()
                .toLowerCase()
                .contains(playerName.toLowerCase());
      }).toList();
    }
    usersFilter.value = results;
  }

  Future<bool> addNewUser({
    required String email,
    required String password,
    required String username,
    required String phone,
  })
  async {
    isLoadingUser(true);
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      await userCredential.user!
          .updateProfile(displayName: username, photoURL: phone);
      await userCredential.user!.reload();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'id': userCredential.user!.uid,
        'email': email.trim(),
        'username': username,
        'phoneNo': phone,
        'password': password.trim(),
        'createdAt': DateTime.now(),
      });
      await _auth.signInWithEmailAndPassword(
        email: "admin@admin.com",
        password: "123456",
      );
      getAllUsers();
      isLoadingUser(false);
      return true;
    } catch (e) {
      isLoadingUser(false);
      print(e);
      return false;
    }
  }

  Future<bool> updateSocialMediaLinks() async {
    isLoading(true);
    try {
      await FirebaseFirestore.instance
          .collection('Social')
          .doc(socialMedia.first.id)
          .update(socialMedia.first.toMap());
      await getSocialMediaLinks();
      isLoading(false);
      return true;
    } catch (e) {
      isLoading(false);
      print(e);
      return false;
    }
  }
  Future<bool> updateSocialMediaLinksLogo({required bool withoutLogo}) async {
    isLoading(true);
    try {
      await FirebaseFirestore.instance
          .collection('Social')
          .doc(socialMedia.first.id)
          .update({"withoutLogo" : withoutLogo});
      await getSocialMediaLinks();
      isLoading(false);
      return true;
    } catch (e) {
      isLoading(false);
      print(e);
      return false;
    }
  }

  Future<bool> updateCarousel({
    required String title,
    required String connectUrl,
    required List<String> images,
    required bool showButton,
  }) async {
    isLoadingC(true);
    try {
      await FirebaseFirestore.instance
          .collection('carousel')
          .doc(listCarousel.first.id)
          .update({
        'title': title,
        'images': images,
        'showButton': showButton,
        'connectUrl': connectUrl,
      });
      await getSocialMediaLinks();
      isLoadingC(false);
      return true;
    } catch (e) {
      isLoadingC(false);
      print(e);
      return false;
    }
  }

  Future<List<SalesInvoice>> getAllInvoice() async {
    try {
      isLoadingOrder(true);
      allInvoice.value = await _firestoreService.getAllInvoices();
      allInvoices.value = allInvoice.where((e)=> (isAll.value? !e.archived : e.archived )&& (isUnRead.value? !e.read : true)).toList();
      allInvoicesFilter.value = allInvoices;
      return allInvoices;
    } catch (e) {
      return [];
    } finally {
      isLoadingOrder(false);
    }
  }
  Future<List<SalesInvoice>> getAllInvoiceForUser({required String userId}) async {
    try {
      isLoadingOrder(true);
      var allUserInvoice1 = await _firestoreService.getAllInvoicesForUser(userId: userId);
      allUserInvoice.value = allUserInvoice1;
      return allUserInvoice;
    } catch (e) {
      return [];
    } finally {
      isLoadingOrder(false);
    }
  }

  void filterInvoices(String playerName) {
    List<SalesInvoice> results = [];
    if (playerName.isEmpty) {
      results = allInvoices;
    } else {
      results = allInvoices.where((element) {
        return element.invoiceNumber
                .toString()
                .toLowerCase()
                .contains(playerName.toLowerCase()) ||
            element.totalAmount
                .toString()
                .toLowerCase()
                .contains(playerName.toLowerCase()) ||
            element.customerName
                .toString()
                .toLowerCase()
                .contains(playerName.toLowerCase()) ||
            element.status
                .toString()
                .toLowerCase()
                .contains(playerName.toLowerCase()) ||
            element.date
                .toString()
                .toLowerCase()
                .contains(playerName.toLowerCase()) ||
            element.time
                .toString()
                .toLowerCase()
                .contains(playerName.toLowerCase()) ||
            element.createdAt
                .toString()
                .toLowerCase()
                .contains(playerName.toLowerCase()) ||
            element.addressInfo
                .toString()
                .toLowerCase()
                .contains(playerName.toLowerCase()) ||
            element.paymentMethod
                .toString()
                .toLowerCase()
                .contains(playerName.toLowerCase()) ||
            element.shipmentType
                .toString()
                .toLowerCase()
                .contains(playerName.toLowerCase()) ||
            element.id
                .toString()
                .toLowerCase()
                .contains(playerName.toLowerCase());
      }).toList();
    }
    allInvoicesFilter.value = results;
    update();
  }
  Future<void> archivedInvoice({
    required String invoiceId,
    required bool archived,
  }) async {
    try {
      isLoadingOrder(true);
      await FirebaseFirestore.instance
          .collection('invoices')
          .doc(invoiceId)
          .update({'archived' : archived});
    } catch (e) {
      isLoadingOrder(false);
      print('خطأ في تحديث الفاتورة: $e');
    }finally{
      isLoadingOrder(false);
    }
  }
  Future<void> archivedInvoices({
    required List<String> invoiceIds,
    required bool archived,
  }) async {
    try {
      isLoadingOrder(true);

      WriteBatch batch = FirebaseFirestore.instance.batch();

      for (String invoiceId in invoiceIds) {
        DocumentReference docRef =
        FirebaseFirestore.instance.collection('invoices').doc(invoiceId);
        batch.update(docRef, {'archived': archived});
      }

      await batch.commit(); // تنفيذ جميع التحديثات دفعة واحدة
    } catch (e) {
      print('خطأ في تحديث الفواتير: $e');
    } finally {
      isLoadingOrder(false);
    }
  }

  Future<void> readInvoice({
    required  invoiceId,
    required bool read,
  }) async {
    try {
      isLoadingOrder(true);
      await FirebaseFirestore.instance
          .collection('invoices')
          .doc(invoiceId)
          .update({'read' : read});
    } catch (e) {
      isLoadingOrder(false);
      print('خطأ في تحديث الفاتورة: $e');
    }finally{
      isLoadingOrder(false);
    }
  }
  Future<void> readInvoices({
    required List<String> invoiceIds,
    required bool read,
  }) async {
    try {
      isLoadingOrder(true);

      WriteBatch batch = FirebaseFirestore.instance.batch();

      for (String invoiceId in invoiceIds) {
        DocumentReference docRef =
        FirebaseFirestore.instance.collection('invoices').doc(invoiceId);
        batch.update(docRef, {'read': read});
      }

      await batch.commit(); // تنفيذ جميع التحديثات دفعة واحدة
    } catch (e) {
      print('خطأ في تحديث الفواتير: $e');
    } finally {
      isLoadingOrder(false);
    }
  }
  Future<void> payInvoice({
    required String invoiceId,
    required String status,
    required double paidAmount,
  }) async {
    try {
      isLoadingPay(true);
      await FirebaseFirestore.instance
          .collection('invoices')
          .doc(invoiceId)
          .update({'paidAmount' : paidAmount ,  'status' : status});
    } catch (e) {
      isLoadingPay(false);
      print('خطأ في تحديث الفاتورة: $e');
    }finally{
      isLoadingPay(false);
    }
  }
  Future<void> deliveredShipment({
    required String invoiceId,
    required bool delivered,
  }) async {
    try {
      isLoadingD(true);
      await FirebaseFirestore.instance
          .collection('invoices')
          .doc(invoiceId)
          .update({'delivered' : delivered});
    } catch (e) {
      isLoadingD(false);
      print('خطأ في تحديث الفاتورة: $e');
    }finally{
      isLoadingD(false);
    }
  }
}
