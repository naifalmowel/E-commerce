import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'no_internet_page.dart';

class ConnectivityController extends GetxController {
  var isOffline = false.obs;

  @override
  void onInit() {
    super.onInit();
   if(!GetPlatform.isWeb){
     checkInternet();
     Connectivity().onConnectivityChanged.listen((result) {
       isOffline.value = (result == ConnectivityResult.none);
       if (isOffline.value) {
         Get.to(() => NoInternetPage());
       } else {
         if (Get.isDialogOpen == true || Get.currentRoute == '/noInternet') {
           Get.back();
         }
       }
     });
   }
  }

  void checkInternet() async {
    final result = await Connectivity().checkConnectivity();
    isOffline.value = (result == ConnectivityResult.none);
    if (isOffline.value) {
      Get.to(() => NoInternetPage());
    }
  }
}
