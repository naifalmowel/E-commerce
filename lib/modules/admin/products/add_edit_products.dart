import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:reorderables/reorderables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumer/model/product_model.dart';
import 'package:sumer/modules/category/controller/category_controller.dart';
import 'package:sumer/modules/product/controller/product_controller.dart';
import 'package:sumer/util/colors.dart';
import 'package:sumer/util/constant.dart';

import '../../../global/custom_drop_down_category.dart';
import '../../../util/drop_drag_images.dart';
import '../../../util/text_util.dart';

class AddEditProducts extends StatefulWidget {
  const AddEditProducts({this.product, super.key});

  final Product? product;

  @override
  State<AddEditProducts> createState() => _AddEditProductsState();
}

TextEditingController brandController = TextEditingController();
TextEditingController modelController = TextEditingController();
TextEditingController sizeController = TextEditingController();
TextEditingController decController = TextEditingController();
TextEditingController priceController = TextEditingController();
TextEditingController offerPriceController = TextEditingController();
TextEditingController qtyController = TextEditingController();
String brand = '';
String model = '';
String size = '';
String des = '';
String price = '';
String offerPrice = '';
String qty = '';
String catId = '';
String selectV = 'available';
final _formKey = GlobalKey<FormState>();
final scrollController = ScrollController();
TextEditingController searchController = TextEditingController();
List<String> oldImages = [];
bool active = true;

class _AddEditProductsState extends State<AddEditProducts> {
  @override
  void initState() {
    if (widget.product != null) {
      brandController.text = widget.product!.brand;
      modelController.text = widget.product!.model;
      sizeController.text = widget.product!.size;
      decController.text = widget.product!.dis;
      priceController.text = widget.product!.price.toString();
      offerPriceController.text = widget.product!.offerPrice.toString();
      qtyController.text = (widget.product!.currentQty ?? 0).toString();
      catId = widget.product!.catId;
      selectV = widget.product!.available ? 'available' : 'limited';
      Get.find<ProductController>().imagesUrl.value =
          Get.find<SharedPreferences>().getStringList('images') ?? [];
      active = widget.product!.active;
    } else {
      brandController.clear();
      modelController.clear();
      sizeController.clear();
      decController.clear();
      priceController.clear();
      offerPriceController.clear();
      qtyController.clear();
      catId = '';
      Get.find<ProductController>().imagesUrl.value = [];
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
                        final tempListImage =
                            Get.find<ProductController>().imagesUrl;

                        final proImages = Get.find<SharedPreferences>()
                                .getStringList('images') ??
                            [];

                        if (widget.product == null) {
                          if (tempListImage.isNotEmpty) {
                            for (var image in tempListImage) {
                              deleteImage(image);
                            }
                          }
                        } else {
                          for (var image in tempListImage) {
                            if (!proImages.contains(image)) {
                              deleteImage(image);
                            }
                          }
                        }
                        Get.back();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextUtil(
                    text: 'Add Product',
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
                            color: Colors.black.withOpacity(0.9),
                            size: 20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextUtil(
                            text: "Active",
                            color: Colors.black.withOpacity(0.8),
                            size: 15,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SwitchListTile(
                              value: active,
                              secondary: active
                                  ? Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      Icons.do_disturb_rounded,
                                      color: Colors.redAccent,
                                    ),
                              title: Text(
                                "Activate the product to appear in the store.",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              activeColor: secondaryColor,
                              onChanged: (value) {
                                active = !active;
                                setState(() {});
                              }),
                          const SizedBox(
                            height: 8,
                          ),
                          textFieldWidget(
                              title: 'Brand/Name *',
                              controller: brandController,
                              value: brand,
                              validator: true),
                          textFieldWidget(
                              title: 'Model',
                              controller: modelController,
                              value: model,
                              validator: false),
                          textFieldWidget(
                              title: 'Size',
                              controller: sizeController,
                              value: size,
                              validator: false),
                          textFieldWidget(
                              title: 'Description',
                              controller: decController,
                              value: des,
                              validator: false),
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
                            color: Colors.black.withOpacity(0.9),
                            size: 20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(
                            () => Get.find<ProductController>()
                                    .isUploading
                                    .value
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: secondaryColor,
                                    ),
                                  )
                                : Get.find<ProductController>()
                                        .imagesUrl
                                        .isEmpty
                                    ? SizedBox(
                                        width: double.infinity,
                                        height: 250.0,
                                        child: DropzoneForImages(
                                          onFileUploaded: (item) async {
                                            setState(() {
                                              Get.find<ProductController>()
                                                  .imagesUrl
                                                  .add(item);
                                            });
                                          },
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '1. You can rearrange the images by long pressing on the image and then moving it.',
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '2. The bigger image is the main Image.',
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ),
                                          PrimaryScrollController(
                                            controller: scrollController,
                                            child: ReorderableWrap(
                                              spacing: 8.0,
                                              runSpacing: 4.0,
                                              onReorder: (oldIndex, newIndex) {
                                                setState(() {
                                                  final item = Get.find<
                                                          ProductController>()
                                                      .imagesUrl
                                                      .removeAt(oldIndex);
                                                  Get.find<ProductController>()
                                                      .imagesUrl
                                                      .insert(newIndex, item);
                                                });
                                              },
                                              children:
                                                  Get.find<ProductController>()
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
                                                Get.find<ProductController>()
                                                    .imagesUrl
                                                    .add(item);
                                              });
                                            },
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
                            text: 'Price',
                            color: Colors.black.withOpacity(0.9),
                            size: 20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textFieldWidget(
                                  title: 'Regular Price',
                                  controller: priceController,
                                  value: price,
                                  isNum: true,
                                  validator: false),
                              textFieldWidget(
                                  title: 'Offer Price',
                                  controller: offerPriceController,
                                  value: offerPrice,
                                  isNum: true,
                                  validator: false),
                            ],
                          ),
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
                            text: 'Inventory',
                            color: Colors.black.withOpacity(0.9),
                            size: 20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          RadioListTile<String>(
                            shape: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blueAccent),
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding: const EdgeInsets.all(8),
                            title: Text(
                              'This product is always available',
                              style: const TextStyle(color: Colors.black),
                            ),
                            value: 'available',
                            groupValue: selectV,
                            activeColor: secondaryColor.withOpacity(0.8),
                            onChanged: (String? value) {
                              setState(() {
                                selectV = value!;
                              });
                            },
                          ),
                          RadioListTile<String>(
                            shape: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blueAccent),
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding: const EdgeInsets.all(8),
                            title: Text(
                              'This product has limited quantity',
                              style: const TextStyle(color: Colors.black),
                            ),
                            value: 'limited',
                            groupValue: selectV,
                            activeColor: Colors.blueAccent.withOpacity(0.8),
                            onChanged: (String? value) {
                              setState(() {
                                selectV = value!;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          selectV.contains('limited')
                              ? textFieldWidget(
                                  title: 'Product Quantity',
                                  controller: qtyController,
                                  value: qty,
                                  isNum: true,
                                  validator: false,
                                )
                              : SizedBox(),
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
                            text: 'Category',
                            color: Colors.black.withOpacity(0.9),
                            size: 20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomDropDownButtonCategory(
                            title: 'Category',
                            hint: 'Category',
                            items: Get.find<CategoryController>().allCategories,
                            onChange: (value) {
                              catId = value!;
                            },
                            value: catId == '' ? null : catId,
                            width: double.infinity,
                            height: 50,
                            textEditingController: searchController,
                          ),
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
                  SizedBox(
                    width: width > 800 ? width / 2 : double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            final tempListImage =
                                Get.find<ProductController>().imagesUrl;

                            final proImages = Get.find<SharedPreferences>()
                                    .getStringList('images') ??
                                [];

                            if (widget.product == null) {
                              if (tempListImage.isNotEmpty) {
                                for (var image in tempListImage) {
                                  deleteImage(image);
                                }
                              }
                            } else {
                              for (var image in tempListImage) {
                                if (!proImages.contains(image)) {
                                  deleteImage(image);
                                }
                              }
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
                        Obx(
                          () => Get.find<ProductController>().isLoading.value
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: secondaryColor,
                                ))
                              : ElevatedButton(
                                  onPressed: widget.product == null
                                      ? addNewProduct
                                      : editProduct,
                                  style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          secondaryColor)),
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      widget.product == null
                                          ? 'Add Product'
                                          : 'Save Changes',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                ),
                        )
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

  Widget buildImageWidget(int index, String url) {
    return Container(
      width: index == 0 ? 200 : 100,
      height: index == 0 ? 200 : 100,
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  if (widget.product == null) {
                    deleteImage(url);
                  } else {
                    Get.find<ProductController>().imagesUrl.remove(url);
                  }
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

  void deleteImage(String url) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child(url);
      await ref.delete();
      Get.find<ProductController>().imagesUrl.remove(url);
    } catch (e) {
      debugPrint(e.toString());
    }
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

  void addNewProduct() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (catId == '') {
        Constant.showSnakeBarError(context, 'Select Category Please !!');
        return;
      }
      double price1 = 0.0;
      double offerPrice1 = 0.0;
      if (priceController.text.isEmpty && offerPriceController.text.isEmpty) {
        price1 = 0.0;
        offerPrice1 = 0.0;
      } else {
        if (priceController.text.isEmpty &&
            offerPriceController.text.isNotEmpty) {
          price1 =
              offerPrice1 = double.tryParse(offerPriceController.text) ?? 0.0;
        } else if (priceController.text.isNotEmpty &&
            offerPriceController.text.isEmpty) {
          price1 = offerPrice1 = double.tryParse(priceController.text) ?? 0.0;
        } else if (priceController.text.isNotEmpty &&
            offerPriceController.text.isNotEmpty) {
          if ((double.tryParse(priceController.text) ?? 0.0) <
              (double.tryParse(offerPriceController.text) ?? 0.0)) {
            price1 =
                offerPrice1 = double.tryParse(offerPriceController.text) ?? 0.0;
          } else {
            price1 = double.tryParse(priceController.text) ?? 0.0;
            offerPrice1 = double.tryParse(offerPriceController.text) ?? 0.0;
          }
        }
      }
      bool result = await Get.find<ProductController>().addNewProduct(
          brand: brandController.text,
          dis: decController.text,
          model: modelController.text,
          size: sizeController.text,
          catId1: catId,
          currentQty: int.tryParse(qtyController.text) ?? 0,
          price: price1,
          offerPrice: offerPrice1,
          available: selectV.contains('available'),
          images: Get.find<ProductController>().imagesUrl, active: active);
      if (!mounted) {
        return;
      }
      if (result) {
        Get.back();
        Constant.showSnakeBarSuccess(context, 'Add New Product !!');
      } else {
        Constant.showSnakeBarError(context, 'Something Wrong !!');
      }
    }
  }

  void editProduct() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (catId == '') {
        Constant.showSnakeBarError(context, 'Select Category Please !!');
        return;
      }
      double price1 = 0.0;
      double offerPrice1 = 0.0;
      if (priceController.text.isEmpty && offerPriceController.text.isEmpty) {
        price1 = 0.0;
        offerPrice1 = 0.0;
      } else {
        if (priceController.text.isEmpty &&
            offerPriceController.text.isNotEmpty) {
          price1 =
              offerPrice1 = double.tryParse(offerPriceController.text) ?? 0.0;
        } else if (priceController.text.isNotEmpty &&
            offerPriceController.text.isEmpty) {
          price1 = offerPrice1 = double.tryParse(priceController.text) ?? 0.0;
        } else if (priceController.text.isNotEmpty &&
            offerPriceController.text.isNotEmpty) {
          if ((double.tryParse(priceController.text) ?? 0.0) <
              (double.tryParse(offerPriceController.text) ?? 0.0)) {
            price1 =
                offerPrice1 = double.tryParse(offerPriceController.text) ?? 0.0;
          } else {
            price1 = double.tryParse(priceController.text) ?? 0.0;
            offerPrice1 = double.tryParse(offerPriceController.text) ?? 0.0;
          }
        }
      }
      final proImages =
          Get.find<SharedPreferences>().getStringList('images') ?? [];
      for (var image in proImages) {
        if (!Get.find<ProductController>().imagesUrl.contains(image)) {
          deleteImage(image);
        }
      }
      bool result = await Get.find<ProductController>().editProduct(
        id: widget.product!.id,
        brand: brandController.text,
        dis: decController.text,
        model: modelController.text,
        size: sizeController.text,
        catId1: catId,
        currentQty: int.tryParse(qtyController.text) ?? 0,
        price: price1,
        offerPrice: offerPrice1,
        available: selectV.contains('available'),
        images: Get.find<ProductController>().imagesUrl, active: active,
      );
      if (!mounted) {
        return;
      }
      if (result) {
        Get.back();
        Constant.showSnakeBarSuccess(context, 'Edit Product Success!!');
      } else {
        Constant.showSnakeBarError(context, 'Something Wrong !!');
      }
    }
  }
}
