import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumer/modules/checkout/controller/checkout_controller.dart';
import 'package:sumer/modules/user/controller/user_controller.dart';
import 'package:sumer/util/text_util.dart';

import 'add_address_dialog.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

final controller = Get.find<CheckoutController>();

class _AddAddressPageState extends State<AddAddressPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        TextUtil(
          text: 'Contact information',
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
                        'Name ',
                        style: TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        Get.find<UserController>().name.toString(),
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
                  height: 20,
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Text(
                        'Email ',
                        style: TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(
                        width: 8,
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
                  height: 20,
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Text(
                        'Phone ',
                        style: TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        Get.find<UserController>().phone.toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
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
          text: 'Shipping information',
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextUtil(
                  text: 'Select a shipping address',
                  color: Colors.black54,
                  size: 18,
                  weight: false,
                ),
                const SizedBox(
                  height: 8,
                ),
                Obx(() => controller.address.isEmpty
                    ?  Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextUtil(
                            text: 'No Address Found , Please Add New Address.',size: 15, weight: true,
                          ),
                        ),
                      )
                    : controller.loading.value
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Colors.blueAccent,
                          ))
                        : ListView.builder(
                            shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.address.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8, bottom: 8),
                                child: Column(
                                  children: [
                                    RadioListTile<String>(
                                      secondary: SizedBox(
                                        width: 100,
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Dialog(
                                                            child: AddressForm(
                                                          address: controller
                                                              .address[index],
                                                        ));
                                                      });
                                                },
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color: Colors.blueAccent,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: true,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        backgroundColor: Colors.white,
                                                        title: const Text(
                                                            'Confirm Delete Address'),
                                                        content: const Text(
                                                            'Are you sure you want to Delete Address?'),
                                                        actions: [
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                Get.back();
                                                              },
                                                              style: const ButtonStyle(
                                                                  backgroundColor:
                                                                      WidgetStatePropertyAll(
                                                                          Colors
                                                                              .redAccent)),
                                                              child: const Text(
                                                                'No',
                                                                style: TextStyle(
                                                                    color:
                                                                        Colors.white),
                                                              )),
                                                          Obx(
                                                            () => controller
                                                                    .loading.value
                                                                ? const Center(
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      color: Colors
                                                                          .blueAccent,
                                                                    ),
                                                                  )
                                                                : ElevatedButton(
                                                                    onPressed:
                                                                        () async {
                                                                      await Get.find<
                                                                              CheckoutController>()
                                                                          .deleteAddress(
                                                                              addressId: controller
                                                                                  .address[index]
                                                                                  .id);

                                                                      Get.back();
                                                                    },
                                                                    style: const ButtonStyle(
                                                                        backgroundColor:
                                                                            WidgetStatePropertyAll(
                                                                                Colors
                                                                                    .blueAccent)),
                                                                    child: const Text(
                                                                      'Yes',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white),
                                                                    )),
                                                          )
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.redAccent,
                                                )),
                                          ],
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.all(8),
                                      title: TextUtil(
                                          text: '${controller.address[index].country}\n${controller.address[index].city}\n${controller.address[index].address}\n${controller.address[index].apartment}\nPhone2 :${controller.address[index].secondaryPhone}',color: Colors.black,),
                                      value: controller.address[index].id,
                                      groupValue: controller.selectedAddress.value,
                                      activeColor: Colors.blueAccent.withOpacity(0.8),
                                      onChanged: (String? value) {
                                        setState(() {
                                          controller.selectedAddress.value = value!;
                                          controller.addressInfo.value = '${controller.address[index].country}\n${controller.address[index].city}\n${controller.address[index].address}\n${controller.address[index].apartment}\nPhone2 :${controller.address[index].secondaryPhone}';
                                        });
                                      },
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              );
                            },
                          )),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: AddressForm(
                              address: null,
                            ));
                          });
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Colors.blueAccent.withOpacity(0.8))),
                    child: const Text(
                      'Add New Address',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
