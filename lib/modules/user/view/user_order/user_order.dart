import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sumer/modules/admin/admin_controller.dart';
import 'package:sumer/modules/checkout/controller/checkout_controller.dart';
import 'package:sumer/modules/user/controller/user_controller.dart';
import 'package:sumer/util/colors.dart';
import 'package:sumer/util/constant.dart';
import 'package:sumer/util/text_util.dart';

import '../../../../util/scroll_config.dart';
import '../../../admin/order/order_details.dart';
import '../../../checkout/view/add_address_dialog.dart';

class UserOrder extends StatefulWidget {
  const UserOrder({super.key});

  @override
  State<UserOrder> createState() => _UserOrderState();
}

final controller = Get.find<AdminController>();
final ScrollController scrollController = ScrollController();
class _UserOrderState extends State<UserOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: RefreshIndicator(
        backgroundColor: secondaryColor,
        color: Colors.white,
        onRefresh: ()async{
          Get.find<AdminController>().getAllInvoiceForUser(userId: Get.find<UserController>().userId.value);
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Orders',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(onPressed: ()async{
                      Get.find<AdminController>().getAllInvoiceForUser(userId: Get.find<UserController>().userId.value);
                    }, icon: Icon(Icons.refresh) , color: secondaryColor,)
                  ],
                ),
              ),
              Obx(() => controller.allUserInvoice.isEmpty
                  ? SizedBox(
                height: 300,
                    child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextUtil(
                            text: 'No Order',
                            size: 25,
                            color: Colors.black54,
                            weight: true,
                          ),
                        ),
                      ),
                  )
                  : controller.isLoadingOrder.value
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: Colors.blueAccent,
                        ))
                      : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.allUserInvoice.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: InkWell(
                              onTap: (){
                                Get.to(()=>OrderDetails(invoice: controller.allUserInvoice[index], isUser: true,));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width < 800
                                    ? 400
                                    : 500,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color:
                                            Colors.blueAccent.withAlpha(50),
                                        width: 2),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20))),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextUtil(
                                            text: controller
                                                .allUserInvoice[index]
                                                .invoiceNumber,
                                            size: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                size: 10,
                                                color: !controller
                                                        .allUserInvoice[index]
                                                        .delivered
                                                    ? errorColor
                                                    : Colors.green,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              TextUtil(
                                                text: controller
                                                        .allUserInvoice[index]
                                                        .delivered
                                                    ? 'Delivered'
                                                    : 'Not Delivered',
                                                color: !controller
                                                        .allUserInvoice[index]
                                                        .delivered
                                                    ? errorColor
                                                    : Colors.green,
                                                size: 15,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color: Colors.black,
                                                size: 15,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8,),
                                      TextUtil(
                                          text:
                                              DateFormat('yyyy/MM/dd hh:mm aaa')
                                                  .format(controller
                                                      .allUserInvoice[index]
                                                      .createdAt
                                                      .toDate()) , weight: false,color: Colors.black54,),
                                      SizedBox(
                                        height: 120,
                                        child: ScrollConfiguration(
                                          behavior: MyCustomScrollBehavior(),
                                          child: ListView.builder(
                                            controller: scrollController,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            padding: const EdgeInsets.all(16),
                                            itemCount: controller.allUserInvoice[index].items.length,
                                            itemBuilder: (context, index1) {
                                              var item = controller.allUserInvoice[index].items[index1];
                                              return Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Badge(
                                                  label: Text(
                                                    item.quantity.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 15, color: Colors.white),
                                                  ),
                                                  backgroundColor: secondaryColor.withAlpha(200),
                                                  child: Container(
                                                    width: 70,
                                                    height: 120,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 1,
                                                        color:Colors.grey,
                                                      ),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(10),
                                                      child: Image.network(
                                                        item.image,
                                                        fit: BoxFit.contain,
                                                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                                          if (loadingProgress == null) {
                                                            return child; // الصورة تم تحميلها بنجاح
                                                          } else {
                                                            return Center(
                                                              child: CircularProgressIndicator(),
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
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          TextUtil(text: '${controller.allUserInvoice[index].items.length} Items' , weight: true,),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(decoration: BoxDecoration(color: Colors.black54),width: 3,height: 15,),
                                          ),

                                          TextUtil(text: '${controller.allUserInvoice[index].totalAmount.toStringAsFixed(2)} AED'),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
