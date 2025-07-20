import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumer/modules/cart/controller/cart_controller.dart';
import 'package:sumer/modules/checkout/controller/checkout_controller.dart';
import 'package:sumer/modules/user/controller/user_controller.dart';
import 'package:sumer/util/text_util.dart';


class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

final controller = Get.find<CheckoutController>();

List<String> shipList = ['Free Shipping' ,'Slow Shipping', 'Fast Shipping'];

class _DeliveryPageState extends State<DeliveryPage> {
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
                      const Text(
                        'Contact ',
                        style: TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        Get.find<UserController>().email.toString(),
                        style: const TextStyle(color: Colors.black),
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
                      const Text(
                        'Ship to ',
                        style: TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Obx(()=>Expanded(
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
            ],
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        TextUtil(
          text: 'Shipping',
          size: 20,
          weight: true,
        ),
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
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: shipList.length,
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
                      title: Text(shipList[index] , style: const TextStyle( color: Colors.black),),
                      secondary: Text(shipList[index].contains('Slow')?'25 AED' :shipList[index].contains('Free')?'0 AED': '50 AED' , style: const TextStyle(fontSize: 15 , fontWeight: FontWeight.bold , color: Colors.black),),
                      value: shipList[index],
                      groupValue: controller.selectedShip.value,
                      activeColor: Colors.blueAccent.withOpacity(0.8),
                      onChanged: (String? value) {
                        setState(() {
                          controller.selectedShip.value = value!;
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
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
