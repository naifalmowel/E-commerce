import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumer/modules/cart/controller/cart_controller.dart';
import 'package:sumer/modules/checkout/controller/checkout_controller.dart';
import 'package:sumer/modules/user/controller/user_controller.dart';
import 'package:sumer/util/text_util.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

final controller = Get.find<CheckoutController>();
List<String> payList = ['Cash On Delivery (COD)', 'Card'];

class _PaymentPageState extends State<PaymentPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 3.0),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black54)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 20,
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Contact ',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          Get.find<UserController>().email.toString(),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Ship to ',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Obx(() => Expanded(
                        flex: 3,
                            child: Text(
                              controller.addressDetails.isEmpty
                                  ? ''
                                  : '${controller.addressDetails.last.country} , ${controller.addressDetails.last.city} , ${controller.addressDetails.last.address} , ${controller.addressDetails.last.apartment} ',
                              style: const TextStyle(color: Colors.black),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Shipping rate ',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Obx(() => Expanded(flex: 3,
                            child: Text(
                              "${controller.selectedShip.value} - ${controller.selectedShip.value.contains('Slow') ? '25 AED' :controller.selectedShip.value.contains('Free')?'0 AED': '50 AED'}",
                              style: const TextStyle(color: Colors.black),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        TextUtil(
          text: 'Payment Method',
          size: 20,
          weight: true,
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 3.0),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black54)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Obx(
                  () => Text(
                    'How would you like to pay ${Get.find<CartController>().finalTotal.toStringAsFixed(2)} AED ?',
                    style: TextStyle(color: Colors.black.withOpacity(0.9) , fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: payList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Column(
                        children: [
                          RadioListTile<String>(
                            shape: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.blueAccent),
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding: const EdgeInsets.all(8),
                            title: Text(payList[index] , style: TextStyle(color: Colors.black),),
                            secondary: Icon(payList[index].contains('Cash')
                                ? Icons.money
                                : Icons.credit_card , color: Colors.black,),
                            value: payList[index],
                            groupValue: controller.selectedPay.value,
                            activeColor: Colors.blueAccent.withOpacity(0.8),
                            onChanged: (String? value) {
                              setState(() {
                                controller.selectedPay.value = value!;
                                Get.find<CartController>().getTotals();
                              });
                            },
                          ),
                          const Divider()
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
