import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sumer/modules/login/forget_password_page.dart';

import 'package:sumer/util/colors.dart';
import 'package:sumer/util/constant.dart';
import '../../util/text_util.dart';
import 'controller/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

bool dark = false;

class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = '', _password = '';
  bool vis = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          
          decoration: BoxDecoration(color: Colors.grey.shade100,
            image: DecorationImage(image: AssetImage('assets/image/bgWeb.jpg') , fit: BoxFit.cover)
          ),
          
          alignment: Alignment.center,
          child: Container(

            width: 400,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey.withAlpha(100),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const SizedBox(
                              height: 8,
                            ),
                            Center(
                                child: TextUtil(
                              text: "Login",
                              weight: true,
                              size: 30,
                            )),
                            const SizedBox(
                              height: 8,
                            ),
                            TextUtil(
                              text: "Email",
                            ),
                            TextFormField(
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(fontSize: 15),
                              cursorColor: Colors.black54,
                              autofillHints: [AutofillHints.email],
                              onSaved: (value) {
                                _email = value!;
                              },
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.mail,
                                  color: Colors.black54,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .color!)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .color!)),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .color!)),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextUtil(
                              text: "Password",
                            ),
                            TextFormField(
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(fontSize: 15),
                              cursorColor: Colors.black54,
                              obscureText: vis,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'It Cannot Be Empty.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _password = value!;
                              },
                              onFieldSubmitted: (_) async {
                                if (!_formKey.currentState!.validate()) return;
                                _formKey.currentState!.save();
                                var result = await Get.find<LoginController>()
                                    .login(email: _email, password: _password);
                                if (result) {
                                  if (!context.mounted) {
                                    return;
                                  }
                                  Constant.showSnakeBarSuccess(
                                      context, 'Login Success !!');
                                } else {
                                  if (!context.mounted) {
                                    return;
                                  }
                                  Constant.showSnakeBarError(context,
                                      'Invalid Username Or Password !!');
                                }
                              },
                              decoration: InputDecoration(
                                suffixIcon: vis
                                    ? IconButton(
                                        onPressed: () {
                                          vis = !vis;
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.visibility,
                                          color: Colors.black54,
                                        ))
                                    : IconButton(
                                        onPressed: () {
                                          vis = !vis;
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.visibility_off,
                                          color: Colors.black54,
                                        )),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .color!)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .color!)),
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .color!)),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Obx(
                              () => Get.find<LoginController>().isLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            if (!_formKey.currentState!
                                                .validate()) return;
                                            _formKey.currentState!.save();
                                            var result = await Get.find<
                                                    LoginController>()
                                                .login(
                                                    email: _email,
                                                    password: _password);
                                            if (result) {
                                              if (!context.mounted) {
                                                return;
                                              }
                                              Constant.showSnakeBarSuccess(
                                                  context, 'Login Success !!');
                                            } else {
                                              if (!context.mounted) {
                                                return;
                                              }
                                              Constant.showSnakeBarError(
                                                  context,
                                                  'Invalid Username Or Password !!');
                                            }
                                          },
                                          child: Container(
                                            height: 40,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium!
                                                    .color!,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            alignment: Alignment.center,
                                            child: TextUtil(
                                              text: "LogIn",
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .displayLarge!
                                                  .color,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            var result = await Get.find<
                                                    LoginController>()
                                                .signInWithGoogle();
                                            if (result) {
                                              if (!context.mounted) {
                                                return;
                                              }
                                              Constant.showSnakeBarSuccess(
                                                  context, 'Login Success !!');
                                            } else {
                                              if (!context.mounted) {
                                                return;
                                              }
                                              Constant.showSnakeBarError(
                                                  context,
                                                  'Something Wrong !!');
                                            }
                                          },
                                          child: Container(
                                            height: 40,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: secondaryColor
                                                    .withAlpha(204),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextUtil(
                                                  text: "LogIn With Google",
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .displayLarge!
                                                      .color,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  FontAwesomeIcons.google,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .displayLarge!
                                                      .color,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => ForgetPasswordPage());
                                },
                                child: TextUtil(
                                  text: "Forget Password",
                                  size: 14,
                                  weight: true,
                                  color: Colors.white.withAlpha(204),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                    child: TextUtil(
                                  text: "Don't have a account ",
                                  size: 14,
                                  weight: true,
                                )),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed('/signup');
                                  },
                                  child: Center(
                                      child: TextUtil(
                                    text: "REGISTER",
                                    size: 14,
                                    weight: true,
                                    color: Colors.white.withAlpha(204),
                                  )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
