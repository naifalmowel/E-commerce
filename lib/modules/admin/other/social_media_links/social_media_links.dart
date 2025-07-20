import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sumer/modules/admin/admin_controller.dart';
import 'package:sumer/util/colors.dart';
import 'package:sumer/util/constant.dart';

import '../../../../util/text_util.dart';

class SocialMediaLinks extends StatefulWidget {
  const SocialMediaLinks({super.key});

  @override
  State<SocialMediaLinks> createState() => _SocialMediaLinksState();
}

TextEditingController facebookController = TextEditingController();
TextEditingController instagramController = TextEditingController();
TextEditingController whatsappController = TextEditingController();
TextEditingController tiktokController = TextEditingController();

final adminController = Get.find<AdminController>();
final _formKey = GlobalKey<FormState>();

class _SocialMediaLinksState extends State<SocialMediaLinks> {
  @override
  void initState() {
    facebookController.text = adminController.socialMedia.first.facebookUrl;
    instagramController.text = adminController.socialMedia.first.instagramUrl;
    whatsappController.text = adminController.socialMedia.first.whatsUrl;
    tiktokController.text = adminController.socialMedia.first.tiktokUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width/1.1,
      decoration: BoxDecoration(color: Colors.white , borderRadius: BorderRadius.all(Radius.circular(20)),boxShadow: [ BoxShadow(
        color: Colors.black26,
        blurRadius: 10.0,
        offset: Offset(0.0, 3.0),
      ),],),
      height: 600,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextUtil(
                  text: 'Social Media Links',
                  size: 23,
                ),
              ),
              Divider(),
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: facebookController,
                            style:
                                TextStyle(color: Colors.black.withAlpha(204)),
                            cursorColor: secondaryColor,
                            decoration: InputDecoration(
                                suffixIcon: Switch(
                                    value: adminController
                                        .socialMedia.first.facebook,
                                    activeColor: secondaryColor,
                                    onChanged: (value) {
                                      setState(() {
                                        adminController
                                                .socialMedia.first.facebook =
                                            !adminController
                                                .socialMedia.first.facebook;
                                        adminController
                                            .updateSocialMediaLinks();
                                      });
                                    }),
                                labelText: 'Facebook',
                                labelStyle: TextStyle(color: secondaryColor),
                                icon: const Icon(FontAwesomeIcons.facebook),
                                iconColor: Colors.black,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              final urlPattern =
                                  r"^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$";
                              final urlRegExp = RegExp(urlPattern);
                              if (value!.isEmpty) {
                                return null;
                              }
                              if (!urlRegExp.hasMatch(value)) {
                                return 'Please enter a valid URL';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              controller: instagramController,
                              style: TextStyle(
                                  color: Colors.black.withAlpha(204)),
                              cursorColor: secondaryColor,
                              decoration: InputDecoration(
                                  suffixIcon: Switch(
                                      value: adminController
                                          .socialMedia.first.instagram,
                                      activeColor: secondaryColor,
                                      onChanged: (value) {
                                        setState(() {
                                          adminController
                                                  .socialMedia.first.instagram =
                                              !adminController
                                                  .socialMedia.first.instagram;
                                          adminController
                                              .updateSocialMediaLinks();
                                        });
                                      }),
                                  labelText: 'Instagram',
                                  labelStyle: TextStyle(color: secondaryColor),
                                  iconColor: Colors.black,
                                  icon: const Icon(FontAwesomeIcons.instagram),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                final urlPattern =
                                    r"^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$";
                                final urlRegExp = RegExp(urlPattern);
                                if (value!.isEmpty) {
                                  return null;
                                }
                                if (!urlRegExp.hasMatch(value)) {
                                  return 'Please enter a valid URL';
                                }
                                return null;
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              controller: whatsappController,
                              style: TextStyle(
                                  color: Colors.black.withAlpha(204)),
                              cursorColor: secondaryColor,
                              decoration: InputDecoration(
                                  suffixIcon: Switch(
                                      value: adminController
                                          .socialMedia.first.whats,
                                      activeColor: secondaryColor,
                                      onChanged: (value) {
                                        setState(() {
                                          adminController
                                                  .socialMedia.first.whats =
                                              !adminController
                                                  .socialMedia.first.whats;
                                          adminController
                                              .updateSocialMediaLinks();
                                        });
                                      }),
                                  labelText: 'WhatsApp',
                                  labelStyle: TextStyle(color: secondaryColor),
                                  iconColor: Colors.black,
                                  icon: const Icon(FontAwesomeIcons.whatsapp),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                final urlPattern =
                                    r"^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$";
                                final urlRegExp = RegExp(urlPattern);
                                if (value!.isEmpty) {
                                  return null;
                                }
                                if (!urlRegExp.hasMatch(value)) {
                                  return 'Please enter a valid URL';
                                }
                                return null;
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              controller: tiktokController,
                              style: TextStyle(
                                  color: Colors.black.withAlpha(204)),
                              cursorColor: secondaryColor,
                              decoration: InputDecoration(
                                  suffixIcon: Switch(
                                      value: adminController
                                          .socialMedia.first.tiktok,
                                      activeColor: secondaryColor,
                                      onChanged: (value) {
                                        setState(() {
                                          adminController
                                                  .socialMedia.first.tiktok =
                                              !adminController
                                                  .socialMedia.first.tiktok;
                                          adminController
                                              .updateSocialMediaLinks();
                                        });
                                      }),
                                  labelText: 'Tiktok',
                                  labelStyle: TextStyle(color: secondaryColor),
                                  iconColor: Colors.black,
                                  icon: const Icon(FontAwesomeIcons.tiktok),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                final urlPattern =
                                    r"^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$";
                                final urlRegExp = RegExp(urlPattern);
                                if (value!.isEmpty) {
                                  return null;
                                }
                                if (!urlRegExp.hasMatch(value)) {
                                  return 'Please enter a valid URL';
                                }
                                return null;
                              }),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
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
                                    backgroundColor: WidgetStatePropertyAll(
                                        Colors.redAccent)),
                                child: Text(
                                  'Close',
                                  style: TextStyle(
                                      color: Colors.white),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    adminController.socialMedia.first
                                        .facebookUrl = facebookController.text;
                                    adminController
                                            .socialMedia.first.instagramUrl =
                                        instagramController.text;
                                    adminController.socialMedia.first.whatsUrl =
                                        whatsappController.text;
                                    adminController.socialMedia.first
                                        .tiktokUrl = tiktokController.text;
                                    await adminController
                                        .updateSocialMediaLinks();
                                    Constant.showSnakeBarSuccess(
                                        context, 'Edit Success !!');
                                  }
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll(secondaryColor)),
                                child: Text(
                                  'Save Changes',
                                  style: TextStyle(
                                      color: Colors.white,),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
