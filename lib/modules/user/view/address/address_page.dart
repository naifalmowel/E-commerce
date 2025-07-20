import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumer/modules/checkout/controller/checkout_controller.dart';
import 'package:sumer/util/colors.dart';
import 'package:sumer/util/constant.dart';
import 'package:sumer/util/text_util.dart';

import '../../../checkout/view/add_address_dialog.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

final controller = Get.find<CheckoutController>();

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'My Address',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(() => controller.address.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextUtil(
                        text: 'No Address Found , Please Add New Address.',
                        size: 15,
                        color: Colors.black54,
                        weight: true,
                      ),
                    ),
                  )
                : controller.loading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.blueAccent,
                      ))
                    : SizedBox(
                        width:
                            MediaQuery.of(context).size.width < 800 ? 400 : 600,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.address.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Container(
                                width: MediaQuery.of(context).size.width < 800
                                    ? 400
                                    : 600,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color:
                                            Colors.blueAccent.withOpacity(0.2),
                                        width: 2),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: TextUtil(
                                          text:
                                              '${controller.address[index].country}\n${controller.address[index].city}\n${controller.address[index].address}\n${controller.address[index].apartment}\nPhone2 :${controller.address[index].secondaryPhone}',
                                          color: Colors.black,
                                          size: 15,
                                          weight: false,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return Dialog(
                                                              child:
                                                                  AddressForm(
                                                            address: controller
                                                                .address[index],
                                                          ));
                                                        });
                                                  },
                                                  icon: Icon(
                                                    Icons.edit,
                                                    color: secondaryColor,
                                                  )),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: IconButton(
                                                  onPressed: () {
                                                    Constant.confirmDialog(
                                                        context,
                                                        'Delete Address',
                                                        () async {
                                                      await Get.find<
                                                              CheckoutController>()
                                                          .deleteAddress(
                                                              addressId:
                                                                  controller
                                                                      .address[
                                                                          index]
                                                                      .id);
                                                      Get.back();
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.redAccent,
                                                  )),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  controller.country('');
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
                    backgroundColor: WidgetStatePropertyAll(secondaryColor)),
                child: const Text(
                  'Add New Address',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
