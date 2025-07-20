import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumer/modules/user/controller/user_controller.dart';
import 'package:sumer/util/constant.dart';
import 'package:sumer/util/text_util.dart';

class CustomEditNameEmailDialog extends StatefulWidget {
  const CustomEditNameEmailDialog({
    required this.isEmail,
    super.key,
  });

  final bool isEmail;

  @override
  State<CustomEditNameEmailDialog> createState() =>
      _CustomEditNameEmailDialogState();
}

TextEditingController name = TextEditingController();
String password = '';
final _formKey = GlobalKey<FormState>();
final userController = Get.find<UserController>();

class _CustomEditNameEmailDialogState extends State<CustomEditNameEmailDialog> {
  Future<void> initiateEmailUpdate(String newEmail) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await user.verifyBeforeUpdateEmail(newEmail);
        if(!mounted){return;}
        showEmailVerificationDialog(context);
      } catch (e) {
        debugPrint("Error: $e");
        showErrorDialog(context, e.toString());
      }
    }
  }

  Future<void> handleEmailVerification() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.reload();
      user = FirebaseAuth.instance.currentUser;

      if (user!.emailVerified) {
        debugPrint("Email has been successfully updated to: ${user.email}");

        userController.isLoading(false);
        if(!mounted){
          return;
        }
        showSuccessDialog(context, "Email has been successfully updated!");
      } else {
        debugPrint("Email verification not completed yet.");
      }
    }
  }

  void showEmailVerificationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Verify Your Email'),
          content: const Text(
              'A verification link has been sent to your new email address. Please check your inbox and click the link to complete the update.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                startVerificationCheckTimer();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  dialogContent(BuildContext context) {
    return Container(
        width: 400,
        height: 350,
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
                      Text(
                        widget.isEmail
                            ? 'Change Your Email'
                            : 'Change Your Name',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600 , color: Colors.black),
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
                    text: widget.isEmail ? 'Email' : 'Name',
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
                        controller: name,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                        onSaved: (value) {
                          name.text = value!;
                        },
                        cursorColor: Colors.black54,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return widget.isEmail
                                ? 'Please enter a Email'
                                : 'Please enter a Name';
                          } else if (widget.isEmail && !value.contains('@')) {
                            return 'Please enter a Valid Email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          fillColor: Colors.blueAccent,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
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
                        obscureText: true,
                        cursorColor: Colors.black54,
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
                                    if (widget.isEmail) {
                                      userController.isLoading(true);
                                      await initiateEmailUpdate(name.text);
                                    } else {
                                      await userController
                                          .updateUserName(name.text);
                                      await userController.getUserInfo();
                                      if (!context.mounted) {
                                        return;
                                      }
                                      Constant.showSnakeBarSuccess(
                                          context, 'Edit Success !!');
                                      Get.back();
                                    }
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

  void startVerificationCheckTimer() {
    Timer.periodic(const Duration(seconds: 10), (timer) async {
      await handleEmailVerification();
      // Stop the timer once the email is verified and updated
      if (FirebaseAuth.instance.currentUser?.emailVerified ?? false) {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    name.text =
        widget.isEmail ? userController.email.value : userController.name.value;
    super.initState();
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
