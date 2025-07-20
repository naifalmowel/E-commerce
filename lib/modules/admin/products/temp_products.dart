import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumer/model/product_model.dart';
import 'package:sumer/modules/admin/products/add_edit_products.dart';
import 'package:sumer/modules/product/controller/product_controller.dart';
import 'package:sumer/util/constant.dart';
import 'package:sumer/util/text_util.dart';

import '../../../util/colors.dart';
import '../../product/view/product_details.dart';

class TempProducts extends StatefulWidget {
  const TempProducts({super.key, required this.product});

  final Product product;

  @override
  State<TempProducts> createState() => _TempProductsState();
}

class _TempProductsState extends State<TempProducts> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      child: Row(
        children: [
          Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Row(
                children: [
                  Image.network(
                    widget.product.image,
                    width: 75,
                    height: 75,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Image.asset('assets/image/noImage.jpg');
                    },
                  ),
                  SizedBox(width: 8,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.brand,
                          maxLines: 2,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.product.model,
                          style: const TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                "${widget.product.price} AED",
                style: const TextStyle(
                  color: Colors.black,
                ),
              )),
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widget.product.active
                      ? Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        )
                      : Icon(
                          Icons.do_disturb_alt,
                          color: Colors.redAccent,
                        ),
                ],
              )),
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widget.product.available
                      ? TextUtil(text: 'In Stock', color: Colors.green,)
                      :(widget.product.currentQty??0)==0?TextUtil(text: 'Out of Stock', color: Colors.redAccent,): TextUtil(text: '${widget.product.currentQty} Items',),
                ],
              )),
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: PopupMenuButton(
                color: Colors.white,
                tooltip: "Action",
                icon: const Icon(Icons.more_vert_rounded),
                iconColor: Colors.black,
                itemBuilder: (BuildContext context) {
                  return <PopupMenuItem<Widget>>[
                    PopupMenuItem<Widget>(
                      onTap: () {
                        Get.to(
                            () => ProductDetailScreen(product: widget.product, view: true,));
                      },
                      child: Row(
                        children: [
                          Icon(Icons.remove_red_eye, color: secondaryColor),
                          const SizedBox(
                            width: 5,
                          ),
                          Text("View", style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                    PopupMenuItem<Widget>(
                      onTap: () {
                        Get.find<SharedPreferences>().remove('images');
                        Get.find<SharedPreferences>()
                            .setStringList('images', widget.product.images);
                        Get.to(() => AddEditProducts(product: widget.product));
                      },
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: secondaryColor),
                          const SizedBox(
                            width: 5,
                          ),
                          Text("Edit", style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                    PopupMenuItem<Widget>(
                      onTap: () {
                        Constant.confirmDialog(context, 'Delete Product',
                            () async {
                          await Get.find<ProductController>().deleteProduct(
                              proId: widget.product.id,
                              images: widget.product.images);
                          Get.back();
                        });
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.delete, color: Colors.redAccent),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Delete",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ];
                },
              )),
        ],
      ),
    );
  }
}
