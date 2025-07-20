import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumer/model/user_model.dart';
import 'package:sumer/modules/checkout/controller/checkout_controller.dart';
import 'package:sumer/util/colors.dart';
import 'package:sumer/util/text_util.dart';

import '../../../checkout/view/add_address_dialog.dart';

class UserAccountAddress extends StatefulWidget {
  const UserAccountAddress({super.key, required this.user});

  final UserModel user;

  @override
  State<UserAccountAddress> createState() => _UserAccountAddressState();
}

final controller = Get.find<CheckoutController>();

class _UserAccountAddressState extends State<UserAccountAddress> {
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
                'User Address',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold , color: Colors.black  ),
              ),
            ),
            Obx(() => controller.addressDetails.isEmpty
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
                          itemCount: controller.addressDetails.length,
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
                                              '${controller.addressDetails[index].country}\n${controller.addressDetails[index].city}\n${controller.addressDetails[index].address}\n${controller.addressDetails[index].apartment}\nPhone2 :${controller.addressDetails[index].secondaryPhone}',
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
                                                                    .addressDetails[
                                                                index],
                                                            user: widget.user,
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
                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: true,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              Colors.white,
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
                                                                        WidgetStatePropertyAll(Colors
                                                                            .redAccent)),
                                                                child:
                                                                    const Text(
                                                                  'No',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                )),
                                                            Obx(
                                                              () => controller
                                                                      .loading
                                                                      .value
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
                                                                        await Get.find<CheckoutController>().deleteAddress(
                                                                            addressId:
                                                                                controller.addressDetails[index].id,
                                                                            userId1: widget.user.id);
                                                                        await Get.find<CheckoutController>().getAllAddressForUser(
                                                                            userId:
                                                                                widget.user.id);
                                                                        Get.back();
                                                                      },
                                                                      style: const ButtonStyle(
                                                                          backgroundColor: WidgetStatePropertyAll(Colors
                                                                              .blueAccent)),
                                                                      child:
                                                                          const Text(
                                                                        'Yes',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
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
                          user: widget.user,
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
