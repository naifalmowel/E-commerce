import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:reorderables/reorderables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumer/modules/admin/admin_controller.dart';
import 'package:sumer/util/constant.dart';

import '../../../../util/colors.dart';
import '../../../../util/drop_drag_images.dart';
import '../../../../util/text_util.dart';
import '../../../product/controller/product_controller.dart';
import '../../products/add_edit_products.dart';

class EditCarousel extends StatefulWidget {
  const EditCarousel({super.key});

  @override
  State<EditCarousel> createState() => _EditCarouselState();
}

class _EditCarouselState extends State<EditCarousel> {
  TextEditingController titleController = TextEditingController();
  TextEditingController connectUrlController = TextEditingController();
  String title = '';
  String connectUrl = '';
  bool showButton = false;

  @override
  void initState() {
    Get.find<AdminController>().imagesUrl.value =
        Get.find<AdminController>().listCarousel.first.images;
    titleController.text = Get.find<AdminController>().listCarousel.first.title;
    connectUrlController.text = Get.find<AdminController>().listCarousel.first.connectUrl;
    showButton = Get.find<AdminController>().listCarousel.first.showButton;
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: BackButton(
                      color: Theme.of(context).textTheme.displayLarge!.color,
                      onPressed: () {
                        final tempListImage =
                            Get.find<AdminController>().imagesUrl;

                        final proImages = Get.find<SharedPreferences>()
                                .getStringList('imagesC') ??
                            [];

                        for (var image in tempListImage) {
                          if (!proImages.contains(image)) {
                            deleteImage(image);
                          }
                        }
                        Get.back();
                      },
                    ),
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
                          TextUtil(
                            text: 'Name Of Company',
                            color: Colors.black.withOpacity(0.9),
                            size: 20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          textFieldWidget(
                              title: 'Title',
                              controller: titleController,
                              value: title,
                              validator: false),
                          const SizedBox(
                            height: 10,
                          ),
                          SwitchListTile(
                            value: showButton,
                            activeColor: secondaryColor,
                            onChanged: (value) {
                              setState(() {
                                showButton = !showButton;
                              });
                            },
                            title: Text(
                              'Show "Connect Us" Button',
                              style: TextStyle(color: Colors.black, fontSize: 17),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        showButton?  textFieldWidget(
                              title: 'Connect Us URL',
                              controller: connectUrlController,
                              value: connectUrl,
                              validator: false):SizedBox(),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
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
                          TextUtil(
                            text: 'Images',
                            color: Colors.black.withOpacity(0.9),
                            size: 20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(
                            () => Get.find<ProductController>().isUploading.value
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: secondaryColor,
                                    ),
                                  )
                                : Get.find<AdminController>().imagesUrl.isEmpty
                                    ? SizedBox(
                                        width: double.infinity,
                                        height: 250.0,
                                        child: DropzoneForImages(
                                          onFileUploaded: (item) async {
                                            setState(() {
                                              Get.find<AdminController>()
                                                  .imagesUrl
                                                  .add(item);
                                            });
                                          },
                                          carousel: true,
                                        ),
                                      )
                                    : Get.find<ProductController>()
                                            .isUploading
                                            .value
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              color: secondaryColor,
                                            ),
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  '1. You can rearrange the images by long pressing on the image and then moving it.',
                                                  style: TextStyle(
                                                      color: Colors.black54),
                                                ),
                                              ),
                                              PrimaryScrollController(
                                                controller: scrollController,
                                                child: ReorderableWrap(
                                                  spacing: 8.0,
                                                  runSpacing: 4.0,
                                                  onReorder:
                                                      (oldIndex, newIndex) {
                                                    setState(() {
                                                      final item = Get.find<
                                                              AdminController>()
                                                          .imagesUrl
                                                          .removeAt(oldIndex);
                                                      Get.find<AdminController>()
                                                          .imagesUrl
                                                          .insert(newIndex, item);
                                                    });
                                                  },
                                                  children:
                                                      Get.find<AdminController>()
                                                          .imagesUrl
                                                          .asMap()
                                                          .entries
                                                          .map((entry) {
                                                    int index = entry.key;
                                                    String url = entry.value;

                                                    return buildImageWidget(
                                                        index, url);
                                                  }).toList(),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              DropzoneForImages(
                                                onFileUploaded: (item) async {
                                                  setState(() {
                                                    Get.find<AdminController>()
                                                        .imagesUrl
                                                        .add(item);
                                                  });
                                                },
                                                carousel: true,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: secondaryColor
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        'Add More Image',
                                                        style: TextStyle(
                                                            color: Colors.white),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Icon(
                                                        Icons.add_photo_alternate,
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Obx(
                        () => Get.find<AdminController>().isLoadingC.value
                        ? Center(
                        child: CircularProgressIndicator(
                          color: secondaryColor,
                        ))
                        :  SizedBox(
                      width: width > 800 ? width / 2 : double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              final tempListImage =
                                  Get.find<AdminController>()
                                      .imagesUrl;

                              final proImages =
                                  Get.find<SharedPreferences>()
                                      .getStringList('imagesC') ??
                                      [];

                              for (var image in tempListImage) {
                                if (!proImages.contains(image)) {
                                  deleteImage(image);
                                }
                              }
                              Get.back();
                            },
                            style: const ButtonStyle(
                                backgroundColor:
                                WidgetStatePropertyAll(
                                    Colors.redAccent)),
                            child: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                'Close',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final tempListImage =
                                  Get.find<AdminController>()
                                      .imagesUrl;

                              final proImages =
                                  Get.find<SharedPreferences>()
                                      .getStringList('imagesC') ??
                                      [];
                              if (tempListImage.isEmpty) {
                                for (var image in proImages) {
                                  deleteImage(image);
                                }
                              } else {
                                for (var image in proImages) {
                                  if (!tempListImage
                                      .contains(image)) {
                                    deleteImage(image);
                                  }
                                }
                              }
                              final result = await Get.find<
                                  AdminController>()
                                  .updateCarousel(
                                  title: titleController.text,
                                  images:
                                  Get.find<AdminController>()
                                      .imagesUrl,
                                  showButton: showButton, connectUrl: connectUrlController.text);
                              if (!context.mounted) {
                                return;
                              }
                              if (result) {
                                Constant.showSnakeBarSuccess(
                                    context, 'Edit Success !!');
                                await Get.find<AdminController>()
                                    .getCarousel();
                                Get.back();
                              } else {
                                Constant.showSnakeBarError(
                                    context, 'Something Wrong !!');
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                WidgetStatePropertyAll(
                                    secondaryColor)),
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                'Save Changes',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                ],
              ),
            ),
          )),
    ));
  }

  Widget buildImageWidget(int index, String url) {
    return Container(
      width: 200,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black54),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Image.network(
            url,

              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Image.asset('assets/image/noImage.jpg');
              }
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  Get.find<AdminController>().imagesUrl.remove(url);
                  setState(() {});
                },
                child: Icon(
                  FontAwesomeIcons.circleXmark,
                  color: Colors.redAccent,
                )),
          )
        ],
      ),
    );
  }

  Widget textFieldWidget({
    required String title,
    required TextEditingController controller,
    required String value,
    required bool validator,
    bool? isNum,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextUtil(
          text: title,
          color: Colors.black.withOpacity(0.8),
          size: 15,
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: controller,
          style: TextStyle(color: Colors.black.withOpacity(0.8)),
          cursorColor: secondaryColor,
          minLines: 1,
          maxLines: title == 'Description' ? null : 1,
          keyboardType: isNum ?? false
              ? TextInputType.numberWithOptions(decimal: true)
              : null,
          inputFormatters: isNum ?? false
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ]
              : null,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onChanged: (value1) {
            value = value1;
            setState(() {});
          },
          validator: (value) {
            if (validator) {
              if ((value ?? '').trim().isEmpty) {
                return 'Enter $title Please !!';
              }
            } else {
              return null;
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  void deleteImage(String url) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child(url);
      await ref.delete();
      Get.find<ProductController>().imagesUrl.remove(url);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
