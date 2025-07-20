import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumer/util/colors.dart';
import 'package:sumer/util/text_util.dart';

import '../modules/admin/admin_controller.dart';
import '../modules/product/controller/product_controller.dart';
import 'internet_checker.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off, size: 80, color: Colors.red),
            SizedBox(height: 20),
            TextUtil(
              text: "No internet connection",
              size: 25,
            ),
            SizedBox(height: 10),
            TextUtil(
              text: "Please check your internet connection and try again.",
              weight: true,
              align: TextAlign.center,
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              style: ButtonStyle(backgroundColor: WidgetStateColor.resolveWith((states) => secondaryColor.withAlpha(150),)),
              onPressed: () {
                if(!Get.find<ConnectivityController>().isOffline.value){
                   Get.find<AdminController>().getAllUsers();
                    Get.find<AdminController>().getSocialMediaLinks();
                   Get.find<AdminController>().getCarousel();
                   Get.find<ProductController>().fetchProducts('0');
                }
              },
              label: TextUtil(
                text: 'Try Again',
                color: Colors.white,
              ),
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
