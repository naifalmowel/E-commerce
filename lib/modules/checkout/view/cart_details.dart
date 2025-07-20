import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumer/modules/cart/controller/cart_controller.dart';
import 'package:sumer/modules/checkout/controller/checkout_controller.dart';
import 'package:sumer/util/colors.dart';

class CartDetails extends StatefulWidget {
  const CartDetails({super.key});

  @override
  State<CartDetails> createState() => _CartDetailsState();
}

final controller = Get.find<CartController>();

class _CartDetailsState extends State<CartDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
                border: Border.all(color: Colors.black54),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.shopping_cart_outlined,
                              color: Colors.black),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Your Order',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon:  Icon(Icons.edit , color: secondaryColor,))
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.cartItems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Badge(
                                    label: Text(
                                      controller.cartItems[index].qty!
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    backgroundColor: Colors.blueAccent,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        width: 100,
                                        height: 100,
                                        child:
                                        Image.network(controller.cartItems[index].image,
                                          fit: BoxFit.fill, errorBuilder: (context, url, error) =>
                                              Image.asset(
                                              'assets/image/noImage.jpg'),

                                        )),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        "${controller.cartItems[index].brand}  ${controller.cartItems[index].model}",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child:  Text(
                                  textAlign: TextAlign.end,
                                  '${((controller.cartItems[index].offerPrice ?? 0) > 0 ? (controller.cartItems[index].offerPrice) : (controller.cartItems[index].price))!.toStringAsFixed(0)} AED',
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                            ),
                          ],
                        ),
                      );
                    }),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                Obx(() => Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                "Total Quantity",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                              ),
                              Text(
                                "${controller.cartItemsQTY}",
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                "Total Items",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                              ),
                              Text(
                                "${controller.cartItems.length}",
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                "Subtotal",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                              ),
                              Text(
                                "${controller.cartItemsTotal.toStringAsFixed(2)} AED",
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                "Shipping",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                              ),
                              Text(
                                Get.find<CheckoutController>().selectedShip.value.isEmpty? "Calculated Later" :
                                controller.shipTotal.value == 0
                                    ? "Free Delivery"
                                    : "${controller.shipTotal.toStringAsFixed(2)} AED",
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                "Final Total",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Text(
                                "${controller.finalTotal.toStringAsFixed(2)} AED",
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
