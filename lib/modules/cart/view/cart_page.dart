import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumer/modules/cart/controller/cart_controller.dart';
import 'package:sumer/modules/checkout/controller/checkout_controller.dart';
import 'package:sumer/util/colors.dart';

import '../../../util/text_util.dart';
import '../../checkout/view/checkout_steps.dart';
import '../../product/view/product_details.dart';

class CartPage extends StatefulWidget {
   const CartPage({super.key ,  required this.showBack});
final bool showBack ;
  @override
  CartPageState createState() => CartPageState();
}

final controller = Get.find<CartController>();
final controllerCheckout = Get.find<CheckoutController>();

class CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Obx(() => controller.cartItems.isEmpty
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.blueAccent.withOpacity(0.2),
                        radius: 100,
                        child: Icon(
                          Icons.add_shopping_cart,
                          color: secondaryColor.withOpacity(0.5),
                          size: 150,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextUtil(
                        text: 'Cart Is Empty, Add Some Products',
                        weight: true,
                        align: TextAlign.center,
                        size: 25,
                      ),
                    ),
                   widget.showBack? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                             Colors.white),
                        ),
                        child: TextUtil(
                          text: 'Back',
                          color: secondaryColor.withOpacity(0.8),
                        ),
                      ),
                    ):SizedBox(),
                  ],
                ),
              )
            :SingleChildScrollView(
              child: Column(
                        children: [
              createHeader(),
              width < 750 ? Column(
                children: [
                  createCartList(),
                  footer(context)
                ],
              ):SizedBox(
                width: width/1.3,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Expanded(flex: 3, child: createCartList()),
                  Expanded(
                    flex: 2,
                    child: footer(context),
                  )
                ],),
              )
                        ],
                      ),
            )

       ),
      ),
    );
  }

  footer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .color!
                    .withOpacity(0.15),
                spreadRadius: 0,
                blurRadius: 20, // Increased blur radius
                offset: const Offset(0, 4)),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Row(children: [
              Icon(Icons.shopping_cart , color: Colors.black,),
              SizedBox(width: 10,),
              TextUtil(text: 'Cart Totals', color: Colors.black,)
            ],),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: const Text(
                    "Total Quantity",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 30),
                  child: Text(
                    "${controller.cartItemsQTY}",
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: const Text(
                    "Total Items",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 30),
                  child: Text(
                    "${controller.cartItems.length}",
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: const Text(
                    "Total Price",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 30),
                    child: Text(
                      "${controller.cartItemsTotal.toStringAsFixed(2)} AED",
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Divider(),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: const Text(
                              'Confirm Clear Cart',
                              style: TextStyle(color: Colors.black),
                            ),
                            content: const Text(
                              'Are you sure you want to Remove ALL?',
                              style: TextStyle(color: Colors.black),
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          Colors.redAccent)),
                                  child: const Text(
                                    'No',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              ElevatedButton(
                                  onPressed: () async {
                                    await Get.find<CartController>().clearCart();
                                    Get.back();
                                  },
                                  style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          Colors.blueAccent)),
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ],
                          );
                        },
                      );
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.redAccent)),
                    child: Text(
                      'Remove All',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: Obx(
                    () => controllerCheckout.loading.value
                        ? Center(
                          child: const CircularProgressIndicator(
                              color: Colors.blueAccent,
                            ),
                        )
                        : ElevatedButton(
                            onPressed: () async {
                              await controllerCheckout.getAllAddress();
                              Get.to(() => const StepperPage());
                            },
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    Colors.blueAccent.withOpacity(0.8))),
                            child: Text(
                              'Checkout',
                            maxLines: 1,
    overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  createHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(left: 12, top: 12),
              child: TextUtil(
                text: "SHOPPING CART",
                size: 25,
              ),
            ),
            widget.showBack?Padding(
              padding: const EdgeInsets.all(8.0),
              child: BackButton(
                color: Theme.of(context).textTheme.displayLarge!.color,
                onPressed: () {
                  Get.back();
                },
              ),
            ):SizedBox()
          ],
        ),
      ],
    );
  }

  createCartList() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, position) {
        return createCartListItem(position);
      },
      itemCount: controller.cartItems.length,
    );
  }

  createCartListItem(int index) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            onTap: () {
              Get.to(() =>
                  ProductDetailScreen(product: controller.cartItems[index], view: false,));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .color!
                            .withOpacity(0.15),
                        spreadRadius: 0,
                        blurRadius: 20, // Increased blur radius
                        offset: const Offset(0, 4)),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(16))),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      right: 8, left: 8, top: 8, bottom: 8,
                    ),
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(14)),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        controller.cartItems[index].image,

                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                    : null,
                              ),
                            );
                          }
                        },
                        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                          return Center(
                            child: Icon(Icons.error, color: Colors.red, size: 40),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 100,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(right: 8, top: 4),
                            child: Text(
                              controller.cartItems[index].brand,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                              softWrap: true,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            controller.cartItems[index].model,
                            style: const TextStyle(color: Colors.black54),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child:  Row(
                                  children: [
                                    Text(
                                        '${((controller.cartItems[index].offerPrice ?? 0) > 0 ? (controller.cartItems[index].offerPrice) : (controller.cartItems[index].price))!.toStringAsFixed(0)} AED',
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        softWrap: false,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange)),
                                    if ((controller.cartItems[index].offerPrice ?? 0) > 0)
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text('${controller.cartItems[index].price} AED',
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
                                                  decorationColor:
                                                  Colors.black.withOpacity(0.7))),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30)),
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black)),
                                  child: Row(
                                    children: <Widget>[
                                      controller
                                                  .cartItems[index].qty ==
                                              1
                                          ? IconButton(
                                              onPressed:  Get.find<CartController>().loadingDelete.value
                                                  ? null
                                                  : () async {
                                                Get.find<CartController>().loadingDelete(true);
                                                await Get.find<CartController>()
                                                    .removeItem(controller.cartItems[index]);
                                                setState(() {});
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                size: 20,
                                                color: Colors.redAccent,
                                              ))
                                          : IconButton(
                                              onPressed: () async {
                                                if (controller
                                                        .cartItems[index]
                                                        .qty! >
                                                    1) {
                                                  controller.cartItems[index]
                                                      .qty = controller
                                                          .cartItems[index]
                                                          .qty! -
                                                      1;
                                                }
                                                await controller
                                                    .updateProductInCart(
                                                        controller
                                                            .cartItems[index]
                                                            .id,
                                                        controller
                                                            .cartItems[index]
                                                            .qty!);
                                                setState(() {});
                                              },
                                              icon: const Icon(
                                                Icons.remove,
                                                size: 20,
                                                color: Colors.redAccent,
                                              )),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20 , right: 20),
                                        child: Center(
                                          child: Text(
                                            controller.cartItems[index].qty
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            controller.cartItems[index].qty =
                                                controller.cartItems[index]
                                                        .qty! +
                                                    1;
                                            await controller
                                                .updateProductInCart(
                                                    controller
                                                        .cartItems[index].id,
                                                    controller
                                                        .cartItems[index]
                                                        .qty!);
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            size: 24,
                                            color: Colors.black,
                                          ))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              onTap: Get.find<CartController>().loadingDelete.value
                  ? null
                  : () async {
                      Get.find<CartController>().loadingDelete(true);
                      await Get.find<CartController>()
                          .removeItem(controller.cartItems[index]);
                      setState(() {});
                    },
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.redAccent,
                child: Center(
                    child: Get.find<CartController>().loadingDelete.value
                        ? const CircularProgressIndicator()
                        : const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 13,
                          )),
              ),
            ),
          ),
        )
      ],
    );
  }

}
