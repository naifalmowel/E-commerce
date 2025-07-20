import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumer/modules/login/login_page.dart';
import 'package:sumer/util/constant.dart';

import '../../util/text_util.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  ForgetPasswordPageState createState() => ForgetPasswordPageState();
}
class ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String email = '';

  Future<void> sendPasswordResetEmail() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.sendPasswordResetEmail(email: email);

      if (!mounted) return;
      Constant.showSnakeBarSuccess(
        context,
        'If an account with this email exists, a password reset link has been sent.',
      );

      Get.to(() => LoginPage());
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      Constant.showSnakeBarError(
        context,
        'An error occurred while trying to reset the password.',
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white,  image: DecorationImage(
              image: AssetImage('assets/image/bgWeb.jpg'),
              fit: BoxFit.cover)),
          alignment: Alignment.center,
          child: Container(
            width: 400,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black54),
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
                                  text: "Forget Password",
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
                              style:  Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 15),
                              cursorColor: Colors.black54,
                              onSaved: (value) {
                                email = value!;
                              },
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              decoration:  InputDecoration(
                                suffixIcon:  Icon(
                                  Icons.mail,
                                  color: Colors.black54,
                                ),
                                focusedBorder:  OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(color: Theme.of(context).textTheme.displayMedium!.color!)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(color: Theme.of(context).textTheme.displayMedium!.color!)),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(color: Theme.of(context).textTheme.displayMedium!.color!)),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            _isLoading
                                ? const Center(child: CircularProgressIndicator())
                                : GestureDetector(
                              onTap: sendPasswordResetEmail,
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).textTheme.displayMedium!.color!,
                                    borderRadius:
                                    BorderRadius.circular(30)),
                                alignment: Alignment.center,
                                child: TextUtil(
                                  text: "Send Link To Email",
                                  color: Theme.of(context).textTheme.displayLarge!.color,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                    child: TextUtil(
                                      text: "Back to  ",
                                      size: 14,
                                      weight: true,
                                    )),
                                InkWell(
                                  onTap: () {
                                    Get.offAllNamed('/login');
                                  },
                                  child: Center(
                                      child: TextUtil(
                                        text: "LOGIN",
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
