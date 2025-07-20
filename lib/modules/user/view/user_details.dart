import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumer/modules/admin/dashboard/admin_dashboard.dart';
import 'package:sumer/modules/user/view/user_order/user_order.dart';
import 'package:sumer/util/colors.dart';
import 'package:sumer/util/social_media.dart';

import '../../../util/constant.dart';
import '../../../util/text_util.dart';
import '../../admin/admin_controller.dart';
import '../../login/login_page.dart';
import '../../setting/setting_page.dart';
import 'address/address_page.dart';
import 'my_account_page/my_account_page.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key , required this.showBack});
  final bool showBack ;
  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            widget.showBack? Align(
                alignment: Alignment.topLeft,
                child: BackButton(
                  onPressed: () {
                    Get.back();
                  },
                )):SizedBox(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SideMenu(
                    showToggle: true,
                    style: SideMenuStyle(
                        backgroundColor: secondaryColor.withAlpha(50),
                        selectedColor: Colors.white,
                        itemOuterPadding: const EdgeInsets.all(8),
                        unselectedIconColor:
                            Theme.of(context).textTheme.bodyLarge!.color,
                        unselectedTitleTextStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 15)),
                    controller: sideMenu,
                    title: Obx(
                      () => Get.find<AdminController>().isLoading.value ||
                              Get.find<AdminController>().isLoadingC.value
                          ? Center(
                              child: CircularProgressIndicator(
                                color: secondaryColor,
                              ),
                            )
                          : Get.find<AdminController>().withoutLogo.value
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: TextUtil(
                                      text: Get.find<AdminController>()
                                              .listCarousel
                                              .isNotEmpty
                                          ? Get.find<AdminController>()
                                              .listCarousel
                                              .last
                                              .title
                                          : "LOGO",
                                      size: MediaQuery.of(context).size.width >
                                              650
                                          ? 25
                                          : 15,
                                    ),
                                  ),
                                )
                              : Get.find<AdminController>()
                                      .logoImages
                                      .value
                                      .isNotEmpty
                                  ? Image.network(
                                      Get.find<AdminController>()
                                          .logoImages
                                          .value,
                                      fit: BoxFit.cover,
                                      // اجعل الصورة تغطي الدائرة بشكل جيد
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.asset(
                                        'assets/image/logo.png',
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Image.asset(
                                      'assets/image/logo.png',
                                      fit: BoxFit.cover,
                                    ),
                    ),
                    footer: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SocialMedia(),
                    ),
                    onDisplayModeChanged: (mode) {},
                    items: [
                      SideMenuItem(
                        title: 'My Account',
                        onTap: (index, _) {
                          sideMenu.changePage(index);
                        },
                        icon: const Icon(Icons.person),
                      ),
                      SideMenuItem(
                        title: 'My Orders',
                        onTap: (index, _) {
                          sideMenu.changePage(index);
                        },
                        icon: const Icon(Icons.receipt),
                      ),
                      SideMenuItem(
                        title: 'My Address',
                        onTap: (index, _) {
                          sideMenu.changePage(index);
                        },
                        icon: const Icon(Icons.file_copy_rounded),
                      ),
                      SideMenuItem(
                        title: 'Setting',
                        onTap: (index, _) {
                          sideMenu.changePage(index);
                        },
                        icon: const Icon(Icons.settings),
                      ),
                      SideMenuItem(
                        builder: (context, displayMode) {
                          return const Divider(
                            endIndent: 8,
                            indent: 8,
                          );
                        },
                      ),
                      if ((Get.find<SharedPreferences>().getString('email') ??
                              '') ==
                          'admin@admin.com')
                        SideMenuItem(
                            title: 'Admin Dashboard',
                            icon: const Icon(Icons.dashboard),
                            onTap: (index, _) {
                              Get.offAll(() => AdminDashboard());
                            }),
                      SideMenuItem(
                          title: 'Logout',
                          icon: const Icon(Icons.logout),
                          onTap: (index, _) {
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
                          }),
                    ],
                  ),
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      onPageChanged: (value) {
                        sideMenu.changePage(value);
                      },
                      children: [
                        const MyAccountPage(),
                        UserOrder(),
                        const AddressPage(),
                        const SettingPage(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
