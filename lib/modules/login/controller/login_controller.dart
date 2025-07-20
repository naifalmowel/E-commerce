import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../admin/admin_controller.dart';
import '../../admin/dashboard/admin_dashboard.dart';
import '../../checkout/controller/checkout_controller.dart';
import '../../dashboard/dashboard_tab_bar.dart';
import '../../product/controller/product_controller.dart';
import '../../user/controller/user_controller.dart';

class LoginController extends GetxController{
  RxBool darkTheme = (Get.find<SharedPreferences>().getBool('dark')??false).obs;
  RxBool isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<bool> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return false;
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      isLoading.value = true;
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null && user.email != null) {

        DocumentSnapshot userDoc =
        await _firestore.collection("users").doc(user.uid).get();
        if (!userDoc.exists) {
          linkWithEmailPassword(user.email!, user.email!);
          await user.updateProfile(displayName: user.displayName , photoURL: '');
          await user.reload();
          await _firestore.collection('users').doc(user.uid).set({
            'id': user.uid,
            'email': user.email,
            'username': user.displayName,
            'phoneNo': '',
            'password': user.email,
            'createdAt': DateTime.now(),
          });
        }else{
          await user.updateProfile(displayName: user.displayName , photoURL: userDoc['phoneNo']);
          await user.reload();
        }
      }
      await Get.find<UserController>().getUserInfo();
      var prefs = Get.find<SharedPreferences>();
      prefs.remove('name');
      prefs.remove('email');
      prefs.remove('userId');
      prefs.remove('password');
      prefs.setString('name', userCredential.user!.displayName ?? '');
      prefs.setString('email', userCredential.user!.email ?? '');
      prefs.setString('userId', userCredential.user!.uid);
      prefs.setString('password', userCredential.user!.email ?? '');
     await Get.find<AdminController>().getAllInvoiceForUser(userId: userCredential.user!.uid );
      await Get.find<CheckoutController>().getAllAddress();
      if(userCredential.user!.email == 'admin@admin.com'){
        await Get.find<AdminController>().getAllInvoice();
        Get.off(() => const AdminDashboard());
      }
      else{
        await Get.find<ProductController>().fetchProducts('0');
        Get.off(() => const DashboardTabBar());
      }
        isLoading.value = false;
      return true;
    } catch (e) {
      isLoading.value = false;
      print("❌ خطأ في تسجيل الدخول: $e");
      return false;
    }finally{
      isLoading.value = false;
    }
  }

  Future<bool> login({required String email , required String password}) async {
    final prefs = Get.find<SharedPreferences>();
      isLoading.value = true;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await Get.find<UserController>().getUserInfo();
      prefs.remove('name');
      prefs.remove('email');
      prefs.remove('userId');
      prefs.remove('password');
      prefs.setString('name', userCredential.user!.displayName ?? '');
      prefs.setString('email', userCredential.user!.email ?? '');
      prefs.setString('userId', userCredential.user!.uid);
      prefs.setString('password', password);


      Get.find<AdminController>().getAllInvoiceForUser(userId: userCredential.user!.uid );
      Get.find<CheckoutController>().getAllAddress();
      if(userCredential.user!.email == 'admin@admin.com'){
        Get.find<AdminController>().getAllInvoice();
        Get.off(() => const AdminDashboard());
      }
      else{
        Get.find<ProductController>().fetchProducts('0');
        Get.off(() => const DashboardTabBar());
      }
return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      isLoading.value = false;
      return false;
    } finally {
        isLoading.value = false;
    }
  }
  Future<void> linkWithEmailPassword(String email, String password) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
        await user.linkWithCredential(credential);

        print("تم ربط الحساب بكلمة مرور بنجاح!");
      }
    } catch (e) {
      print("خطأ أثناء الربط: $e");
    }
  }
}