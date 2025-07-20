import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sumer/modules/admin/category/add_edit_category.dart';
import 'package:sumer/modules/admin/category/temp_category.dart';
import 'package:sumer/modules/category/controller/category_controller.dart';
import 'package:sumer/util/colors.dart';
import 'package:sumer/util/text_util.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

var categoryController = Get.find<CategoryController>();
TextEditingController searchController = TextEditingController();
class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
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
                          text: 'Categories',
                          size: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Get.to(()=>const AddEditCategory());
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                WidgetStatePropertyAll(Colors.white)),
                            child:  Text(
                              'Add New Category',
                              style: TextStyle(color: secondaryColor),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(() => categoryController.isLoading.value
                        ? Center(
                      child: CircularProgressIndicator(
                        color: secondaryColor,
                      ),
                    )
                        : categoryController.allCategories.isEmpty
                        ? Center(
                      child: TextUtil(
                        text: 'NO Categories',
                        size: 30,
                      ),
                    )
                        : Container(
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
                                      categoryController.filterPlayer('');
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.circleXmark,
                                      color: Colors.redAccent,
                                    )),
                              ),
                              onChanged: (value)=>categoryController.filterPlayer(value),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      'NAME (${categoryController.filterCategories.length})',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                                const Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      'Products',
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
                            categoryController.filterCategories.length,
                            itemBuilder: (context, index) {
                              return TempCategory(
                                cat:
                                categoryController.filterCategories[index],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider();
                            },
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
