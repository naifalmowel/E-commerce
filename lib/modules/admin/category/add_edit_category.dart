import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumer/model/category_model.dart';
import 'package:sumer/modules/category/controller/category_controller.dart';
import 'package:sumer/util/colors.dart';
import 'package:sumer/util/constant.dart';

import '../../../util/drop_drag_image.dart';
import '../../../util/text_util.dart';

class AddEditCategory extends StatefulWidget {
  const AddEditCategory({this.cat, super.key});

  final Category? cat;

  @override
  State<AddEditCategory> createState() => _AddEditCategoryState();
}

TextEditingController titleController = TextEditingController();
TextEditingController decController = TextEditingController();
String title = '';
String des = '';
final _formKey = GlobalKey<FormState>();

class _AddEditCategoryState extends State<AddEditCategory> {
  @override
  void initState() {
    if (widget.cat != null) {
      titleController.text = widget.cat!.name;
      decController.text = widget.cat!.description;
      Get.find<CategoryController>().tempImage.value = widget.cat!.image;
    } else {
      titleController.clear();
      decController.clear();
      Get.find<CategoryController>().tempImage.value = '';
    }
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
            color: Colors.grey.shade200),
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
                        final tempImage =
                          Get.find<CategoryController>().tempImage.value;
                      final catImage = widget.cat?.image;

                      if ((widget.cat == null && tempImage.isNotEmpty) ||
                          (widget.cat != null && catImage != tempImage)) {
                        deleteImage();
                      }
                        Get.back();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextUtil(
                    text: 'Add Category',
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
                          TextUtil(
                            text: 'Information',
                            color: Colors.black.withAlpha(230),
                            size: 20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextUtil(
                            text: 'Title',
                            color: Colors.black.withAlpha(204),
                            size: 15,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: titleController,
                            style:
                                TextStyle(color: Colors.black.withAlpha(204)),
                            cursorColor: secondaryColor,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onSaved: (value) {
                              title = value!;
                              setState(() {});
                            },
                            validator: (value) {
                              if ((value ?? '').isEmpty) {
                                return 'Enter Title Please !!';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextUtil(
                            text: 'Description',
                            color: Colors.black.withAlpha(204),
                            size: 15,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: decController,
                            style:
                                TextStyle(color: Colors.black.withAlpha(204)),
                            cursorColor: secondaryColor,
                            maxLines: 6,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onSaved: (value) {
                              des = value!;
                              setState(() {});
                            },
                            validator: (value) {
                              return null;
                            },
                          )
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
                            text: 'Image',
                            color: Colors.black.withAlpha(230),
                            size: 20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(
                            () => Get.find<CategoryController>()
                                    .tempImage
                                    .value
                                    .isEmpty
                                ? SizedBox(
                                    width: double.infinity,
                                    height: 250.0,
                                    child: Dropzone(
                                      onFileUploaded: (item) async {
                                        setState(() {
                                          Get.find<CategoryController>()
                                              .tempImage
                                              .value = item;
                                        });
                                      },
                                    ),
                                  )
                                : Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.black54)),
                                        child: Image.network(
                                            Get.find<CategoryController>()
                                                .tempImage
                                                .value,),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          if (widget.cat == null) {
                                            deleteImage();
                                          } else {
                                            Get.find<CategoryController>()
                                                .tempImage
                                                .value = '';
                                          }
                                        },
                                        child: const CircleAvatar(
                                          backgroundColor: Colors.redAccent,
                                          radius: 15,
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
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
                    height: 20,
                  ),
                  SizedBox(
                    width: width > 800 ? width / 2 : double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            final tempImage =
                                Get.find<CategoryController>().tempImage.value;
                            final catImage = widget.cat?.image;

                            if ((widget.cat == null && tempImage.isNotEmpty) ||
                                (widget.cat != null && catImage != tempImage)) {
                              deleteImage();
                            }
                            Get.back();
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.redAccent)),
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              'Close',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: widget.cat == null ? addNewCat : editCat,
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(secondaryColor)),
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              widget.cat == null
                                  ? 'Add Category'
                                  : 'Save Changes',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  void deleteImage({String? image}) async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child(image ?? Get.find<CategoryController>().tempImage.value);

      await ref.delete();
      Get.find<CategoryController>().tempImage.value = '';
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void addNewCat() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      bool result = await Get.find<CategoryController>().addNewCategory(
          title: title,
          description: des,
          image: Get.find<CategoryController>().tempImage.value);
      if (!mounted) {
        return;
      }
      if (result) {
        Get.back();
        Constant.showSnakeBarSuccess(context, 'Add $title Success !!');
      } else {
        Constant.showSnakeBarError(context, "Something Wrong !!");
      }
    }
  }

  void editCat() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      deleteImage(image: widget.cat!.image);
      bool result = await Get.find<CategoryController>().editCategory(
          catId: widget.cat!.id,
          title: title,
          description: des,
          image: Get.find<CategoryController>().tempImage.value);
      if (!mounted) {
        return;
      }
      if (result) {
        Get.back();
        Constant.showSnakeBarSuccess(context, 'Edit $title Success !!');
      } else {
        Constant.showSnakeBarError(context, "Something Wrong !!");
      }
    }
  }
}
