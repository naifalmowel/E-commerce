import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumer/modules/admin/dashboard/admin_dashboard.dart';
import 'package:sumer/modules/dashboard/dashboard_tab_bar.dart';
import 'package:sumer/modules/login/login_page.dart';
import 'package:sumer/util/no_internet_page.dart';
import 'package:sumer/util/theme/theme.dart';
import 'package:sumer/util/theme/theme_controller.dart';
import 'modules/admin/admin_controller.dart';
import 'modules/cart/controller/cart_controller.dart';
import 'modules/cart/view/cart_page.dart';
import 'modules/category/controller/category_controller.dart';
import 'modules/checkout/controller/checkout_controller.dart';
import 'modules/footer/view/controller/footer_controller.dart';
import 'modules/login/controller/login_controller.dart';
import 'modules/product/controller/product_controller.dart';
import 'modules/signup/signup.dart';
import 'modules/user/controller/user_controller.dart';
import 'util/internet_checker.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAB34-UMS8KMv23M9-TkZMyDNaWxGnXJ3E",
          authDomain: "sumer-bc931.firebaseapp.com",
          projectId: "sumer-bc931",
          storageBucket: "sumer-bc931.appspot.com",
          messagingSenderId: "970199102973",
          databaseURL: 'https://sumer-bc931-default-rtdb.firebaseio.com',
          appId: "1:970199102973:web:4a90813bcc33fff898d594"));
  final prefs = await SharedPreferences.getInstance();
  Get.put(prefs);
  Get.put(UserController());
  Get.put(CategoryController());
  Get.put(ProductController());
  Get.put(CartController());
  Get.put(FooterController());
  Get.put(CheckoutController());
  Get.put(LoginController());
  Get.put(ThemeController());
  Get.put(ConnectivityController());
  Get.put(AdminController());
  await initMain();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

  }
  final ThemeController themeController = Get.find<ThemeController>();
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          onInit: () async{
            FirebaseAuth.instance.authStateChanges().first.then((User? user) async{
              if(Get.find<AdminController>().isLoadingUser.value){return;}
              if (user == null ||
                  Get.find<SharedPreferences>().getString('name') == null) {
                Get.offAllNamed('/login');
              }
             else{
                Get.find<AdminController>().getAllInvoiceForUser(userId: user.uid );
                Get.find<CheckoutController>().getAllAddress();
                if(Get.find<SharedPreferences>().getString('email') == 'admin@admin.com') {
                  Get.find<AdminController>().isAll(true);
                  Get.find<AdminController>().getAllInvoice();
                  Get.offAllNamed('/adminDash');
                }else{
                   Get.find<ProductController>().fetchProducts('0');
                   Get.find<AdminController>().getCarousel();
                  Get.offAllNamed('/');
                }
              }
            });

          },
          color: Colors.white,
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeController.themeMode.value,
          defaultTransition: Transition.cupertino,
          title: 'E-commerce',
          getPages: [
            GetPage(name: '/', page: () => const DashboardTabBar()),
            GetPage(name: '/login', page: () => const LoginPage()),
            GetPage(name: '/signup', page: () => const Signup()),
            GetPage(name: '/cart', page: () => const CartPage(showBack: true,)),
            GetPage(name: '/adminDash', page: () => const AdminDashboard()),
            GetPage(name: '/noInternet', page: () => NoInternetPage()),
          ],
          // home:Get.find<SharedPreferences>().getString('name') != null? const DashBoard() : const LoginPage(),
        ));
  }


}
Future<void> initMain()async{
  var users = await Get.find<AdminController>().getAllUsers();
  if(users.isEmpty){
    final UserCredential userCredential = await  FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: 'admin@admin.com',
      password: '123456',
    );
    await userCredential.user!.updateProfile(displayName: 'admin' , photoURL: '055555555');
    await userCredential.user!.reload();
    await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
      'id': userCredential.user!.uid,
      'email': 'admin@admin.com',
      'username': 'admin',
      'phoneNo' : '055555555',
      'password' : '123456',
      'createdAt': DateTime.now(),
    });
    final FirebaseAuth auth =
        FirebaseAuth.instance;
    await auth.signOut();
  }
  await Get.find<AdminController>().getSocialMediaLinks();
  if(Get.find<AdminController>().socialMedia.isEmpty){
    try{
      await FirebaseFirestore.instance
          .collection('Social')
          .add({
        "tiktok" : true,
        "instagram" : true,
        "facebook" : true,
        "facebookUrl" : "",
        "instagramUrl" : "",
        "tiktokUrl" : "",
        "whats" : true,
        "whatsUrl" : "",
        "logo":''
      });
      await Get.find<AdminController>().getSocialMediaLinks();
    }catch(e){
      debugPrint(e.toString());
    }
  }
  await Get.find<AdminController>().getCarousel();
  if(Get.find<AdminController>().listCarousel.isEmpty){
    try{
      await FirebaseFirestore.instance
          .collection('carousel')
          .add({
        "title" : 'LOGO',
        "images" : [],
        "showButton" : false,
        "connectUrl" : '',
        "withoutLogo" : false,
      });
      await Get.find<AdminController>().getCarousel();
    }catch(e){
      debugPrint(e.toString());
    }
  }

}