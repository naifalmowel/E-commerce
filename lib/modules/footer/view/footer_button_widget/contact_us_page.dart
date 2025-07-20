import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sumer/modules/footer/view/controller/footer_controller.dart';
import 'package:sumer/util/constant.dart';
import 'package:sumer/util/social_media.dart';
import '../../../../util/text_util.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<ContactUs> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '', _name = '', _subject = '', _body = '', _phone = '';
  bool vis = true;
  bool loading = false;
  final footerController = Get.find<FooterController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.grey.withOpacity(0.5),
              Colors.grey.withOpacity(0.2)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            alignment: Alignment.center,
            child: MediaQuery.of(context).size.width < 800
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: BackButton(
                              onPressed: () {
                                Get.back();
                              },
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: contactUsForm(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: myInfoForm(),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                  child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: BackButton(
                              onPressed: () {
                                Get.back();
                              },
                            )),
                        Row(
                          children: [
                            Expanded(flex: 2, child: myInfoForm()),
                            Expanded(flex: 3, child: contactUsForm()),
                          ],
                        ),
                      ],
                    ),
                )),
      ),
    );
  }

  Widget contactUsForm() {
    return Container(
      height: 700,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(15),
        color: Colors.black.withOpacity(0.1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
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
                        text:
                            "You can send your questions by filling out the form below and we will get back to you as soon as possible.",
                        weight: true,
                        size: 18,
                      )),
                      const SizedBox(
                        height: 16,
                      ),
                      TextUtil(
                        text: "Name *",
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border.fromBorderSide(
                                BorderSide(color: Colors.white)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            onSaved: (value) {
                              _name = value!;
                            },
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Name';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              fillColor: Colors.white,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextUtil(
                        text: "Email *",
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border.fromBorderSide(
                                BorderSide(color: Colors.white)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
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
                                color: Colors.white,
                              ),
                              fillColor: Colors.white,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextUtil(
                        text: "Phone Number *",
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border.fromBorderSide(
                                BorderSide(color: Colors.white)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: IntlPhoneField(
                          style: const TextStyle(color: Colors.white),
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            fillColor: Colors.white,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                          ),
                          initialCountryCode: 'AE',
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          disableLengthCheck: false,
                          onSaved: (phone) {
                            _phone = phone!.completeNumber;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextUtil(
                        text: "Subject *",
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border.fromBorderSide(
                                BorderSide(color: Colors.white)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            onSaved: (value) {
                              _subject = value!;
                            },
                            decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.subject,
                                color: Colors.white,
                              ),
                              fillColor: Colors.white,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextUtil(
                        text: "Body *",
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border.fromBorderSide(
                                BorderSide(color: Colors.white)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            maxLines: 4,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter The Body';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _body = value!;
                            },
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Obx(
                        () => footerController.loading.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : GestureDetector(
                                onTap: () async{
                                  if (!_formKey.currentState!.validate()) return;
                                  _formKey.currentState!.save();
                               bool result =  await  footerController.sendEmail(
                                      name: _name,
                                      email: _email,
                                      phone: _phone,
                                      subject: _subject,
                                      body: _body);
                                  if(!mounted)return;
                               if(result){
                                 Constant.showSnakeBarSuccess(context, 'The Email Has Been Sent Successfully !!');
                               }else{
                                 Constant.showSnakeBarError(context, 'An error occurred, please try again !!');
                               }
                                },
                                child: Container(
                                  height: 40,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30)),
                                  alignment: Alignment.center,
                                  child: TextUtil(
                                    text: "Send",
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Widget myInfoForm() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(15),
        color: Colors.black.withOpacity(0.1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent.withOpacity(0.5),
                      child: const Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                    ),
                    title: const Text('Email'),
                    subtitle: Text(
                      'naif.almowel@gmail.com',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent.withOpacity(0.8)),
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent.withOpacity(0.5),
                      child: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                    title: const Text('Phone'),
                    subtitle: Text(
                      '+971581936696',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent.withOpacity(0.8)),
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent.withOpacity(0.5),
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.white,
                      ),
                    ),
                    title: const Text('Address'),
                    subtitle: Text(
                      'United Arab Emirates - Dubai',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent.withOpacity(0.8)),
                    ),
                  ),
                  const Divider(
                    color: Colors.black54,
                    thickness: 1,
                  ),
                  Center(
                      child: TextUtil(
                    text: 'You can also follow & contact us through',
                  )),
                  const SizedBox(
                    height: 8,
                  ),
                  const Center(child: SocialMedia()),
                ],
              ),
            )),
      ),
    );
  }
}
