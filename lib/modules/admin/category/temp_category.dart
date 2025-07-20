import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumer/modules/category/controller/category_controller.dart';
import 'package:sumer/modules/product/controller/product_controller.dart';
import 'package:sumer/util/constant.dart';

import '../../../model/category_model.dart';
import '../../../util/colors.dart';
import 'add_edit_category.dart';

class TempCategory extends StatefulWidget {
  const TempCategory({super.key, required this.cat});

  final Category cat;

  @override
  State<TempCategory> createState() => _TempCategoryState();
}

class _TempCategoryState extends State<TempCategory> {
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
                  Expanded(
                    child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.network(
                          widget.cat.image,

                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Image.asset('assets/image/noImage.jpg');
                          },
                        )),
                  ),
                  Expanded(
                    child: Text(
                      widget.cat.name,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )),
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                "${Get.find<ProductController>().allProducts.where((e) {
                      return e.catId == widget.cat.id;
                    }).toList().length}",
                style: const TextStyle(
                  color: Colors.black,
                ),
              )),
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: PopupMenuButton(
                color: Colors.white,
                tooltip: "Action",
                iconColor: Colors.black,
                icon: const Icon(Icons.more_vert_rounded),
                itemBuilder: (BuildContext context) {
                  return <PopupMenuItem<Widget>>[
                    PopupMenuItem<Widget>(
                      onTap: (){
                        Get.to(()=>AddEditCategory(cat: widget.cat,));
                      },
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: secondaryColor),
                          const SizedBox(width: 5,),
                          Text("Edit", style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                    PopupMenuItem<Widget>(
                      onTap: (){
                        Constant.confirmDialog(context, 'Delete', ()async {
                          if(Get.find<ProductController>().allProducts.where((e) {
                            return e.catId == widget.cat.id;
                          }).toList().isNotEmpty){
                            Constant.showSnakeBarError(context, 'Cannot be Delete due to related Product.');
                            Get.back();
                            return;
                          }
                          await Get.find<CategoryController>()
                              .deleteCategory(catId: widget.cat.id);
                          Get.back();
                        });
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.delete, color: Colors.redAccent),
                          const SizedBox(width: 5,),
                          Text("Delete" , style: TextStyle(color: Colors.black),),
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
