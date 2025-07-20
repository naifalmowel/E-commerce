import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumer/modules/user/controller/user_controller.dart';
import 'package:sumer/util/constant.dart';
import 'package:sumer/util/text_util.dart';

class CustomEditPasswordDialog extends StatefulWidget {
  const CustomEditPasswordDialog({
    super.key,
  });

  @override
  State<CustomEditPasswordDialog> createState() =>
      _CustomEditPasswordDialogState();
}

String password = '';
String newPassword = '';
String confirmPassword = '';
final _formKey = GlobalKey<FormState>();
final userController = Get.find<UserController>();

class _CustomEditPasswordDialogState extends State<CustomEditPasswordDialog> {
  dialogContent(BuildContext context) {
    return Container(
        width: 400,
        height: 450,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Change Your Password',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600 , color: Colors.black ),
                      ),
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextUtil(
                    text: "Current Password",
                    color: Colors.black54,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        border: Border.fromBorderSide(
                            BorderSide(color: Colors.black54))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: TextFormField(
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                        cursorColor: Colors.black54,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your password !!';
                          } else if (value !=
                              (Get.find<SharedPreferences>()
                                      .getString('password') ??
                                  '')) {
                            return "Wrong Password !!";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          password = value!;
                        },
                        decoration: const InputDecoration(
                          fillColor: Colors.blueAccent,
                          focusColor: Colors.blueAccent,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextUtil(
                    text: "New Password",
                    color: Colors.black54,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        border: Border.fromBorderSide(
                            BorderSide(color: Colors.black54))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: TextFormField(
                        cursorColor: Colors.black54,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          newPassword = value;
                        },
                        decoration: const InputDecoration(
                          fillColor: Colors.blueAccent,
                          focusColor: Colors.blueAccent,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextUtil(
                    text: "Confirm Password",
                    color: Colors.black54,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        border: Border.fromBorderSide(
                            BorderSide(color: Colors.black54))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: TextFormField(
                        cursorColor: Colors.black54,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password must be at least 6 characters';
                          } else if (value != newPassword) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          confirmPassword = value;
                        },
                        decoration: const InputDecoration(
                          fillColor: Colors.blueAccent,
                          focusColor: Colors.blueAccent,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => userController.isLoading.value
                            ? Center(
                                child: CircularProgressIndicator(
                                color: Colors.blueAccent.withOpacity(0.5),
                              ))
                            : ElevatedButton(
                                onPressed: () async {

                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  _formKey.currentState!.save();
                                  if (password ==
                                      (Get.find<SharedPreferences>()
                                              .getString('password') ??
                                          '')) {
                                    await userController
                                        .updateUserPassword(newPassword: newPassword , currentPassword: password);
                                    await userController.getUserInfo();
                                    if (!context.mounted) {
                                      return;
                                    }
                                    Get.back();
                                    Constant.showSnakeBarSuccess(
                                        context, 'Edit Success !!');

                                  } else {
                                    Constant.showSnakeBarError(
                                        context, 'Wrong Password !!');
                                  }
                                  setState(() {});
                                },
                                style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                        Colors.blueAccent.withOpacity(0.5))),
                                child: const Text(
                                  'Save Changes',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}
