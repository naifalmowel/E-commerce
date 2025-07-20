import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sumer/modules/admin/admin_controller.dart';

import '../../../model/category_model.dart';
import '../../../util/colors.dart';
import '../../../util/constant.dart';
import '../../../util/text_util.dart';

class AddUsers extends StatefulWidget {
  const AddUsers({super.key, this.cat});

  final Category? cat;

  @override
  State<AddUsers> createState() => _AddUsersState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String _email = '',
    _password = '',
    _confirmPassword = '',
    _username = '',
    _phone = '';
bool vis = true;
final adminController = Get.find<AdminController>();

class _AddUsersState extends State<AddUsers> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.grey.withOpacity(0.5),
              Colors.grey.withOpacity(0.2)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: BackButton(
                      color: Theme.of(context).textTheme.displayLarge!.color,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextUtil(
                    text: 'Add Users',
                    size: 23,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: width > 800 ? width / 2 : double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          TextUtil(
                            text: "Full Name",
                            color: Colors.black.withOpacity(0.8),
                            size: 15,
                          ),
                          TextFormField(
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.8)),
                            cursorColor: secondaryColor,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onSaved: (value) {
                              _username = value!;
                            },
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Full Name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),
                          TextUtil(
                            text: "Email",
                            color: Colors.black.withOpacity(0.8),
                            size: 15,
                          ),
                          TextFormField(
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.8)),
                            cursorColor: secondaryColor,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
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
                          ),
                          const SizedBox(height: 8),
                          TextUtil(
                            text: "Phone Number",
                            color: Colors.black.withOpacity(0.8),
                            size: 15,
                          ),
                          IntlPhoneField(
                            keyboardType: TextInputType.phone,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.8)),
                            cursorColor: secondaryColor,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            initialCountryCode: 'AE',
                            dropdownTextStyle:
                                TextStyle(color: Colors.black.withOpacity(0.8)),
                            pickerDialogStyle: PickerDialogStyle(
                                countryNameStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.8)),
                                countryCodeStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.7)),
                                searchFieldInputDecoration: InputDecoration(

                                  labelText: 'Search',
                                    hintStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.6)),
                                    labelStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.6)))),
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
                            color: Colors.black.withOpacity(0.8),
                            size: 15,
                          ),
                          TextFormField(
                            obscureText: vis,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _password = value!;
                            },
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.8)),
                            cursorColor: secondaryColor,
                            decoration: InputDecoration(
                                suffixIcon: vis
                                    ? IconButton(
                                        onPressed: () {
                                          vis = !vis;
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.visibility,
                                          color: secondaryColor,
                                        ))
                                    : IconButton(
                                        onPressed: () {
                                          vis = !vis;
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.visibility_off,
                                          color: secondaryColor,
                                        )),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          const SizedBox(height: 8),
                          TextUtil(
                            text: "Confirm Password",
                            color: Colors.black.withOpacity(0.8),
                            size: 15,
                          ),
                          TextFormField(
                            obscureText: vis,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _confirmPassword = value!;
                            },
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.8)),
                            cursorColor: secondaryColor,
                            decoration: InputDecoration(
                                suffixIcon: vis
                                    ? IconButton(
                                        onPressed: () {
                                          vis = !vis;
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.visibility,
                                          color: secondaryColor,
                                        ))
                                    : IconButton(
                                        onPressed: () {
                                          vis = !vis;
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.visibility_off,
                                          color: secondaryColor,
                                        )),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: width > 800 ? width / 2 : double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.redAccent)),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Close',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        Obx(
                          () => adminController.isLoadingUser.value
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  onPressed: () async {
                                    if (!_formKey.currentState!.validate()) return;
                                    _formKey.currentState!.save();
                                    if (_phone.length < 10) {
                                      Constant.showSnakeBarError(context,
                                          'Something Wrong in Phone Number !!');
                                      return;
                                    }
                                    if (_password != _confirmPassword) {
                                      Constant.showSnakeBarError(
                                          context, 'Passwords do not match');
                                      return;
                                    }
                                    bool result =
                                        await adminController.addNewUser(
                                            email: _email,
                                            password: _password,
                                            username: _username,
                                            phone: _phone);
                                    if (!context.mounted) {
                                      return;
                                    }
                                    if (result) {
                                      Get.back();
                                      Constant.showSnakeBarSuccess(
                                          context, 'Add $_username Success !!');
                                    } else {
                                      Constant.showSnakeBarError(
                                          context, "Something Wrong !!");
                                    }
                                    setState(() {});
                                  },
                                  style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          secondaryColor)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Add User',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
