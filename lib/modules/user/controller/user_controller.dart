import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  RxBool isLoading = false.obs;
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString userId = ''.obs;

  Future<void> getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      name.value = user.displayName??'';
      email.value = user.email??'';
      phone.value = user.photoURL??'';
      userId.value = user.uid;
    }
  }

  Future<void> updateUserName(String name) async {
    isLoading(true);
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.updateProfile(displayName: name);
      await user.reload();
      user = FirebaseAuth.instance.currentUser;
      Get.find<SharedPreferences>().remove('name');
      Get.find<SharedPreferences>().setString('name', name);
    }
    isLoading(false);
  }

  Future<void> updateUserEmail(String email) async {
    isLoading(true);
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await user.verifyBeforeUpdateEmail(email);
        await user.reload();
        user = FirebaseAuth.instance.currentUser;
        Get.find<SharedPreferences>().remove('email');
        Get.find<SharedPreferences>().setString('email', email);
      } catch (e) {
        debugPrint("Error: $e");
      }
    }

  }
  Future<void> updateUserPassword({required String currentPassword , required String newPassword,}) async {
    isLoading(true);
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: user.email!,
          password: currentPassword,
        );
        await user.updatePassword(newPassword);
        await user.reload();
        user = FirebaseAuth.instance.currentUser;
      } catch (e) {
        debugPrint("Error: $e");
      }
    }
    isLoading(false);
  }
  Future<void> handleEmailVerification() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.reload(); // Reloads the user's data
      user = FirebaseAuth.instance.currentUser; // Refresh the current user

      if (user!.emailVerified) {
        isLoading(false);
        debugPrint("Email has been successfully updated to: ${user.email}");
      } else {
        debugPrint("Email verification not completed yet.");
      }
    }
  }

  Future<void> deleteAccount({required String password , required String email , required String userId}) async {
    isLoading(true);
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        AuthCredential credential = EmailAuthProvider.credential(
          email: email,
          password: password,
        );

        await user.reauthenticateWithCredential(credential);
        await user.delete();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .delete();
        debugPrint("User account deleted successfully.");
        // Navigate to the login screen or another page
      } catch (e) {
        if (e is FirebaseAuthException && e.code == 'requires-recent-login') {
          debugPrint("Error: User needs to re-authenticate before deleting the account.");
          // Handle re-authentication, e.g., by asking the user to log in again
        } else {
          debugPrint("Error: $e");
        }
      }
    }
    isLoading(false);
  }
}
