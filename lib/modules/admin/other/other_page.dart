import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumer/modules/admin/admin_controller.dart';
import 'package:sumer/modules/admin/other/social_media_links/social_media_links.dart';
import 'package:sumer/util/text_util.dart';

import '../../../util/colors.dart';
import '../../../util/social_media.dart';
import '../../carousel/carousel.dart';
import 'carousel/edit_carousel.dart';

class OtherPage extends StatefulWidget {
  const OtherPage({super.key});

  @override
  State<OtherPage> createState() => _OtherPageState();
}

bool isUploading = false;
bool isError = false;
final adminController = Get.find<AdminController>();
bool withoutLogo = false;

class _OtherPageState extends State<OtherPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    withoutLogo = adminController.withoutLogo.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return SafeArea(
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey.shade200),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: BackButton(
                      color: Theme
                          .of(context)
                          .textTheme
                          .displayLarge!
                          .color,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: width / 1.1,
                    decoration: BoxDecoration(color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [ BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 3.0),
                      ),],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextUtil(
                            text: 'Carousel',
                            size: 23,
                          ),
                        ),
                        Divider(),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  Get.find<SharedPreferences>().remove(
                                      'imagesC');
                                  Get.find<SharedPreferences>().setStringList(
                                      'imagesC',
                                      Get
                                          .find<AdminController>()
                                          .listCarousel
                                          .first
                                          .images);
                                  Get.to(() => EditCarousel());
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                    WidgetStatePropertyAll(
                                        secondaryColor.withAlpha(204))),
                                label: Text(
                                  'Edit Carousel',
                                  style: TextStyle(color: Colors.white),
                                ),
                                icon: Icon(Icons.edit, color: Colors.white,),
                              ),
                            ],
                          ),
                        ),
                        const CustomCarousel(),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: width / 1.1,
                    decoration: BoxDecoration(color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),boxShadow: [ BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 3.0),
                      ),],),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextUtil(
                            text: 'LOGO',
                            size: 23,
                          ),
                        ),
                        Divider(),
                        const SizedBox(
                          height: 20,
                        ),
                        CheckboxListTile(value: withoutLogo, onChanged: (v) {
                          setState(() {
                            withoutLogo = v!;
                            adminController.updateSocialMediaLinksLogo(withoutLogo: withoutLogo);
                          });
                        },
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: secondaryColor,
                          title: TextUtil(
                            text: 'Appearance without logo just name.',
                            weight: false,),
                        ),
                        withoutLogo ? Column(
                          children: [
                            Divider(),
                           Obx(()=> TextUtil(text: adminController
                               .listCarousel.isNotEmpty ? adminController
                               .listCarousel.last.title : "LOGO" , size: 25,),),
                            SizedBox(height: 20,),
                            TextUtil(text: "Note: If you want to change it, you can form Edit Carousel" , size: 10,weight: true,),
                          ],
                        ) : Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: secondaryColor.withAlpha(50),
                                gradient: LinearGradient(
                                    colors: [
                                      secondaryColor.withAlpha(255),
                                      secondaryColor.withAlpha(128)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(
                                      () =>
                                  isUploading
                                      ? Center(
                                    child: CircularProgressIndicator(
                                      color: secondaryColor,
                                    ),
                                  )
                                      : InkWell(
                                    onTap: () async {
                                      if (!isUploading) {
                                        FilePickerResult? events =
                                        await FilePicker.platform.pickFiles(
                                          allowCompression: true,
                                          type: FileType.custom,
                                          allowedExtensions: [
                                            "jpeg",
                                            "jpg",
                                            "png",
                                            "webp",
                                          ],
                                        );
                                        if (events == null) {
                                          isUploading = false;
                                          return;
                                        }
                                        await acceptFile(events);
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: 80,
                                          child: Stack(
                                            children: [
                                              Image.network(
                                                adminController.logoImages
                                                    .value,

                                                errorBuilder: (
                                                    BuildContext context,
                                                    Object object,
                                                    StackTrace? stackTrace) =>
                                                    Image.asset(
                                                        'assets/image/logo.png'),
                                              ),
                                              adminController.logoImages.value
                                                  .isNotEmpty ? Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .all(8.0),
                                                  child: IconButton(
                                                      onPressed: () {
                                                        adminController
                                                            .logoImages
                                                            .value = '';
                                                        adminController
                                                            .socialMedia.first
                                                            .logo = '';
                                                        adminController
                                                            .updateSocialMediaLinks();
                                                        Get.find<
                                                            SharedPreferences>()
                                                            .remove('logo');
                                                        setState(() {});
                                                      }, icon: Icon(
                                                    Icons.close,
                                                    color: errorColor,
                                                  )),
                                                ),
                                              ) : SizedBox()
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            FontAwesomeIcons.camera,
                                            color: secondaryColor,
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Formats: .jpg and .png',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Text(
                                  isError
                                      ? 'Only images of up to 3mb and .png .jpg are allowed'
                                      : 'Support for a single or bulk upload. Maximum file size 3MB.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: isError
                                          ? Colors.redAccent
                                          : null),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Obx(
                                      () =>
                                  controller1.isLoading.value
                                      ? Center(
                                    child: CircularProgressIndicator(
                                      color: secondaryColor,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  )
                                      : SocialMedia(),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SocialMediaLinks(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> acceptFile(FilePickerResult event) async {
    setState(() {
      isUploading = true;
      isError = false;
    });

    final name = event.files.single.name;
    Uint8List? bytes = event.files.single.bytes;
    if (bytes!.length > 3 * 1024 * 1024) {
      setState(() {
        isUploading = false;
        isError = true;
      });
      return;
    }
    final ext = name
        .split('.')
        .last;
    if (ext != 'jpg' && ext != 'jpeg' && ext != 'png') {
      setState(() {
        isUploading = false;
        isError = true;
      });
      return;
    }
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() {
        isUploading = false;
      });
      return;
    }
    try {
      final storage = FirebaseStorage.instance;
      final ref = storage.ref().child('logo');
      final uploadTask = ref.putData(bytes);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      adminController.logoImages.value = downloadUrl;
      adminController.socialMedia.first.logo = downloadUrl;
      await adminController.updateSocialMediaLinks();
      Get.find<SharedPreferences>().remove('logo');
      Get.find<SharedPreferences>().setString('logo', downloadUrl);
      setState(() {
        isUploading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isUploading = false;
        isError = true;
      });
    }
    setState(() {});
  }
}
