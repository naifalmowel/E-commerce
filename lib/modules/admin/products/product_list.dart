import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sumer/modules/admin/products/add_edit_products.dart';
import 'package:sumer/modules/admin/products/temp_products.dart';
import 'package:sumer/modules/product/controller/product_controller.dart';
import 'package:sumer/util/colors.dart';
import 'package:sumer/util/text_util.dart';


class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

var productController = Get.find<ProductController>();
TextEditingController searchController = TextEditingController();
final ScrollController _scrollController = ScrollController();
class _ProductListState extends State<ProductList> {
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
          child: SingleChildScrollView(
            child: Column(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextUtil(
                      text: 'Products',
                      size: 20,
                    ),
                    ElevatedButton(
                        onPressed: ()  {
                          Get.to(() => AddEditProducts());
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white)),
                        child:  Text(
                          'Add New Product',
                          style: TextStyle(color: secondaryColor),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() {

                  if (productController.isLoading.value) {
                    searchController.clear();
                    productController.filterPlayer('');
                    return Center(
                        child: CircularProgressIndicator(
                          color: secondaryColor,
                        ),
                      );
                  } else {
                    return productController.allProducts.isEmpty
                        ? Center(
                            child: TextUtil(
                              text: 'NO PRODUCTS',
                              size: 30,
                            ),
                          )
                        : Container(
                      width: width > 700 ? width / 1.1 : 900,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [ BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10.0,
                                  offset: Offset(0.0, 3.0),
                                ),],
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: TextFormField(
                                    controller: searchController,
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.8)),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:
                                            BorderSide(color: secondaryColor),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:
                                            BorderSide(color: secondaryColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                            color: secondaryColor
                                                .withOpacity(0.8)),
                                      ),
                                      hintText: 'Search',
                                      suffixIcon: searchController.text.isEmpty
                                          ? null
                                          : IconButton(
                                              onPressed: () {
                                                searchController.clear();
                                                productController
                                                    .filterPlayer('');
                                                setState(() {});
                                              },
                                              icon: Icon(
                                                FontAwesomeIcons.circleXmark,
                                                color: Colors.redAccent,
                                              )),
                                    ),
                                    onChanged: (value) =>
                                        productController.filterPlayerAdmin(value),
                                  ),
                                ),

                                Scrollbar(
                                  controller: _scrollController,
                                  scrollbarOrientation: ScrollbarOrientation.top,
                                  thumbVisibility: true,
                                  child: SingleChildScrollView(
                                    controller: _scrollController,
                                    scrollDirection: Axis.horizontal,
                                    child: SizedBox(
                                      width: width > 700 ? width / 1.1 : 900,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              children: [
                                                Flexible(
                                                    flex: 2,
                                                    fit: FlexFit.tight,
                                                    child: Text(
                                                      'ITEMS (${productController.filterProductsAdmin.length})',
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold),
                                                    )),
                                                const Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.tight,
                                                    child: Text(
                                                      'PRICE',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold),
                                                    )),
                                                const Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.tight,
                                                    child: Text(
                                                      'Active',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold),
                                                    )),
                                                const Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.tight,
                                                    child: Text(
                                                      'Stock',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold),
                                                    )),
                                                const Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.tight,
                                                    child: Text(
                                                      '',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            color: Colors.black54,
                                            thickness: 2,
                                          ),
                                          ListView.separated(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount:
                                                productController.filterProductsAdmin.length,
                                            itemBuilder: (context, index) {
                                              return TempProducts(
                                                product: productController
                                                    .filterProductsAdmin[index],
                                              );
                                            },
                                            separatorBuilder:
                                                (BuildContext context, int index) {
                                              return const Divider();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
