import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sumer/util/text_util.dart';

import '../../../util/colors.dart';
import '../../../util/firestore_service.dart';
import '../../../util/scroll_config.dart';
import '../../product/controller/product_controller.dart';
import '../controller/category_controller.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

final ScrollController controller = ScrollController();
final FirestoreService firestoreService = FirestoreService();
final categoryController = Get.find<CategoryController>();
final productController = Get.find<ProductController>();

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Obx(() {
      if (categoryController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (categoryController.categories.isEmpty) {
        return const Center(child: Text('No categories found'));
      }
      return Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextUtil(
              text: 'Our Special Collections',
              size: width > 1200 ? 35 : 25,
              color: Colors.black87,
            ),
          ),
          SizedBox(
            height: width > 1200 ? height / 4 : height / 5,
            child: ScrollConfiguration(
              behavior: MyCustomScrollBehavior(),
              child: ListView.builder(
                controller: controller,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding:
                    EdgeInsets.symmetric(horizontal: width / 22, vertical: 5),
                itemCount: categoryController.categories.length,
                itemBuilder: (context, index) {
                  var category = categoryController.categories[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        productController.catId.value = category.id;
                        productController.fetchProducts(category.id);
                        setState(() {});
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            radius: width > 1200 ? 60 : 40,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: category.image,
                                fit: BoxFit.fill,
                                width: 160,
                                height: 160,
                                placeholder: (context, url) {
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      width: double.infinity,
                                      height: 200,
                                      color: Colors.white,
                                    ),
                                  );
                                  ;
                                },
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/image/noImage.jpg',
                                  width: 160,
                                  height: 160,
                                ),
                              ),
                            ),
                            // Image.network(category.image, width: 160,
                            //   height: 160,
                            //   fit: BoxFit.fill,
                            //   loadingBuilder: (context, child, loadingProgress) {
                            //     if (loadingProgress == null) {
                            //       return child; // عرض الصورة عند اكتمال التحميل
                            //     }
                            //     return Center(
                            //       child: CircularProgressIndicator(
                            //         color: Colors.grey,
                            //         value: loadingProgress.expectedTotalBytes != null
                            //             ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                            //             : null, // نسبة التقدم إن توفرت
                            //       ),
                            //     );
                            //   },
                            //   errorBuilder: (context, url, error) =>
                            //       Image.asset(
                            //         'assets/image/noImage.jpg', width: 160,
                            //         height: 160,),),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextUtil(
                            text: category.name,
                            color: productController.catId.value == category.id
                                ? Colors.black
                                : Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    });
  }
}
