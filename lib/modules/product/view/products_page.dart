// product_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:sumer/modules/category/controller/category_controller.dart';
import 'package:sumer/modules/product/view/product_card.dart';
import 'package:sumer/modules/product/view/product_details.dart';
import 'package:sumer/util/colors.dart';
import 'package:sumer/util/text_util.dart';

import '../controller/product_controller.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    super.key,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

final ScrollController _scrollController1 = ScrollController();
final ProductController productController = Get.find<ProductController>();
final catController = Get.find<CategoryController>();
bool isGridView = true;
List<String> list = ['5', '10', '20', '30', '50'];
FocusNode? d1 ;
FocusNode? d2 ;
class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    d1  = FocusNode();
    d2  = FocusNode();
    productController.currentPage.value = 0;
    productController.itemsPerPage.value = 10;
    super.initState();
  }
  @override
  void dispose() {
    d1?.dispose();
    d2?.dispose();
    d1=null;
    d2=null;
    super.dispose();
  }
  @override

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      int totalPages = (productController.products.length /
              productController.itemsPerPage.value)
          .ceil();
      var paginatedProducts = productController.products
          .skip(productController.currentPage.value *
              productController.itemsPerPage.value)
          .take(productController.itemsPerPage.value)
          .toList();
      if (productController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (productController.products.isEmpty) {
        return Center(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextUtil(
            text: 'No products found',
            size: 25,
          ),
        ));
      }

      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 22, vertical: 10),
        child: Column(
          children: [
            width > 800
                ? SizedBox()
                : ToggleButtons(
                    isSelected: [isGridView, !isGridView],
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    borderColor: Colors.white,
                    selectedColor: Colors.black,
                    selectedBorderColor: Colors.black,
                    onPressed: (index) {
                      setState(() {
                        isGridView = index == 0;
                      });
                    },
                    children: const [
                      Icon(Icons.grid_on),
                      Icon(Icons.list),
                    ],
                  ),
            isGridView || MediaQuery.of(context).size.width > 800
                ? LayoutBuilder(builder: (context, _) {
                    return GridView.builder(
                      controller: _scrollController1,
                      // padding: const EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 800 ? 5 : 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 360),
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: paginatedProducts.length,
                      itemBuilder: (context, index) {
                        var product = paginatedProducts[index];
                        return InkWell(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            onTap: !product.available &&
                                    (product.currentQty ?? 0) == 0
                                ? null
                                : () {
                                    Get.to(() => ProductDetailScreen(
                                          product: product,
                                          view: false,
                                        ));
                                  },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ProductCardView(
                                product: product,
                                imageAlignment: Alignment.topCenter,
                                isGrid:MediaQuery.of(context).size.width > 800 ? true: isGridView,
                              ),
                            ));
                      },
                    );
                  })
                : ListView.builder(
                    controller: _scrollController1,
                    // padding: const EdgeInsets.all(16),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: paginatedProducts.length,
                    itemBuilder: (context, index) {
                      var product = paginatedProducts[index];
                      return InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          onTap: !product.available &&
                                  (product.currentQty ?? 0) == 0
                              ? null
                              : () {
                                  Get.to(() => ProductDetailScreen(
                                        product: product,
                                        view: false,
                                      ));
                                },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ProductCardView(
                              product: product,
                              imageAlignment: Alignment.topCenter,
                              isGrid: isGridView,
                            ),
                          ));
                    },
                  ),
            totalPages != 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            TextUtil(
                              text: 'Items per page  ',
                              color: Colors.grey,
                            ),
                            DropdownButton<String>(
                              iconEnabledColor: Colors.black,
                              iconDisabledColor: Colors.grey,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              dropdownColor: Colors.white,
                              elevation: 24,
                              value: productController.itemsPerPage.value
                                  .toString(),
                              items: list
                                  .map((e) => DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              focusNode: d1,
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  productController.itemsPerPage.value =
                                      int.parse(newValue);
                                  productController.currentPage(0);
                                  d1!.unfocus();
                                }
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            IconButton(
                              iconSize: 15,
                              onPressed: productController.currentPage.value ==
                                      0
                                  ? null
                                  : () {
                                      setState(() {
                                        productController.currentPage.value -=
                                            1;
                                      });
                                    },
                              icon: Icon(Icons.arrow_back_ios),
                              color: productController.currentPage.value == 0
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 5),
                              child: DropdownButton<String>(
                                iconEnabledColor: Colors.black,
                                iconDisabledColor: Colors.grey,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                dropdownColor: Colors.white,
                                elevation: 24,
                                value: productController.currentPage.value
                                    .toString(),
                                items: List.generate(totalPages,
                                        (index) => (index).toString())
                                    .map((e) => DropdownMenuItem<String>(
                                          value: e,
                                          child: Text(
                                              (int.parse(e) + 1).toString()),
                                        ))
                                    .toList(),
                                focusNode: d2,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    productController.currentPage.value =
                                        int.parse(newValue);
                                  }
                                  d2?.unfocus();
                                  setState(() {});
                                },
                              ),
                            ),
                            IconButton(
                              onPressed:
                                  productController.currentPage.value + 1 <
                                          totalPages
                                      ? () {
                                          if (totalPages != 0) {
                                            if (productController
                                                        .currentPage.value +
                                                    1 <
                                                totalPages) {
                                              setState(() {
                                                productController
                                                    .currentPage.value += 1;
                                              });
                                            }
                                          }
                                        }
                                      : null,
                              icon: Icon(Icons.arrow_forward_ios),
                              iconSize: 15,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      );
    });
  }
}
