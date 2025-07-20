import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sumer/model/user_model.dart';
import 'package:sumer/modules/admin/admin_controller.dart';
import 'package:sumer/modules/admin/users/widget/user_acc_info.dart';
import 'package:sumer/modules/admin/users/widget/user_address.dart';
import 'package:sumer/util/colors.dart';
import 'package:sumer/util/text_util.dart';

import '../order/order_details.dart';

class UsersInfo extends StatefulWidget {
  const UsersInfo({super.key, required this.user});

  final UserModel user;

  @override
  State<UsersInfo> createState() => _UsersInfoState();
}

var adminController = Get.find<AdminController>();

class _UsersInfoState extends State<UsersInfo> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Obx(() => SafeArea(
          child: Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: BackButton(
                        color: Theme.of(context).textTheme.displayLarge!.color,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextUtil(
                      text: widget.user.username,
                      size: 25,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    width > 1200
                        ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    headerWidget(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    userOrders(),
                                  ],
                                ),
                              ),
                              SizedBox(width: 25,),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      UserAccountPage(
                                        user: widget.user,
                                      ),
                                      UserAccountAddress(
                                        user: widget.user,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        :
                    Column(
                      children: [
                        headerWidget(),
                        SizedBox(
                          height: 10,
                        ),
                        userOrders(),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UserAccountPage(
                                user: widget.user,
                              ),
                              UserAccountAddress(
                                user: widget.user,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                  ],
                )),
              ),
            ),
          ),
        ));
  }

  Widget headerWidget() {
    var allOrder = Get.find<AdminController>().allUserInvoice;
    double totalSpending = allOrder.fold(0.0, (double sum, doc) {
      if (doc.status == 'Paid') {
        return sum + (doc.totalAmount);
      }
      return sum;
    });
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: secondaryColor.withAlpha(128),
                  radius: 30,
                  child: TextUtil(
                    text: widget.user.username[0].toUpperCase(),
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextUtil(
                      text: widget.user.username,
                      size: 20,
                      color: secondaryColor,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextUtil(
                      text:
                          "Joined in : ${DateFormat('MMMM dd,yyyy').format(widget.user.createdAt.toDate())}",
                      color: Colors.black54,
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextUtil(
                        text: 'Last Order',
                        size: 18,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Get.find<AdminController>().isLoadingOrder.value
                          ? Center(
                              child: CircularProgressIndicator(
                                color: secondaryColor,
                              ),
                            )
                          : TextUtil(
                              text: allOrder.isEmpty
                                  ? '-'
                                  : DateFormat('MMMM dd, yyyy').format(
                                      allOrder.first.createdAt.toDate()),
                              weight: false,
                              size: 13,
                            ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextUtil(
                        text: 'No. Of Order',
                        size: 18,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Get.find<AdminController>().isLoadingOrder.value
                          ? Center(
                              child: CircularProgressIndicator(
                                color: secondaryColor,
                              ),
                            )
                          : TextUtil(
                              text: allOrder.isEmpty
                                  ? '-'
                                  : "${allOrder.length} Orders",
                              weight: false,
                              size: 13,
                            ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextUtil(
                        text: 'Total Spent',
                        size: 18,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Get.find<AdminController>().isLoadingOrder.value
                          ? Center(
                              child: CircularProgressIndicator(
                                color: secondaryColor,
                              ),
                            )
                          : TextUtil(
                              text: allOrder.isEmpty
                                  ? '-'
                                  : "${totalSpending.toStringAsFixed(2)} AED",
                              weight: false,
                              size: 13,
                            ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget userOrders() {
    var allOrder = Get.find<AdminController>().allUserInvoice;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextUtil(
              text: 'User Orders',
              size: 20,
            ),
            SizedBox(
              height: 20,
            ),
            Get.find<AdminController>().isLoadingOrder.value
                ? SizedBox(
                    height: 300,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: secondaryColor,
                      ),
                    ),
                  )
                : allOrder.isEmpty
                    ? SizedBox(
                        height: 200,
                        child: Center(
                          child: TextUtil(
                            text: 'No Orders',
                            size: 25,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: allOrder.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => OrderDetails(
                                          invoice: allOrder[index],
                                          isUser: false,
                                        ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: allOrder[index].read ? Colors.transparent : Colors.black12.withAlpha(20),
                                      border: Border.all(color: Colors.black54),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  TextUtil(
                                                      text: allOrder[index]
                                                          .invoiceNumber),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.circle,
                                                        size: 8,
                                                        color: allOrder[index]
                                                                .status
                                                                .contains('Due')
                                                            ? Colors.grey
                                                            : Colors.green,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        allOrder[index].status,
                                                        style: TextStyle(
                                                            color: allOrder[index]
                                                                    .status
                                                                    .contains('Due')
                                                                ? Colors.grey
                                                                : Colors.green,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.circle,
                                                        size: 8,
                                                        color: !allOrder[index]
                                                                .delivered
                                                            ? errorColor
                                                            : Colors.green,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      TextUtil(
                                                        text: allOrder[index]
                                                                .delivered
                                                            ? 'Delivered'
                                                            : 'Not Delivered',
                                                        color: !allOrder[index]
                                                                .delivered
                                                            ? errorColor
                                                            : Colors.green,
                                                        size: 12,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              TextUtil(
                                                text: DateFormat('MMMM dd,yyyy')
                                                    .format(allOrder[index]
                                                        .createdAt
                                                        .toDate()),
                                                color: Colors.black54,
                                                size: 13,
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              TextUtil(
                                                text:
                                                    "${allOrder[index].totalAmount.toStringAsFixed(2)} AED",
                                                size: 13,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                Icons.arrow_forward,
                                                color: Colors.black,
                                                size: 15,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  allOrder[index].archived?Icon( Icons.archive , color: Colors.grey,):SizedBox(),
                                  Icon(allOrder[index].read ? Icons.mark_email_read_rounded : Icons.mark_email_unread , color: allOrder[index].read ?Colors.green:Colors.grey,),
                                ],
                              )

                            ],
                          );
                        })
          ],
        ),
      ),
    );
  }
}
