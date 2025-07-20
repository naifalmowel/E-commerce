import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumer/modules/admin/admin_controller.dart';
import 'package:sumer/modules/admin/category/category_list.dart';
import 'package:sumer/modules/admin/order/order_list.dart';
import 'package:sumer/modules/admin/products/product_list.dart';
import 'package:sumer/modules/category/controller/category_controller.dart';
import 'package:sumer/modules/product/controller/product_controller.dart';
import 'package:sumer/util/constant.dart';
import '../../../util/colors.dart';
import '../../../util/social_media.dart';
import '../../../util/text_util.dart';
import '../../dashboard/dashboard_tab_bar.dart';
import '../../login/login_page.dart';
import '../other/other_page.dart';
import '../users/user_list.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Constant.logo(),
                    IconButton(
                        tooltip: 'logout',
                        color: Colors.black,
                        onPressed: () {
                          Constant.confirmDialog(context, 'Logout', ()async{
                            Get.find<SharedPreferences>()
                                .remove('name');
                            final FirebaseAuth auth =
                                FirebaseAuth.instance;
                            await auth.signOut();
                            final GoogleSignIn googleSignIn = GoogleSignIn();
                            await googleSignIn.signOut();
                            Get.off(() => const LoginPage());
                          });

                        },
                        icon: const Icon(Icons.logout)),
                  ],
                ),
              ),
              Divider(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customButton(
                    onPressed: () async {
                      await Get.find<ProductController>().getAllProduct();
                      Get.find<CategoryController>().fetchCategories();
                      Get.to(() => const CategoryList());
                    },
                    title: 'Category',
                    context: context,
                    icon: Icons.category,
                  ),
                  customButton(
                    onPressed: () async {
                      Get.find<ProductController>().getAllProduct();
                      Get.find<CategoryController>().fetchCategories();
                      Get.to(() => const ProductList());
                    },
                    title: 'Product',
                    context: context,
                    icon: FontAwesomeIcons.boxesStacked,
                  ),
                  if (MediaQuery.of(context).size.width > 500)
                    customButton(
                      onPressed: () async {
                        Get.find<AdminController>().getSocialMediaLinks();
                        Get.find<AdminController>().getCarousel();
                        Get.to(() => const OtherPage());
                      },
                      title: 'Other',
                      context: context,
                      icon: Icons.view_agenda,
                    )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('invoices')
                          .where('read',
                              isEqualTo: false) // جلب فقط الفواتير غير المقروءة
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                            !snapshot.hasData ) {
                          return Center(child: CircularProgressIndicator());
                        }else if(snapshot.data == null || snapshot.hasError){

                        }
                        int unreadCount = snapshot.data!.docs.length;
                        int digitCount = unreadCount.toString().length; // حساب عدد المراتب
                        double decrement = (digitCount - 1) * 10; // تحديد مقدار الإنقاص
                        return Badge(
                          offset: Offset(-50 - decrement  , 12),
                          label: !snapshot.hasData
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                              : Text(
                                  // "NEW ${Get.find<AdminController>().allInvoice.where((e)=>!e.read).toList().length}",
                                  "NEW $unreadCount",

                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                          isLabelVisible: snapshot.data!.docs.isNotEmpty,
                          backgroundColor: Colors.blueAccent,
                          child: customButton(
                            onPressed: () async {
                              Get.find<AdminController>().isAll(true);
                              Get.find<AdminController>().getAllInvoice();
                              Get.find<AdminController>().getAllUsers();
                              Get.to(() => OrderList());
                            },
                            title: 'Orders',
                            context: context,
                            icon: Icons.receipt,
                          ),
                        );
                      }),
                  customButton(
                    onPressed: () {
                      Get.find<AdminController>().getAllUsers();
                      Get.to(() => const UsersList());
                    },
                    title: 'Users',
                    context: context,
                    icon: Icons.person,
                  ),
                  if (MediaQuery.of(context).size.width > 500)
                    customButton(
                      onPressed: () async {
                        Get.find<ProductController>().fetchProducts('0');
                        Get.to(() => const DashboardTabBar());
                      },
                      title: 'View Store',
                      context: context,
                      icon: Icons.arrow_forward,
                    ),
                ],
              ),
              if (MediaQuery.of(context).size.width <= 500)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customButton(
                      onPressed: () async {
                        Get.find<AdminController>().getSocialMediaLinks();
                        Get.find<AdminController>().getCarousel();
                        Get.to(() => const OtherPage());
                      },
                      title: 'Other',
                      context: context,
                      icon: Icons.view_agenda,
                    ),
                    customButton(
                      onPressed: () async {
                        Get.find<ProductController>().fetchProducts('0');
                        Get.to(() => const DashboardTabBar());
                      },
                      title: 'View Store',
                      context: context,
                      icon: Icons.arrow_forward,
                    ),
                  ],
                ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget customButton({
    required String title,
    required VoidCallback onPressed,
    required BuildContext context,
    required IconData icon,
  }) {
    var textColor = Theme.of(context).textTheme.displayLarge!.color;
    var bGColor = Colors.grey.shade400;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        radius: 20,
        child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: bGColor,
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .color!
                          .withAlpha(38),
                      spreadRadius: 0,
                      blurRadius: 20, // Increased blur radius
                      offset: const Offset(0, 4)),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  icon,
                  color: textColor,
                  size: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextUtil(text: title, color: textColor, size: 18),
                )
              ],
            )),
      ),
    );
  }
}
