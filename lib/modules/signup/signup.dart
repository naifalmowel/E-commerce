import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../util/constant.dart';
import '../../util/text_util.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<Signup> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '',
      _password = '',
      _confirmPassword = '',
      _username = '',
      _phone = '';
  bool _isLoading = false;
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool vis = true;
  bool vis1 = true;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    if (_phone.length < 10) {
      Constant.showSnakeBarError(context, 'Something Wrong in Phone Number !!');
      return;
    }
    Get.find<SharedPreferences>().remove('name');
    setState(() {
      _isLoading = true;
    });
    if (_password != _confirmPassword) {
      Constant.showSnakeBarError(context, 'Passwords do not match');
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _email.trim(),
        password: _password.trim(),
      );

      if (!mounted) {
        return;
      }
      Constant.showSnakeBarSuccess(context, 'Registration successful!');
      await userCredential.user!
          .updateProfile(displayName: _username, photoURL: _phone);
      await userCredential.user!.reload();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'id': userCredential.user!.uid,
        'email': _email.trim(),
        'username': _username,
        'phoneNo': _phone,
        'password': _password.trim(),
        'createdAt': DateTime.now(),
      });
    } catch (e) {
      if (!mounted) {
        return;
      }
      Constant.showSnakeBarError(context, 'Failed to register: $e');
      setState(() {
        _isLoading = false;
      });
    }
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage('assets/image/bgWeb.jpg'),
                  fit: BoxFit.cover)),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
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
                              const SizedBox(height: 8),
                              Center(
                                  child: TextUtil(
                                text: "Signup",
                                weight: true,
                                size: 30,
                              )),
                              const SizedBox(height: 8),
                              TextUtil(
                                text: "Full Name",
                              ),
                              TextFormField(
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(fontSize: 15),
                                cursorColor: Colors.black54,
                                onSaved: (value) {
                                  _username = value!;
                                },
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  value = value!.trim();
                                  if (value.isEmpty) {
                                    return 'Please Enter Full Name !!';
                                  }
                                  List<String> words = value.split(' ');
                                  if (words.length < 2) {
                                    return 'The full name must contain at least a first name and a last name.';
                                  }
                                  for (String word in words) {
                                    if (word.length < 2) {
                                      return 'Each word must contain at least two letters.';
                                    }

                                    if (!RegExp(r'^[a-zA-Z\u0621-\u064A]+$')
                                        .hasMatch(word)) {
                                      return 'Name must contain only letters.';
                                    }
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.person,
                                    color: Colors.black54,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: Colors.white70)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextUtil(
                                text: "Email",
                              ),
                              TextFormField(
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(fontSize: 15),
                                cursorColor: Colors.black54,
                                onSaved: (value) {
                                  _email = value!;
                                },
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty || !value.contains('@')) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.mail,
                                    color: Colors.black54,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: Colors.white70)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextUtil(
                                text: "Phone Number",
                              ),
                              IntlPhoneField(
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(fontSize: 15),
                                cursorColor: Colors.black54,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.black54,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: Colors.white70)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                ),
                                initialCountryCode: 'AE',
                                dropdownTextStyle: TextStyle(
                                    color: Colors.black.withAlpha(204)),
                                pickerDialogStyle: PickerDialogStyle(
                                  searchFieldCursorColor: Colors.black54,
                                    backgroundColor: Colors.white,
                                     width: 350,
                                    countryNameStyle: TextStyle(
                                        color: Colors.black.withAlpha(204)),
                                    countryCodeStyle: TextStyle(
                                        color: Colors.black.withAlpha(175)),

                                    searchFieldInputDecoration: InputDecoration(
                                        labelText: 'Search',
                                        border:  OutlineInputBorder(borderSide:BorderSide(color: Colors.black54),borderRadius: BorderRadius.all(Radius.circular(30))),
                                        enabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.black54),borderRadius: BorderRadius.all(Radius.circular(30))),
                                        focusedBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.black87),borderRadius: BorderRadius.all(Radius.circular(30))),
                                        hintStyle: TextStyle(
                                            color:
                                                Colors.black..withAlpha(150)),
                                        labelStyle: TextStyle(
                                            color: Colors.black
                                                .withAlpha(150)))),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                disableLengthCheck: false,
                                onSaved: (phone) {
                                  _phone = phone!.completeNumber;
                                },
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
                                controller: password,
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _password = value!;
                                },
                                decoration: InputDecoration(
                                  suffixIcon: vis
                                      ? IconButton(
                                          onPressed: () {
                                            vis = !vis;
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.visibility,
                                            color: Colors.black54,
                                          ))
                                      : IconButton(
                                          onPressed: () {
                                            vis = !vis;
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.visibility_off,
                                            color: Colors.black54,
                                          )),
                                  focusedBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: Colors.white70)),
                                  enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextUtil(
                                text: "Confirm Password",
                              ),
                              TextFormField(
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(fontSize: 15),
                                cursorColor: Colors.black54,
                                controller: confirmPassword,
                                obscureText: vis1,
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  if (password.text.isNotEmpty) {
                                    if (password.text != confirmPassword.text) {
                                      return 'Passwords do not match !!';
                                    }
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _confirmPassword = value!;
                                },
                                decoration: InputDecoration(
                                  suffixIcon: vis1
                                      ? IconButton(
                                          onPressed: () {
                                            vis1 = !vis1;
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.visibility,
                                            color: Colors.black54,
                                          ))
                                      : IconButton(
                                          onPressed: () {
                                            vis1 = !vis1;
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.visibility_off,
                                            color: Colors.black54,
                                          )),
                                  focusedBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: Colors.white70)),
                                  enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const SizedBox(height: 8),
                              _isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : GestureDetector(
                                      onTap: () {
                                        _register();
                                        setState(() {});
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
                                          text: "SignUp",
                                          color: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .color,
                                        ),
                                      ),
                                    ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                      child: TextUtil(
                                    text: "Do you have a account ",
                                    size: 14,
                                    weight: true,
                                  )),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed('/login');
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
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
