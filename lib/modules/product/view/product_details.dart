import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumer/util/colors.dart';
import 'package:sumer/util/constant.dart';
import 'package:sumer/util/scroll_config.dart';
import 'package:sumer/util/text_util.dart';

import '../../../model/product_model.dart';
import '../../cart/controller/cart_controller.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  final bool view;

  const ProductDetailScreen(
      {super.key, required this.product, required this.view});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

int index1 = 0;
List getImages = [];
class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
     getImages = widget.product.images;
var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: width > 800 ? proDetailsWeb() : SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.network(getImages[index1], width: 350,
                        height: 350,
                        fit: BoxFit.contain,
                        errorBuilder: (context, url, error) =>
                            Image.asset(
                                'assets/image/noImage.jpg'),

                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed:index1 == 0 ?null :  (){
                            if(index1 > 0){
                              setState(() {
                                index1--;
                              });
                            }
                          }, icon: Icon(Icons.arrow_back_ios), color: index1 == 0 ? Colors.grey : Colors.black,),
                          IconButton(onPressed:index1 == getImages.length - 1?null :  (){
                            if(index1 < getImages.length - 1){
                              setState(() {
                                index1++;
                              });
                            }
                          }, icon: Icon(Icons.arrow_forward_ios) , color:index1 == getImages.length - 1?Colors.grey :  Colors.black,),
                        ],)
                    ],
                  ),
                ),
                expandedHeight: 400,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(10),
                  child: Container(
                    height: 20,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(70),
                        topRight: Radius.circular(70),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 7),
                        Container(
                          height: 4,
                          width: 100,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(70),
                              topRight: Radius.circular(70),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                automaticallyImplyLeading: false,
                title: BackButton(
                  color: Colors.black,
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 70,
                          child: ScrollConfiguration(
                            behavior: MyCustomScrollBehavior(),
                            child: ListView.builder(
                              itemCount: getImages.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                  EdgeInsets.only(left: index == 0 ? 0 : 24),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        index1 = index;
                                      });
                                    },
                                    child: Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 2,
                                          color: index1 == index
                                              ? Colors.black
                                              : Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          getImages[index],
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent? loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child; // الصورة تم تحميلها بنجاح
                                            } else {
                                              return Center(
                                                child: CircularProgressIndicator(
                                                  value: loadingProgress
                                                      .expectedTotalBytes !=
                                                      null
                                                      ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                      (loadingProgress
                                                          .expectedTotalBytes ??
                                                          1)
                                                      : null,
                                                ),
                                              );
                                            }
                                          },
                                          errorBuilder: (BuildContext context,
                                              Object error,
                                              StackTrace? stackTrace) {
                                            return Center(
                                              child: Icon(Icons.error,
                                                  color: Colors.red, size: 40),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.brand,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(widget.product.model,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '4.3',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(

                          children: [
                            Text(
                                '${((widget.product.offerPrice ?? 0) > 0
                                    ? (widget.product.offerPrice)
                                    : (widget.product.price))!.toStringAsFixed(
                                    0)} AED',
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                softWrap: false,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange, fontSize: 20)),
                            if ((widget.product.offerPrice ?? 0) > 0)
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text('${widget.product.price} AED',
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    softWrap: false,
                                    style: TextStyle(
                                        color:
                                        Colors.black.withOpacity(0.8),
                                        fontSize: 15)
                                        .copyWith(
                                        decoration:
                                        TextDecoration.lineThrough,
                                        decorationColor:
                                        Colors.black.withOpacity(0.7))),
                              ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        if(!widget.view) Row(
                          children: [
                            ElevatedButton.icon(
                              style: ButtonStyle(backgroundColor: WidgetStateColor.resolveWith((e)=>secondaryColor)),
                              onPressed: () async{
                                 await Get.find<CartController>().addItem(widget.product);
                              }, label: TextUtil(text: 'Add To Cart',
                              color: Colors.white,), icon: Icon(Icons
                                .add_shopping_cart, color: Colors.white,),),
                            SizedBox(width: 20,),
                           Obx(()=> Get
                               .find<CartController>()
                               .cartItems
                               .map((element) => element.id.toString())
                               .contains(widget.product.id.toString())
                               ? ElevatedButton.icon(
                             style: ButtonStyle(backgroundColor: WidgetStateColor.resolveWith((e)=>errorColor)),
                             onPressed: Get
                                              .find<CartController>()
                                              .loadingDelete
                                              .value ? null : () async {
                                            await Get.find<CartController>().removeItem(widget.product);
                                          }, label: TextUtil(text: 'Remove',
                             color: Colors.white,), icon: Icon(Icons
                               .remove_shopping_cart, color: Colors.white,),) : SizedBox(),)
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Size',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(widget.product.size,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                            )),
                        const SizedBox(height: 20),
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            widget.product.dis,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    index1 = 0;
    super.deactivate();
  }
  Widget proDetailsWeb(){
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: BackButton(
                color: Colors.black,
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 800,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration:  BoxDecoration(border: Border.all(color: Colors.black54),borderRadius: BorderRadius.all(Radius.circular(20)),),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.network(getImages[index1], width: 600,
                                height: 600,
                                fit: BoxFit.contain,
                                errorBuilder: (context, url, error) =>
                                    Image.asset(
                                        'assets/image/noImage.jpg'),

                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            IconButton(onPressed:index1 == 0 ?null :  (){
                              if(index1 > 0){
                                setState(() {
                                  index1--;
                                });
                              }
                            }, icon: Icon(Icons.arrow_back_ios), color: index1 == 0 ? Colors.grey : Colors.black,),
                            IconButton(onPressed:index1 == getImages.length - 1?null :  (){
                              if(index1 < getImages.length - 1){
                                setState(() {
                                  index1++;
                                });
                              }
                            }, icon: Icon(Icons.arrow_forward_ios) , color:index1 == getImages.length - 1?Colors.grey :  Colors.black,),
                          ],)
                        ],
                      ),
                      SizedBox(height: 25,),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Wrap(
                          children:getImages.map((e) {
                            var index = getImages.indexOf(e);
                            return Padding(
                            padding:
                            EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  index1 = index;
                                });
                              },
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: index1 == index
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    getImages[index],
                                    fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child; // الصورة تم تحميلها بنجاح
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                .expectedTotalBytes !=
                                                null
                                                ? loadingProgress
                                                .cumulativeBytesLoaded /
                                                (loadingProgress
                                                    .expectedTotalBytes ??
                                                    1)
                                                : null,
                                          ),
                                        );
                                      }
                                    },
                                    errorBuilder: (BuildContext context,
                                        Object error,
                                        StackTrace? stackTrace) {
                                      return Center(
                                        child: Icon(Icons.error,
                                            color: Colors.red, size: 40),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                          }).toList(),

                        ),
                      ),
                      const SizedBox(height: 25),
                    ],
                          ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.brand,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(widget.product.model,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '4.3',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(

                          children: [
                            Text(
                                '${((widget.product.offerPrice ?? 0) > 0
                                    ? (widget.product.offerPrice)
                                    : (widget.product.price))!.toStringAsFixed(
                                    0)} AED',
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                softWrap: false,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange, fontSize: 20)),
                            if ((widget.product.offerPrice ?? 0) > 0)
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text('${widget.product.price} AED',
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    softWrap: false,
                                    style: TextStyle(
                                        color:
                                        Colors.black.withOpacity(0.8),
                                        fontSize: 15)
                                        .copyWith(
                                        decoration:
                                        TextDecoration.lineThrough,
                                        decorationColor:
                                        Colors.black.withOpacity(0.7))),
                              ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        if(!widget.view) Row(
                          children: [
                            ElevatedButton.icon(
                              style: ButtonStyle(backgroundColor: WidgetStateColor.resolveWith((e)=>secondaryColor)),
                              onPressed: () async{
                                await Get.find<CartController>().addItem(widget.product);
                              }, label: TextUtil(text: 'Add To Cart',
                              color: Colors.white,), icon: Icon(Icons
                                .add_shopping_cart, color: Colors.white,),),
                            SizedBox(width: 20,),
                            Obx(()=> Get
                                .find<CartController>()
                                .cartItems
                                .map((element) => element.id.toString())
                                .contains(widget.product.id.toString())
                                ? ElevatedButton.icon(
                              style: ButtonStyle(backgroundColor: WidgetStateColor.resolveWith((e)=>errorColor)),
                              onPressed: Get
                                  .find<CartController>()
                                  .loadingDelete
                                  .value ? null : () async {
                                await Get.find<CartController>().removeItem(widget.product);
                              }, label: TextUtil(text: 'Remove',
                              color: Colors.white,), icon: Icon(Icons
                                .remove_shopping_cart, color: Colors.white,),) : SizedBox(),)
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Size',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(widget.product.size,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                            )),
                        const SizedBox(height: 20),
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            widget.product.dis,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
