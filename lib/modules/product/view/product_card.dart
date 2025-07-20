import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumer/modules/cart/controller/cart_controller.dart';
import 'package:sumer/util/colors.dart';
import 'package:sumer/util/scroll_config.dart';

import '../../../model/product_model.dart';

class ProductCardView extends StatelessWidget {
  const ProductCardView(
      {super.key,
      required this.product,
      this.imageAlignment = Alignment.bottomCenter,
      this.onTap,
      required this.isGrid});

  final Product product;
  final Alignment imageAlignment;
  final Function(String)? onTap;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: !product.available && (product.currentQty ?? 0) == 0 ? 0.5 : 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Get.isDarkMode
                    ? Colors.white.withOpacity(0.18)
                    : Colors.black.withOpacity(0.18),
                spreadRadius: 0,
                blurRadius: 20, // Increased blur radius
                offset: const Offset(0, 4)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isGrid)
                          Stack(
                            alignment: AlignmentDirectional.bottomStart,
                            children: [
                              SizedBox(
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                                child: Image.network(
                                  product.image,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, url, error) =>
                                      Image.asset('assets/image/noImage.jpg'),
                                  alignment: imageAlignment,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: product.available
                                    ? Text(" ON STORE ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                color: Colors.white,
                                                backgroundColor: Colors.green))
                                    : (product.currentQty ?? 0) > 0 &&
                                            (product.currentQty ?? 0) < 4
                                        ? Text(
                                            "  Only ${(product.currentQty ?? 0)} left - order now.",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                    color: Colors.white,
                                                    backgroundColor:
                                                        Colors.orangeAccent))
                                        : (product.currentQty ?? 0) >= 4
                                            ? Text(" ON STORE ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        color: Colors.white,
                                                        backgroundColor:
                                                            Colors.green))
                                            : Text(" OUT OF STOCK",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        color: Colors.white,
                                                        backgroundColor:
                                                            Colors.redAccent)),
                              ),
                            ],
                          ),
                        if (isGrid) const SizedBox(height: 8),
                        SizedBox(
                            child: Text(product.brand,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: const TextStyle(color: Colors.black))),
                        SizedBox(
                            child: Text(product.model,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8)))),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: SizedBox(
                            height: 30,
                            child: ScrollConfiguration(
                              behavior: MyCustomScrollBehavior(),
                              child: ListView.builder(
                                  itemCount: product.images.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: Image.network(
                                              product.images[index],
                                              alignment: imageAlignment,
                                              fit: BoxFit.contain)),
                                    );
                                  }),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                                '${((product.offerPrice ?? 0) > 0 ? (product.offerPrice) : (product.price))!.toStringAsFixed(0)} AED',
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                softWrap: false,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange)),
                            if ((product.offerPrice ?? 0) > 0)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text('${product.price} AED',
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      softWrap: false,
                                      style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.8),
                                              fontSize: 12)
                                          .copyWith(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationColor: Colors.black
                                                  .withOpacity(0.7))),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        if (isGrid)
                          (!product.available && (product.currentQty ?? 0) == 0)
                              ? SizedBox()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(
                                      () => Get.find<CartController>()
                                              .cartItems
                                              .map((element) =>
                                                  element.id.toString())
                                              .contains(product.id.toString())
                                          ? FloatingActionButton(
                                              tooltip: 'Delete Item From Cart',
                                              heroTag: "btn1${product.id}",
                                              onPressed:
                                                  Get.find<CartController>()
                                                          .loadingDelete
                                                          .value
                                                      ? null
                                                      : () async {
                                                          await Get.find<
                                                                  CartController>()
                                                              .removeItem(
                                                                  product);
                                                        },
                                              mini: true,
                                              backgroundColor: Colors.red,
                                              child: Get.find<CartController>()
                                                      .loadingDelete
                                                      .value
                                                  ? const CircularProgressIndicator(
                                                      color: Colors.white,
                                                    )
                                                  : const Icon(Icons.delete),
                                            )
                                          : const SizedBox(),
                                    ),
                                    FloatingActionButton(
                                      tooltip: 'Add Item To Cart',
                                      backgroundColor:
                                          secondaryColor.withOpacity(0.5),
                                      heroTag: "btn2${product.id}",
                                      onPressed: () async {
                                        await Get.find<CartController>()
                                            .addItem(product);
                                      },
                                      mini: true,
                                      child: const Icon(
                                        Icons.add_shopping_cart,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                      ]),
                ),
                if (!isGrid)
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        SizedBox(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(product.image,
                                alignment: imageAlignment,
                                fit: BoxFit.contain)),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: product.available
                              ? Text(" ON STORE ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: Colors.white,
                                          backgroundColor: Colors.green))
                              : (product.currentQty ?? 0) > 0
                                  ? Text(
                                      " ${(product.currentQty ?? 0)} is Available ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: Colors.white,
                                              backgroundColor:
                                                  Colors.orangeAccent))
                                  : Text(" OUT OF STOCK",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: Colors.white,
                                              backgroundColor:
                                                  Colors.redAccent)),
                        ),
                      ],
                    ),
                  ),
                if (!isGrid)
                  (!product.available && (product.currentQty ?? 0) == 0)
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: FloatingActionButton(
                                  backgroundColor:
                                      secondaryColor.withOpacity(0.5),
                                  tooltip: 'Add Item To Cart',
                                  heroTag: "btn2${product.id}",
                                  onPressed: () async {
                                    await Get.find<CartController>()
                                        .addItem(product);
                                  },
                                  mini: true,
                                  child: const Icon(
                                    Icons.add_shopping_cart,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Obx(
                                () => Get.find<CartController>()
                                        .cartItems
                                        .map((element) => element.id.toString())
                                        .contains(product.id.toString())
                                    ? Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: FloatingActionButton(
                                          tooltip: 'Delete Item From Cart',
                                          heroTag: "btn1${product.id}",
                                          onPressed: Get.find<CartController>()
                                                  .loadingDelete
                                                  .value
                                              ? null
                                              : () async {
                                                  await Get.find<
                                                          CartController>()
                                                      .removeItem(product);
                                                },
                                          mini: true,
                                          backgroundColor: Colors.red,
                                          child: Get.find<CartController>()
                                                  .loadingDelete
                                                  .value
                                              ? const CircularProgressIndicator(
                                                  color: Colors.white,
                                                )
                                              : const Icon(Icons.delete),
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                            ],
                          ),
                        )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
