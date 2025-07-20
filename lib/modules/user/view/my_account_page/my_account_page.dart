import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumer/modules/user/controller/user_controller.dart';
import 'package:sumer/util/colors.dart';

import 'delete_account_dialog.dart';
import 'edit_email_name_dialog.dart';
import 'edit_password_dialog.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

final userController = Get.find<UserController>();

class _MyAccountPageState extends State<MyAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'My Account',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                infoCard(
                    title: 'Name',
                    subTitle: userController.name.value,
                    editPressed: () {
                      userController.isLoading(false);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const CustomEditNameEmailDialog(
                              isEmail: false,
                            );
                          });
                    }),
                infoCard(
                    title: 'E-Mail Address',
                    subTitle: userController.email.value,
                    editPressed: () {
                      userController.isLoading(false);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const CustomEditNameEmailDialog(
                              isEmail: true,
                            );
                          });
                    }),
                infoCard(
                    title: 'Password',
                    subTitle: ''.padLeft(
                        (Get.find<SharedPreferences>().getString('password') ??
                                '')
                            .length,
                        '*'),
                    editPressed: () {
                      userController.isLoading(false);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const CustomEditPasswordDialog();
                          });
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const CustomDeleteAccountDialog();
                          });
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.redAccent)),
                    child: const Text(
                      'Delete Account',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget infoCard({
    required String title,
    required String subTitle,
    required VoidCallback editPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width < 800 ? 400 : 600,
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border.all(color: Colors.blueAccent.withOpacity(0.2), width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black45),
                    ),
                    Text(
                      subTitle,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.8)),
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 2,
                  child:
                      IconButton(onPressed: editPressed, icon: Icon(
                        Icons.edit,
                        color: secondaryColor,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
